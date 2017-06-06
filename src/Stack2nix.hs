{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix
  ( Args(..)
  , Package(..)
  , RemotePkgConf(..)
  , StackConfig(..)
  , parseStackYaml
  , stack2nix
  ) where

import           Control.Concurrent.Async
import           Control.Concurrent.MSem
import           Control.Exception          (SomeException, catch)
import           Control.Monad              (unless)
import qualified Data.ByteString            as BS
import           Data.Fix                   (Fix (..))
import           Data.Foldable              (traverse_)
import           Data.List                  (foldl', sort)
import qualified Data.Map.Strict            as Map
import           Data.Maybe                 (fromMaybe)
import           Data.Monoid                ((<>))
import           Data.Text                  (Text, pack, unpack)
import qualified Data.Traversable           as T
import           Data.Yaml                  (FromJSON (..), (.!=), (.:), (.:?))
import qualified Data.Yaml                  as Y
import           Nix.Expr                   (Binding (..), NExpr, NExprF (..),
                                             NKeyName (..), ParamSet (..),
                                             Params (..))
import           Nix.Parser                 (Result (..), parseNixFile)
import           Nix.Pretty                 (prettyNix)
import           Stack2nix.External         (cabal2nix)
import           Stack2nix.External.Util    (runCmdFrom)
import           Stack2nix.External.VCS.Git (Command (..), ExternalCmd (..),
                                             InternalCmd (..), git)
import           System.Directory           (doesFileExist)
import           System.FilePath            (dropExtension, isAbsolute,
                                             normalise, takeDirectory,
                                             takeFileName, (</>))
import           System.FilePath.Glob       (glob)
import           System.IO.Temp             (withSystemTempDirectory)

data Args = Args
  { argRev     :: Maybe String
  , argOutFile :: Maybe FilePath
  , argUri     :: String
  }
  deriving (Show)

data StackConfig = StackConfig
  { resolver  :: Text
  , packages  :: [Package]
  , extraDeps :: [Text]
  }
  deriving (Show, Eq)

data Package = LocalPkg FilePath
             | RemotePkg RemotePkgConf
             deriving (Show, Eq)

data RemotePkgConf = RemotePkgConf
  { gitUrl   :: Text
  , commit   :: Text
  , extraDep :: Bool
  }
  deriving (Show, Eq)

instance FromJSON StackConfig where
  parseJSON (Y.Object v) =
    StackConfig <$>
    v .: "resolver" <*>
    v .: "packages" <*>
    v .: "extra-deps"
  parseJSON _ = fail "Expected Object for StackConfig value"

instance FromJSON Package where
  parseJSON (Y.String v) = return $ LocalPkg $ unpack v
  parseJSON obj@(Y.Object _) = RemotePkg <$> parseJSON obj
  parseJSON _ = fail "Expected String or Object for Package value"

instance FromJSON RemotePkgConf where
  parseJSON (Y.Object v) = do
    loc <- v .: "location"
    gitUrl <- loc .: "git"
    commit <- loc .: "commit"
    extra <- v .:? "extra-dep" .!= False
    return $ RemotePkgConf gitUrl commit extra
  parseJSON _ = fail "Expected Object for RemotePkgConf value"

parseStackYaml :: BS.ByteString -> Maybe StackConfig
parseStackYaml = Y.decode

-- TODO: expose as CLI option
packageRenameMap :: Map.Map Text Text
packageRenameMap =
  Map.fromList [ ("servant", "servant_0_10")
               , ("servant-swagger", "servant-swagger_1_1_2_1")
               , ("servant-server", "servant-server_0_10")
               ]

stack2nix :: Args -> IO ()
stack2nix args@Args{..} = do
  isLocalRepo <- doesFileExist $ argUri </> "stack.yaml"
  if isLocalRepo
  then handleStackConfig Nothing argUri
  else withSystemTempDirectory "s2n-" $ \tmpDir ->
    tryGit tmpDir >> handleStackConfig (Just argUri) tmpDir
  where
    tryGit :: FilePath -> IO ()
    tryGit tmpDir = do
      git $ OutsideRepo $ Clone argUri tmpDir
      case argRev of
        Just r  -> git $ InsideRepo tmpDir $ Checkout r
        Nothing -> return mempty

    handleStackConfig :: Maybe String -> FilePath -> IO ()
    handleStackConfig remoteUri localDir = do
      let fname = localDir </> "stack.yaml"
      alreadyExists <- doesFileExist fname
      unless alreadyExists $ runCmdFrom localDir "stack" ["init", "--system-ghc"]
                             >> return ()
      contents <- BS.readFile fname
      case parseStackYaml contents of
        Just config -> toNix args remoteUri localDir config
        Nothing     -> error $ "Failed to parse " <> (localDir </> "stack.yaml")

applyRenameMap :: Map.Map Text Text -> [FilePath] -> IO ()
applyRenameMap nameMap = traverse_ renamePkgs
  where
    renamePkgs :: FilePath -> IO ()
    renamePkgs nixFile = do
      nf <- parseNixFile nixFile
      case nf of
        Success expr ->
          writeFile nixFile $ show $ prettyNix $ patch expr
        _ -> return ()          -- TODO: print warning, fail, or return Left error

    patch :: NExpr -> NExpr
    patch (Fix (NAbs (ParamSet (FixedParamSet paramMap) x)
                (Fix (NApp mkDeriv (Fix (NSet args)))))) =
      Fix (NAbs (ParamSet (FixedParamSet $ patchParams paramMap) x)
                (Fix (NApp mkDeriv (Fix (NSet $ patchArgs args)))))
    patch x = x

    patchParams :: Map.Map Text (Maybe r) -> Map.Map Text (Maybe r)
    patchParams = Map.mapKeys $ \k -> Map.findWithDefault k k nameMap

    patchArgs :: [Binding (Fix NExprF)] -> [Binding (Fix NExprF)]
    patchArgs = fmap $ \x ->
                        case x of
                          NamedVar k (Fix (NList names)) ->
                            NamedVar k (Fix (NList $ fmap (\y ->
                                                             case y of
                                                               Fix (NSym name) -> Fix . NSym $ Map.findWithDefault name name nameMap
                                                               _ -> y) names))
                          _ -> x

-- Credit: https://stackoverflow.com/a/18898822/204305
mapPool :: T.Traversable t => Int -> (a -> IO b) -> t a -> IO (t b)
mapPool max' f xs = do
  sem <- new max'
  mapConcurrently (with sem . f) xs

c2nPoolSize :: Int
c2nPoolSize = 4

toNix :: Args -> Maybe String -> FilePath -> StackConfig -> IO ()
toNix args@Args{..} remoteUri baseDir StackConfig{..} =
  withSystemTempDirectory "s2n" $ \outDir -> do
    _ <- mapPool c2nPoolSize (genNixFile outDir) packages
    overrides <- mapPool c2nPoolSize overrideFor =<< updateDeps outDir
    _ <- mapPool c2nPoolSize (genNixFile outDir) packages
    applyRenameMap packageRenameMap =<< glob (outDir </> "*.nix")
    writeFile (outDir </> "initialPackages.nix") $ initialPackages $ sort overrides
    pullInNixFiles $ outDir </> "initialPackages.nix"
    nf <- parseNixFile $ outDir </> "initialPackages.nix"
    case nf of
      Success expr ->
        case argOutFile of
          Just fname -> writeFile fname $ defaultNix expr
          Nothing    -> putStrLn $ defaultNix expr
      _ -> error "failed to parse intermediary initialPackages.nix file"
      where
        updateDeps :: FilePath -> IO [FilePath]
        updateDeps outDir = do
          putStrLn $ "Updating deps from " ++ baseDir
          result <- runCmdFrom baseDir "stack" ["list-dependencies", "--system-ghc", "--separator", "-"]
          case result of
            Right pkgs -> do
              putStrLn "Haskell dependencies:"
              mapM_ putStrLn $ lines pkgs
              _ <- mapPool c2nPoolSize (\d -> catch (handleExtraDep outDir d) ignoreError) $ pack <$> lines pkgs
              return ()
            Left err -> error $ unlines ["FAILED: stack list-dependencies", err]
          glob (outDir </> "*.nix")

        -- TODO: Remove this.
        ignoreError :: SomeException -> IO ()
        ignoreError _ = return ()

        genNixFile :: FilePath -> Package -> IO ()
        genNixFile outDir (LocalPkg relPath) =
          cabal2nix (fromMaybe baseDir remoteUri) (pack <$> argRev) (Just relPath) (Just outDir)
        genNixFile outDir (RemotePkg RemotePkgConf{..}) =
          cabal2nix (unpack gitUrl) (Just commit) Nothing (Just outDir)

        handleExtraDep :: FilePath -> Text -> IO ()
        handleExtraDep outDir dep =
          cabal2nix ("cabal://" <> unpack dep) Nothing Nothing (Just outDir)

        nameOf :: FilePath -> String
        nameOf fname =
          let defaultName = pack $ dropExtension . takeFileName $ fname
          in
            unpack $ Map.findWithDefault defaultName defaultName packageRenameMap

        overrideFor :: FilePath -> IO String
        overrideFor nixFile = do
          putStrLn $ "Generating override for " <> nixFile
          deps <- externalDeps
          return $ "    " <> nameOf nixFile <> " = callPackage ./" <> takeFileName nixFile <> " { " <> deps <> " };"
          where
            externalDeps :: IO String
            externalDeps = do
              deps <- librarySystemDeps nixFile
              return . unwords $ fmap (\d -> d <> " = pkgs." <> d <> ";") deps

        pullInNixFiles :: FilePath -> IO ()
        pullInNixFiles nixFile = do
          nf <- parseNixFile nixFile
          case nf of
            Success expr ->
              case expr of
                Fix (NAbs paramSet (Fix (NAbs fnParam (Fix (NSet attrs))))) -> do
                  attrs' <- mapM patchAttr attrs
                  let expr' = Fix (NAbs paramSet (Fix (NAbs fnParam (Fix (NSet attrs')))))
                  writeFile nixFile $ (++ "\n") $ show $ prettyNix expr'
                _ ->
                  error $ "unhandled nix expression format\n" ++ show expr
            _ -> error "failed to parse nix file!"
            where
              patchAttr :: Binding (Fix NExprF) -> IO (Binding (Fix NExprF))
              patchAttr attr =
                case attr of
                  NamedVar k (Fix (NApp (Fix (NApp (Fix (NSym "callPackage")) pkg)) deps)) -> do
                    pkg' <- patchPkgRef pkg
                    return $ NamedVar k (Fix (NApp (Fix (NApp (Fix (NSym "callPackage")) pkg')) deps))
                  _ -> error $ "unhandled NamedVar"

              patchPkgRef (Fix (NLiteralPath path)) = do
                let p = if isAbsolute path then path else normalise $ takeDirectory nixFile </> path
                nf <- parseNixFile p
                case nf of
                  Success expr -> return expr
                  _ -> error $ "failed to parse referenced nix file '" ++ path ++ "'"
              patchPkgRef x                   = return x

        librarySystemDeps :: FilePath -> IO [String]
        librarySystemDeps nixFile = do
          nf <- parseNixFile nixFile
          case nf of
            Success expr ->
              case expr of
                Fix (NAbs _ (Fix (NApp _ (Fix (NSet namedVars))))) ->
                  case lookupNamedVar namedVars "librarySystemDepends" of
                    Just (Fix (NList deps)) ->
                      return $ foldl' (\acc x ->
                                         case x of
                                           Fix (NSym name) -> unpack name : acc
                                           _               -> acc) [] deps
                    _ -> return []
                _ -> return []
            _ -> return []

        lookupNamedVar :: [Binding a] -> String -> Maybe a
        lookupNamedVar [] _ = Nothing
        lookupNamedVar (x:xs) name =
          case x of
            NamedVar [StaticKey k] val ->
              if unpack k == name
              then Just val
              else lookupNamedVar xs name
            _ -> lookupNamedVar xs name

        initialPackages overrides = unlines $
          [ "{ pkgs, stdenv, callPackage }:"
          , ""
          , "self: {"
          ] ++ overrides ++
          [ "}"
          ]

        defaultNix pkgsNixExpr = unlines
          [ "{ pkgs ? (import <nixpkgs> {})"
          , ", compiler ? pkgs.haskell.packages.ghc802"
          , ", ghc ? pkgs.haskell.compiler.ghc802"
          , "}:"
          , ""
          , "with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit pkgs; });"
          , ""
          , "let"
          , "  hackagePackages = import <nixpkgs/pkgs/development/haskell-modules/hackage-packages.nix>;"
          , "  stackPackages = " ++ show (prettyNix pkgsNixExpr) ++ ";"
          , "in"
          , "compiler.override {"
          , "  initialPackages = (args: self: (hackagePackages args self) // (stackPackages args self));"
          , "}"
          ]

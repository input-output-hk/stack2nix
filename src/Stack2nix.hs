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

import           Control.Exception          (SomeException, catch)
import qualified Data.ByteString            as BS
import           Data.Fix                   (Fix (..))
import           Data.Foldable              (traverse_)
import           Data.List                  (foldl')
import qualified Data.Map.Strict            as Map
import           Data.Maybe                 (fromMaybe)
import           Data.Monoid                ((<>))
import           Data.Text                  (Text, pack, unpack)
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
import           System.FilePath            (dropExtension, takeFileName, (</>))
import           System.FilePath.Glob       (glob)
import           System.IO.Temp             (withSystemTempDirectory)

data Args = Args
  { argRev :: Maybe String
  , argUri :: String
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

packageRenameMap :: Map.Map Text Text
packageRenameMap =
  Map.fromList [ ("servant", "servant_0_10")
               , ("servant-swagger", "servant-swagger_1_1_2_1")
               , ("servant-server", "servant-server_0_10")
               ]

-- TODO: Factor out pure parts.
stack2nix :: Args -> IO ()
stack2nix Args{..} = do
  isLocalRepo <- doesFileExist (argUri </> "stack.yaml")
  if isLocalRepo
  then handleStackConfig Nothing argUri
  else withSystemTempDirectory "s2n-" (\tmpDir ->
    tryGit tmpDir >> handleStackConfig (Just argUri) tmpDir)
  where
    tryGit :: FilePath -> IO ()
    tryGit tmpDir = do
      git (OutsideRepo (Clone argUri tmpDir))
      case argRev of
        Just r  -> git (InsideRepo tmpDir (Checkout r))
        Nothing -> return mempty

    handleStackConfig :: Maybe String -> FilePath -> IO ()
    handleStackConfig remoteUri localDir =
      BS.readFile (localDir </> "stack.yaml") >>= \contents ->
      case parseStackYaml contents of
        Just config -> toNix remoteUri localDir argRev config
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
    patchParams = Map.mapKeys (\k -> Map.findWithDefault k k nameMap)

    patchArgs :: [Binding (Fix NExprF)] -> [Binding (Fix NExprF)]
    patchArgs = fmap (\x ->
                        case x of
                          NamedVar k (Fix (NList names)) ->
                            NamedVar k (Fix (NList $ fmap (\y ->
                                                             case y of
                                                               Fix (NSym name) -> Fix . NSym $ Map.findWithDefault name name nameMap
                                                               _ -> y) names))
                          _ -> x)

toNix :: Maybe String -> FilePath -> Maybe String -> StackConfig -> IO ()
toNix remoteUri baseDir rev StackConfig{..} = do
  traverse_ genNixFile packages
  overrides <- mapM overrideFor =<< updateDeps
  traverse_ genNixFile packages
  applyRenameMap packageRenameMap =<< glob "*.nix"
  writeFile "initialPackages.nix" $ initialPackages overrides
  writeFile "default.nix" defaultNix
    where
      updateDeps :: IO [FilePath]
      updateDeps = do
        putStrLn $ "Updating deps from " ++ baseDir
        result <- runCmdFrom baseDir "stack" ["list-dependencies", "--separator", "-", "--no-include-base", "--test", "--bench"]
        case result of
          Right pkgs -> mapM_ (\d -> catch (handleExtraDep d) ignoreError) $ pack <$> lines pkgs
          Left _ -> error "FAILED: stack list-dependencies"
        glob "*.nix"

      -- TODO: Remove this.
      ignoreError :: SomeException -> IO ()
      ignoreError _ = return ()

      genNixFile :: Package -> IO ()
      genNixFile (LocalPkg relPath) =
        cabal2nix (fromMaybe baseDir remoteUri) (pack <$> rev) (Just relPath)
      genNixFile (RemotePkg RemotePkgConf{..}) =
        cabal2nix (unpack gitUrl) (Just commit) Nothing

      handleExtraDep :: Text -> IO ()
      handleExtraDep dep =
        cabal2nix ("cabal://" <> unpack dep) Nothing Nothing

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

      defaultNix = unlines
        [ "{ pkgs ? (import <nixpkgs> {})"
        , ", compiler ? pkgs.haskell.packages.ghc802"
        , ", ghc ? pkgs.haskell.compiler.ghc802"
        , "}:"
        , ""
        , "with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit pkgs; });"
        , ""
        , "compiler.override {"
        , "  initialPackages = makePackageSet {"
        , "    package-set = import ./initialPackages.nix;"
        , "    inherit ghc;"
        , "  };"
        , "}"
        ]

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

{-# OPTIONS_GHC -Wall -Wno-type-defaults #-}

module Stack2nix
  ( Args(..)
  , Package(..)
  , RemotePkgConf(..)
  , StackConfig(..)
  , parseStackYaml
  , stack2nix
  , version
  ) where

import           Control.Concurrent.Async
import           Control.Concurrent.MSem
import           Control.Exception            (SomeException, catch,
                                               onException)
import           Control.Monad                (unless)
import qualified Data.ByteString              as BS
import           Data.Fix                     (Fix (..))
import           Data.List                    (foldl', sort, union, (\\))
import qualified Data.Map.Strict              as Map
import           Data.Maybe                   (fromMaybe, listToMaybe)
import           Data.Monoid                  ((<>))
import           Data.Text                    (Text, pack, unpack)
import qualified Data.Traversable             as T
import           Data.Version                 (Version (..), parseVersion,
                                               showVersion)
import           Data.Yaml                    (FromJSON (..), (.!=), (.:),
                                               (.:?))
import qualified Data.Yaml                    as Y
import           Distribution.Text            (display)
import           Nix.Expr                     (Binding (..), NExpr, NExprF (..),
                                               NKeyName (..), ParamSet (..),
                                               Params (..))
import           Nix.Parser                   (Result (..), parseNixFile,
                                               parseNixString)
import           Nix.Pretty                   (prettyNix)
import           Paths_stack2nix              (version)
import           Stack2nix.External           (cabal2nix)
import           Stack2nix.External.Util      (runCmd, runCmdFrom)
import           Stack2nix.External.VCS.Git   (Command (..), ExternalCmd (..),
                                               InternalCmd (..), git)
import           System.Directory             (doesFileExist)
import           System.Environment           (getEnv)
import           System.FilePath              (dropExtension, isAbsolute,
                                               normalise, takeDirectory,
                                               takeFileName, (</>))
import           System.FilePath.Glob         (glob)
import           System.IO                    (hPutStrLn, stderr, stdout)
import           System.IO.Temp               (withSystemTempDirectory)
import           Text.ParserCombinators.ReadP (readP_to_S)

import           Stack2nix.Types


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

checkRuntimeDeps :: Args -> IO ()
checkRuntimeDeps args = do
  checkVer "cabal2nix" "2.2.1"
  checkVer "git" "2"
  checkVer "cabal" "1"
  where
    checkVer prog minVer = do
      hPutStrLn stderr $ unwords ["Ensuring", prog, "version is >=", minVer, "..."]
      (result, stdout, stderr) <- runCmd args prog ["--version"] `onException` (error $ "Failed to run " ++ prog ++ ". Not found in PATH.")
      if result
      then let
             -- heuristic for parsing version from stdout
             firstLine = head . lines
             lastWord = head . reverse . words
             ver = parseVer . lastWord . firstLine $ stdout
           in unless (ver >= parseVer minVer) $ error $ unwords ["ERROR:", prog, "version must be", minVer, "or higher. Current version:", maybe "[parse failure]" showVersion ver]
      else error stderr

    parseVer :: String -> Maybe Version
    parseVer =
      fmap fst . listToMaybe . reverse . readP_to_S parseVersion

stack2nix :: Args -> IO ()
stack2nix args@Args{..} = do
  checkRuntimeDeps args
  updateCabalPackageIndex
  isLocalRepo <- doesFileExist $ argUri </> "stack.yaml"
  if isLocalRepo
  then handleStackConfig Nothing argUri
  else withSystemTempDirectory "s2n-" $ \tmpDir ->
    tryGit tmpDir >> handleStackConfig (Just argUri) tmpDir
  where
    updateCabalPackageIndex :: IO ()
    updateCabalPackageIndex =
      getEnv "HOME" >>= \home -> runCmdFrom args home "cabal" ["update"] >> return ()

    tryGit :: FilePath -> IO ()
    tryGit tmpDir = do
      git args $ OutsideRepo $ Clone argUri tmpDir
      case argRev of
        Just r  -> git args $ InsideRepo tmpDir $ Checkout r
        Nothing -> return mempty

    handleStackConfig :: Maybe String -> FilePath -> IO ()
    handleStackConfig remoteUri localDir = do
      let fname = localDir </> "stack.yaml"
      alreadyExists <- doesFileExist fname
      unless alreadyExists $ runCmdFrom args localDir "stack" ["init", "--system-ghc"]
                             >> return ()
      contents <- BS.readFile fname
      case parseStackYaml contents of
        Just config -> toNix args remoteUri localDir config
        Nothing     -> error $ "Failed to parse " <> (localDir </> "stack.yaml")

-- Credit: https://stackoverflow.com/a/18898822/204305
mapPool :: T.Traversable t => Args -> (a -> IO b) -> t a -> IO (t b)
mapPool Args{..} f xs =
  if argSerialise
    then  traverse f xs
    else do
    sem <- new 4
    mapConcurrently (with sem . f) xs

toNix :: Args -> Maybe String -> FilePath -> StackConfig -> IO ()
toNix args@Args{..} remoteUri baseDir StackConfig{..} =
  withSystemTempDirectory "s2n" $ \outDir -> do
    _ <- mapPool args (genNixFile outDir) packages
    overrides <- mapPool args overrideFor =<< updateDeps outDir
    _ <- mapPool args (genNixFile outDir) packages
    _ <- mapPool args patchNixFile =<< glob (outDir </> "*.nix")
    writeFile (outDir </> "initialPackages.nix") $ initialPackages $ sort overrides
    pullInNixFiles $ outDir </> "initialPackages.nix"
    nf <- parseNixFile $ outDir </> "initialPackages.nix"
    case nf of
      Success expr ->
        case argOutFile of
          Just fname -> writeFile fname $ defaultNix expr
          Nothing    -> hPutStrLn stdout $ defaultNix expr
      _ -> error "failed to parse intermediary initialPackages.nix file"
      where
        updateDeps :: FilePath -> IO [FilePath]
        updateDeps outDir = do
          hPutStrLn stderr $ "Updating deps from " ++ baseDir
          (result, stdout, stderr') <- runCmdFrom args baseDir "stack" ["list-dependencies", "--system-ghc", "--separator", "-"]
          if result
          then do
            let pkgs' = ["hscolour", "jailbreak-cabal", "cabal-doctest", "happy", "stringbuilder"] ++ lines stdout
            hPutStrLn stderr "Haskell dependencies:"
            mapM_ (hPutStrLn stderr) pkgs'
            _ <- mapPool args (\d -> catch (handleExtraDep outDir d) ignoreError) $ pack <$> pkgs'
            return ()
          else error $ unlines ["FAILED: stack list-dependencies", stderr']
          glob (outDir </> "*.nix")

        -- TODO: Remove this.
        ignoreError :: SomeException -> IO ()
        ignoreError _ = return ()

        genNixFile :: FilePath -> Package -> IO ()
        genNixFile outDir (LocalPkg relPath) =
          cabal2nix args (fromMaybe baseDir remoteUri) (pack <$> argRev) (Just relPath) (Just outDir)
        genNixFile outDir (RemotePkg RemotePkgConf{..}) =
          cabal2nix args (unpack gitUrl) (Just commit) Nothing (Just outDir)

        patchNixFile :: FilePath -> IO ()
        patchNixFile fname = do
          contents <- readFile fname
          case parseNixString contents of
            Success expr ->
              case takeFileName fname of
                "hspec.nix" -> do
                  writeFile fname $ show $ prettyNix $ (addParam "stringbuilder" . stripNonEssentialDeps) expr
                _ -> writeFile fname $ show $ prettyNix $ stripNonEssentialDeps expr
            _ -> error "failed to parse intermediary nix package file"

        addParam :: String -> NExpr -> NExpr
        addParam param expr =
          let contents = show $ prettyNix expr
              (l:ls) = lines contents
              (openBrace, params) = splitAt 1 (words l)
              l' = unwords $ openBrace ++ [param ++ ", "] ++ params
          in
          case parseNixString $ unlines (l':ls) of
            Success expr' -> expr'
            _             -> expr

        stripNonEssentialDeps :: NExpr -> NExpr
        stripNonEssentialDeps expr =
          let sectsToDrop = ["testHaskellDepends", "testToolDepends", "benchmarkHaskellDepends", "benchmarkToolDepends"]
              sectsToKeep = ["executableHaskellDepends", "executableToolDepends", "libraryHaskellDepends", "librarySystemDepends", "libraryToolDepends", "setupHaskellDepends"]
              collectDeps sects = foldr union [] $ fmap (dependenciesFromSection expr) sects
              depsToStrip = collectDeps sectsToDrop \\ collectDeps sectsToKeep
              expr' = foldl dropDependencySection expr sectsToDrop
          in
          dropParams expr' depsToStrip

        handleExtraDep :: FilePath -> Text -> IO ()
        handleExtraDep outDir dep =
          cabal2nix args ("cabal://" <> unpack dep) Nothing Nothing (Just outDir)

        overrideFor :: FilePath -> IO String
        overrideFor nixFile = do
          deps <- externalDeps
          return $ "    " <> (dropExtension . takeFileName) nixFile <> " = callPackage ./" <> takeFileName nixFile <> " { " <> deps <> " };"
          where
            externalDeps :: IO String
            externalDeps = do
              deps <- librarySystemDeps nixFile
              return . unwords $ fmap (\d -> unpack d <> " = pkgs." <> unpack d <> ";") deps

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

        dependenciesFromSection :: NExpr -> String -> [Text]
        dependenciesFromSection expr name = do
          case expr of
            Fix (NAbs _ (Fix (NApp _ (Fix (NSet namedVars))))) ->
              case lookupNamedVar namedVars name of
                Just (Fix (NList deps)) ->
                  foldl' (\acc x ->
                            case x of
                              Fix (NSym n) -> n : acc
                              _            -> acc) [] deps
                _ -> []
            _ -> []

        librarySystemDeps :: FilePath -> IO [Text]
        librarySystemDeps nixFile = do
          nf <- parseNixFile nixFile
          case nf of
            Success expr -> return $ dependenciesFromSection expr "librarySystemDepends"
            _            -> return []

        dropDependencySection :: NExpr -> String -> NExpr
        dropDependencySection expr name =
          case expr of
            Fix (NAbs a (Fix (NApp b (Fix (NSet namedVars))))) ->
              Fix (NAbs a (Fix (NApp b (Fix (NSet $ dropNamedVar namedVars name)))))
            _ -> expr

        lookupNamedVar :: [Binding a] -> String -> Maybe a
        lookupNamedVar [] _ = Nothing
        lookupNamedVar (x:xs) name =
          case x of
            NamedVar [StaticKey k] val ->
              if unpack k == name
              then Just val
              else lookupNamedVar xs name
            _ -> lookupNamedVar xs name

        dropNamedVar :: [Binding a] -> String -> [Binding a]
        dropNamedVar xs name = filter differentName xs
          where
            differentName (NamedVar [StaticKey k] _) = unpack k /= name
            differentName _                          = True

        dropParams :: NExpr -> [Text] -> NExpr
        dropParams (Fix (NAbs (ParamSet (FixedParamSet paramMap) x)
                    (Fix (NApp mkDeriv (Fix (NSet args')))))) names =
          Fix (NAbs (ParamSet (FixedParamSet $ foldr Map.delete paramMap names) x)
                    (Fix (NApp mkDeriv (Fix (NSet args')))))
        dropParams x _ = x

        initialPackages overrides = unlines $
          [ "{ pkgs, stdenv, callPackage }:"
          , ""
          , "self: {"
          ] ++ overrides ++
          [ "}"
          ]

        defaultNix pkgsNixExpr = unlines
          [ "# Generated using stack2nix " ++ "" ++ "."
          , "#"
          , "# Only works with sufficiently recent nixpkgs, e.g. \"NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/21a8239452adae3a4717772f4e490575586b2755.tar.gz\"."
          , ""
          , "{ pkgs ? (import <nixpkgs> {})"
          , ", compiler ? pkgs.haskell.packages.ghc802"
          , ", ghc ? pkgs.haskell.compiler.ghc802"
          , "}:"
          , ""
          , "with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit pkgs; });"
          , ""
          , "let"
          , "  stackPackages = " ++ show (prettyNix pkgsNixExpr) ++ ";"
          , "in"
          , "compiler.override {"
          , "  initialPackages = stackPackages;"
          , "  configurationCommon = { ... }: self: super: {};"
          , "}"
          ]

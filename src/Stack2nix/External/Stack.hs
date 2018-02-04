{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE DataKinds         #-}

module Stack2nix.External.Stack
  ( PackageRef(..), runPlan
  ) where

import           Control.Applicative           ((<|>))
import           Data.List                     (concat)
import qualified Data.Map.Strict               as M
import           Data.Maybe                    (fromJust)
import           Data.Text                     (pack, unpack)
import           Options.Applicative
import           Stack.Build.Source            (loadSourceMapFull)
import           Stack.Build.Target            (NeedTargets (..))
import           Stack.Options.BuildParser
import           Stack.Options.GlobalParser
import           Stack.Config
import           Path                          (parseAbsFile)
import           Stack.Types.Compiler          (CVType(..), CompilerVersion, getGhcVersion)
import           Stack.Options.Utils           (GlobalOptsContext (..))
import           Stack.Prelude                 hiding (logDebug)
import           Stack.Types.BuildPlan         (Repo (..), PackageLocation (..))
import           Stack.Runners                 (withBuildConfig, loadCompilerVersion)
import           Stack.Types.Config
import           Stack.Types.Runner
import           Stack.Types.Config.Build      (BuildCommand (..))
import           Stack.Types.Nix
import           Stack.Types.Package           (PackageSource (..), lpPackage,
                                                packageName,
                                                packageVersion, lpLocation)
import           Stack.Types.PackageName       (PackageName)
import           Stack.Types.PackageIdentifier (PackageIdentifier (..),
                                                packageIdentifierString,
                                                PackageIdentifierRevision (..))
import           Stack2nix.External.Cabal2nix  (cabal2nix)
import           Stack2nix.Render              (render)
import           Stack2nix.Types               (Args (..))
import           Stack2nix.Util                (mapPool, logDebug, ensureExecutable)
import           System.Directory              (canonicalizePath,
                                                createDirectoryIfMissing,
                                                getCurrentDirectory,
                                                makeRelativeToCurrentDirectory)
import           System.FilePath               (makeRelative, (</>))
import qualified Distribution.Nixpkgs.Haskell.Hackage as DB
import           Distribution.Nixpkgs.Haskell.Derivation (Derivation)
import           Text.PrettyPrint.HughesPJClass (Doc)
import           Distribution.Nixpkgs.Haskell.PackageSourceSpec (loadHackageDB)

data PackageRef
  = HackagePackage PackageIdentifierRevision
  | NonHackagePackage PackageIdentifier (PackageLocation FilePath)
  deriving (Eq, Show)

genNixFile :: Args -> FilePath -> Maybe String -> Maybe String -> DB.HackageDB -> PackageRef -> IO (Either Doc Derivation)
genNixFile args baseDir uri argRev hackageDB pkgRef = do
  cwd <- getCurrentDirectory
  case pkgRef of
    NonHackagePackage _ident PLArchive {} -> error "genNixFile: No support for archive package locations"
    HackagePackage (PackageIdentifierRevision pkg _) ->
      cabal2nix args ("cabal://" <> packageIdentifierString pkg) Nothing Nothing hackageDB
    NonHackagePackage _ident (PLRepo repo) ->
      cabal2nix args (unpack $ repoUrl repo) (Just $ repoCommit repo) (Just (repoSubdirs repo)) hackageDB
    NonHackagePackage _ident (PLFilePath path) -> do
      relPath <- makeRelativeToCurrentDirectory path
      projRoot <- canonicalizePath $ cwd </> baseDir
      let defDir = baseDir </> makeRelative projRoot path
      cabal2nix args (fromMaybe defDir uri) (pack <$> argRev) (const relPath <$> uri) hackageDB

-- TODO: remove once we use flags, options
sourceMapToPackages :: Map PackageName PackageSource -> [PackageRef]
sourceMapToPackages = map sourceToPackage . M.elems
  where
    sourceToPackage :: PackageSource -> PackageRef
    sourceToPackage (PSIndex _ _flags _options pir) = HackagePackage pir
    sourceToPackage (PSFiles lp _) =
      let pkg = lpPackage lp
          ident = PackageIdentifier (packageName pkg) (packageVersion pkg)
       in NonHackagePackage ident (lpLocation lp)


planAndGenerate :: HasEnvConfig env
                => BuildOptsCLI
                -> FilePath
                -> Maybe String
                -> Args
                -> String
                -> RIO env ()
planAndGenerate boptsCli baseDir remoteUri args@Args{..} ghcnixversion = do
  (_targets, _mbp, _locals, _extraToBuild, sourceMap) <- loadSourceMapFull NeedTargets boptsCli
  let pkgs = sourceMapToPackages sourceMap
  liftIO $ logDebug args $ "plan:\n" ++ show pkgs

  hackageDB <- liftIO $ loadHackageDB Nothing argHackageSnapshot
  drvs <- liftIO $ mapPool argThreads (genNixFile args baseDir remoteUri argRev hackageDB) pkgs
  let locals = map (\l -> show (packageName (lpPackage l))) _locals
  liftIO $ render drvs args locals ghcnixversion

runPlan :: FilePath
        -> Maybe String
        -> Args
        -> IO ()
runPlan baseDir remoteUri args@Args{..} = do
  let stackRoot = "/tmp/s2n"
  createDirectoryIfMissing True stackRoot
  let globals = globalOpts baseDir stackRoot args
  let stackFile = baseDir </> argStackYaml

  ghcVersion <- getGhcVersionIO globals stackFile
  let ghcnixversion = filter (/= '.') $ show (getGhcVersion ghcVersion)
  ensureExecutable ("haskell.compiler.ghc" ++ ghcnixversion)
  withBuildConfig globals $ planAndGenerate buildOpts baseDir remoteUri args ghcnixversion


getGhcVersionIO :: GlobalOpts -> FilePath -> IO (CompilerVersion 'CVWanted)
getGhcVersionIO go stackFile = do
  cp <- canonicalizePath stackFile
  fp <- parseAbsFile cp
  lc <- withRunner LevelError True False ColorAuto Nothing False $ \runner ->
    -- https://www.fpcomplete.com/blog/2017/07/the-rio-monad
    runRIO runner $ loadConfig mempty Nothing (SYLOverride fp)
  loadCompilerVersion go lc

{-
  TODO:
  - replace "ghc" in package list with value encoding compiler version
  - handle custom shell.nix  (see mshellFile in Stack.Nix.runShellAndExit)
  - remove baseDir arguments; due to withCurrentDirectory it should always be PWD.
-}

globalOpts :: FilePath -> FilePath -> Args -> GlobalOpts
globalOpts currentDir stackRoot Args{..} =
  go { globalReExecVersion = Just "1.5.1" -- TODO: obtain from stack lib if exposed
     , globalConfigMonoid =
         (globalConfigMonoid go)
         { configMonoidNixOpts = mempty
           { nixMonoidEnable = First (Just True)
           }
         }
     , globalStackYaml = SYLOverride (currentDir </> argStackYaml)
     , globalLogLevel = if argVerbose then LevelDebug else LevelInfo
     }
  where
    pinfo = info (globalOptsParser currentDir OuterGlobalOpts (Just LevelError)) briefDesc
    args = concat [ ["--stack-root", stackRoot]
                  , ["--jobs", show argThreads]
                  , ["--test" | argTest]
                  , ["--haddock" | argHaddock]
                  , ["--stack-yaml", argStackYaml]
                  , ["--no-install-ghc"]
                  ]
    go = globalOptsFromMonoid False . fromJust . getParseResult $ execParserPure defaultPrefs pinfo args

buildOpts :: BuildOptsCLI
buildOpts = fromJust . getParseResult $ execParserPure defaultPrefs (info (buildOptsParser Build) briefDesc) ["--dry-run"]

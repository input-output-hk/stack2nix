{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix.External.Stack
  ( PackageRef(..), runPlan
  ) where

import           Control.Lens                                   ((%~))
import           Data.List                                      (concat)
import qualified Data.Map.Strict                                as M
import           Data.Maybe                                     (fromJust)
import qualified Data.Set                                       as Set (fromList,
                                                                        union)
import           Data.Text                                      (pack, unpack)
import           Distribution.Nixpkgs.Haskell.Derivation        (Derivation,
                                                                 configureFlags)
import qualified Distribution.Nixpkgs.Haskell.Hackage           as DB
import           Options.Applicative
import           Path                                           (parseAbsFile)
import           Stack.Build.Source                             (getGhcOptions, loadSourceMapFull)
import           Stack.Build.Target                             (NeedTargets (..))
import           Stack.Config
import           Stack.Options.BuildParser
import           Stack.Options.GlobalParser
import           Stack.Options.Utils                            (GlobalOptsContext (..))
import           Stack.Prelude                                  hiding
                                                                 (logDebug)
import           Stack.Runners                                  (loadCompilerVersion,
                                                                 withBuildConfig)
import           Stack.Types.BuildPlan                          (PackageLocation (..),
                                                                 Repo (..))
import           Stack.Types.Compiler                           (getGhcVersion)
import           Stack.Types.Config
import           Stack.Types.Config.Build                       (BuildCommand (..))
import           Stack.Types.Nix
import           Stack.Types.Package                            (PackageSource (..),
                                                                 lpLocation,
                                                                 lpPackage,
                                                                 packageName,
                                                                 packageVersion)
import           Stack.Types.PackageIdentifier                  (PackageIdentifier (..),
                                                                 PackageIdentifierRevision (..),
                                                                 packageIdentifierString)
import           Stack.Types.PackageName                        (PackageName)
import           Stack.Types.Runner
import           Stack.Types.Version                            (Version)
import           Stack2nix.External.Cabal2nix                   (cabal2nix)
import           Stack2nix.Hackage                              (loadHackageDB)
import           Stack2nix.Render                               (render)
import           Stack2nix.Types                                (Args (..))
import           Stack2nix.Util                                 (ensureExecutable,
                                                                 logDebug,
                                                                 mapPool)
import           System.Directory                               (canonicalizePath,
                                                                 createDirectoryIfMissing,
                                                                 getCurrentDirectory,
                                                                 makeRelativeToCurrentDirectory)
import           System.FilePath                                (makeRelative,
                                                                 (</>))
import           Text.PrettyPrint.HughesPJClass                 (Doc)

data PackageRef
  = HackagePackage PackageIdentifierRevision
  | NonHackagePackage PackageIdentifier (PackageLocation FilePath)
  deriving (Eq, Show)

genNixFile :: Args -> Version -> FilePath -> Maybe String -> Maybe String -> DB.HackageDB -> PackageRef -> IO (Either Doc Derivation)
genNixFile args ghcVersion baseDir uri argRev hackageDB pkgRef = do
  cwd <- getCurrentDirectory
  case pkgRef of
    NonHackagePackage _ident PLArchive {} -> error "genNixFile: No support for archive package locations"
    HackagePackage (PackageIdentifierRevision pkg _) ->
      cabal2nix args ghcVersion ("cabal://" <> packageIdentifierString pkg) Nothing Nothing hackageDB
    NonHackagePackage _ident (PLRepo repo) ->
      cabal2nix args ghcVersion (unpack $ repoUrl repo) (Just $ repoCommit repo) (Just (repoSubdirs repo)) hackageDB
    NonHackagePackage _ident (PLFilePath path) -> do
      relPath <- makeRelativeToCurrentDirectory path
      projRoot <- canonicalizePath $ cwd </> baseDir
      let defDir = baseDir </> makeRelative projRoot path
      cabal2nix args ghcVersion (fromMaybe defDir uri) (pack <$> argRev) (const relPath <$> uri) hackageDB

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


planAndGenerate
  :: HasEnvConfig env
  => BuildOptsCLI
  -> FilePath
  -> Maybe String
  -> Args
  -> Version
  -> RIO env ()
planAndGenerate boptsCli baseDir remoteUri args@Args {..} ghcVersion = do
  (_targets, _mbp, _locals, _extraToBuild, sourceMap) <- loadSourceMapFull
    NeedTargets
    boptsCli
  let pkgs = sourceMapToPackages sourceMap
  liftIO $ logDebug args $ "plan:\n" ++ show pkgs

  hackageDB <- liftIO $ loadHackageDB Nothing argHackageSnapshot
  buildConf <- envConfigBuildConfig <$> view envConfigL
  drvs      <- liftIO $ mapPool
    argThreads
    (\p ->
      fmap (addGhcOptions buildConf p)
        <$> genNixFile args ghcVersion baseDir remoteUri argRev hackageDB p
    )
    pkgs
  let locals = map (\l -> show (packageName (lpPackage l))) _locals
  liftIO . render drvs args locals $ nixVersion ghcVersion

-- | Add ghc-options declared in stack.yaml to the nix derivation for a package
--   by adding to the configureFlags attribute of the derivation
addGhcOptions :: BuildConfig -> PackageRef -> Derivation -> Derivation
addGhcOptions buildConf pkgRef drv =
  drv & configureFlags %~ (Set.union stackGhcOptions)
 where
  stackGhcOptions :: Set String
  stackGhcOptions =
    Set.fromList . map (unpack . ("--ghc-option=" <>)) $ getGhcOptions
      buildConf
      buildOpts
      pkgName
      False
      False
  pkgName :: PackageName
  pkgName = case pkgRef of
    HackagePackage (PackageIdentifierRevision (PackageIdentifier n _) _) -> n
    NonHackagePackage (PackageIdentifier n _) _                          -> n

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
  ensureExecutable ("haskell.compiler.ghc" ++ nixVersion ghcVersion)
  withBuildConfig globals $ planAndGenerate buildOpts baseDir remoteUri args ghcVersion

nixVersion :: Version -> String
nixVersion =
  filter (/= '.') . show

getGhcVersionIO :: GlobalOpts -> FilePath -> IO Version
getGhcVersionIO go stackFile = do
  cp <- canonicalizePath stackFile
  fp <- parseAbsFile cp
  lc <- withRunner LevelError True False ColorAuto Nothing False $ \runner ->
    -- https://www.fpcomplete.com/blog/2017/07/the-rio-monad
    runRIO runner $ loadConfig mempty Nothing (SYLOverride fp)
  getGhcVersion <$> loadCompilerVersion go lc

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
                  , ["--bench" | argBench]
                  , ["--haddock" | argHaddock]
                  , ["--no-install-ghc"]
                  ]
    go = globalOptsFromMonoid False ColorNever . fromJust . getParseResult $
      execParserPure defaultPrefs pinfo args

buildOpts :: BuildOptsCLI
buildOpts = fromJust . getParseResult $ execParserPure defaultPrefs (info (buildOptsParser Build) briefDesc) ["--dry-run"]

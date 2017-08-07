{-# LANGUAGE OverloadedStrings #-}

module Stack2nix.External.Stack
  ( PackageRef(..), runPlan
  ) where

import           Data.List                     (nubBy, sortBy)
import qualified Data.Map.Strict               as M
import qualified Data.Set                      as S
import           Data.Text                     (unpack)
import           Distribution.Version
import           Path                          (parseAbsDir, parseRelDir)
import           Stack.Build                   (mkBaseConfigOpts,
                                                withLoadPackage)
import           Stack.Build.ConstructPlan     (constructPlan)
import           Stack.Build.Haddock           (shouldHaddockDeps)
import           Stack.Build.Installed         (GetInstalledOpts (..),
                                                getInstalled)
import           Stack.Build.Source            (loadSourceMapFull)
import           Stack.Build.Target            (NeedTargets (..))
import           Stack.Prelude                 hiding (mapConcurrently)
import           Stack.Runners                 (withBuildConfig)
import           Stack.Types.Build             (Plan (..), Task (..),
                                                TaskConfigOpts (..),
                                                TaskType (..), lpDir)
import           Stack.Types.BuildPlan         (Repo (..), Subdirs (..))
import           Stack.Types.Config
import           Stack.Types.Config.Build      (BuildCommand (..),
                                                FileWatchOpts (..),
                                                defaultBuildOptsCLI)
import           Stack.Types.Docker
import           Stack.Types.Image
import           Stack.Types.Nix               (NixOptsMonoid (..))
import           Stack.Types.PackageIdentifier (PackageIdentifier (..),
                                                packageIdentifierString)
import           Stack.Types.Runner            (ColorWhen (..))
import           Stack.Types.Urls
import           Stack.Types.Version
import           Stack2nix.External.Cabal2nix  (cabal2nix)
import           Stack2nix.Util
import           System.FilePath               ((</>))
import           System.FilePath               (makeRelative)
import           System.IO                     (hPutStrLn, stderr)
import           Text.Show.Pretty

data PackageRef = LocalPackage PackageIdentifier FilePath (Maybe Text)
                | CabalPackage PackageIdentifier
                | RepoPackage (Repo Subdirs)
                deriving (Eq, Show)

genNixFile :: FilePath -> FilePath -> Maybe String -> PackageRef -> IO ()
genNixFile baseDir outDir uri pkgRef = do
  hPutStrLn stderr $ "Generating nix expression for " ++ show pkgRef
  case pkgRef of
    LocalPackage _ident path mrev ->
      let relPath = makeRelative baseDir path in
      void $ cabal2nix (fromMaybe (baseDir </> relPath) uri) mrev (const relPath <$> uri) (Just outDir)
    CabalPackage pkg ->
      void $ cabal2nix ("cabal://" <> packageIdentifierString pkg) Nothing Nothing (Just outDir)
    RepoPackage repo ->
      case repoSubdirs repo of
        ExplicitSubdirs sds -> do
          mapM_ (\sd -> cabal2nix (unpack $ repoUrl repo) (Just $ repoCommit repo) (Just sd) (Just outDir)) sds
        DefaultSubdirs -> do
          void $ cabal2nix (unpack $ repoUrl repo) (Just $ repoCommit repo) Nothing (Just outDir)

planToPackages :: Plan -> [PackageRef]
planToPackages plan = concatMap taskToPackages $ M.elems $ planTasks plan
  where
    taskToPackages :: Task -> [PackageRef]
    taskToPackages task =
      let provided = case taskType task of
                       TTLocal lp   -> LocalPackage (taskProvides task) (toFilePath $ lpDir lp) Nothing
                       TTUpstream{} -> CabalPackage (taskProvides task) in
      provided : (CabalPackage <$> (S.toList . tcoMissing $ taskConfigOpts task))

packageIdentifier :: PackageRef -> Maybe PackageIdentifier
packageIdentifier (LocalPackage pid _ _) = Just pid
packageIdentifier (CabalPackage pid)     = Just pid
packageIdentifier (RepoPackage _)        = Nothing

prioritize :: [PackageRef] -> [PackageRef]
prioritize = reverse .
             -- TODO: filter out every CabalPackage which is already
             -- covered by a RepoPackage; then reversing shouldn't be
             -- needed.
             nubBy (\p1 p2 -> let n1 = packageIdentifier p1
                                  n2 = packageIdentifier p2 in
                                if n1 == Nothing || n2 == Nothing then False else n1 == n2) .
             sortBy (\p1 p2 ->
                       case (p1, p2) of
                         (LocalPackage pid1 _ _, LocalPackage pid2 _ _) -> compare (show pid1) (show pid2)
                         (LocalPackage _ _ _, _) -> LT
                         (_, LocalPackage _ _ _) -> GT
                         _ ->
                           let name p = maybe "" show (packageIdentifier p) in
                             compare (name p1) (name p2))

planAndGenerate :: HasEnvConfig env
                => BuildOptsCLI
                -> FilePath
                -> FilePath
                -> Maybe String
                -> [PackageRef]
                -> IO ()
                -> RIO env ()
planAndGenerate boptsCli baseDir outDir remoteUri revPkgs doAfter = do
  bopts <- view buildOptsL
  let profiling = boptsLibProfile bopts || boptsExeProfile bopts
  let symbols = not (boptsLibStrip bopts || boptsExeStrip bopts)
  menv <- getMinimalEnvOverride

  (_targets, mbp, locals, extraToBuild, sourceMap) <- loadSourceMapFull NeedTargets boptsCli
  _stackYaml <- view stackYamlL

  (installedMap, _globalDumpPkgs, _snapshotDumpPkgs, localDumpPkgs) <-
    getInstalled menv
                 GetInstalledOpts
                   { getInstalledProfiling = profiling
                   , getInstalledHaddock   = shouldHaddockDeps bopts
                   , getInstalledSymbols   = symbols }
                 sourceMap

  baseConfigOpts <- mkBaseConfigOpts boptsCli
  plan <- withLoadPackage $ \loadPackage -> do
    constructPlan mbp baseConfigOpts locals extraToBuild localDumpPkgs loadPackage sourceMap installedMap (boptsCLIInitialBuildSteps boptsCli)
  let pkgs = prioritize $ planToPackages plan ++ revPkgs
  liftIO $ hPutStrLn stderr $ "plan:\n" ++ ppShow pkgs

  void $ liftIO $ cabal2nix "cabal://hscolour" Nothing Nothing (Just outDir)
  void $ liftIO $ mapPool 4 (genNixFile baseDir outDir remoteUri) pkgs
  liftIO doAfter

runPlan :: FilePath
         -> FilePath
         -> Maybe String
         -> [PackageRef]
         -> IO ()
         -> IO ()
runPlan baseDir outDir remoteUri revPkgs doAfter =
  withBuildConfig globalOpts $ planAndGenerate buildOpts baseDir outDir remoteUri revPkgs doAfter


-- TODO: globalOpts is printed twice. Only second one works when
-- there's a nix shell-file. Replicate the GlobalOpts update.
globalOpts :: GlobalOpts
globalOpts =
  GlobalOpts
    { globalReExecVersion = Just "1.5.1"
    , globalDockerEntrypoint = Nothing
    , globalLogLevel = LevelInfo
    , globalTimeInLog = True
    , globalConfigMonoid =
        ConfigMonoid
          { configMonoidStackRoot =
              First { getFirst = parseAbsDir "/tmp/tmp.X3tdqJT4dd/" }
          , configMonoidWorkDir = First { getFirst = parseRelDir "swHnNFOcp/" }
          , configMonoidBuildOpts =
              BuildOptsMonoid
                { buildMonoidTrace = Any { getAny = False }
                , buildMonoidProfile = Any { getAny = False }
                , buildMonoidNoStrip = Any { getAny = False }
                , buildMonoidLibProfile = First { getFirst = Nothing }
                , buildMonoidExeProfile = First { getFirst = Nothing }
                , buildMonoidLibStrip = First { getFirst = Nothing }
                , buildMonoidExeStrip = First { getFirst = Nothing }
                , buildMonoidHaddock = First { getFirst = Nothing }
                , buildMonoidHaddockOpts =
                    HaddockOptsMonoid { hoMonoidAdditionalArgs = [] }
                , buildMonoidOpenHaddocks = First { getFirst = Nothing }
                , buildMonoidHaddockDeps = First { getFirst = Nothing }
                , buildMonoidHaddockInternal = First { getFirst = Nothing }
                , buildMonoidHaddockHyperlinkSource = First { getFirst = Nothing }
                , buildMonoidInstallExes = First { getFirst = Nothing }
                , buildMonoidPreFetch = First { getFirst = Nothing }
                , buildMonoidKeepGoing = First { getFirst = Nothing }
                , buildMonoidForceDirty = First { getFirst = Nothing }
                , buildMonoidTests = First { getFirst = Nothing }
                , buildMonoidTestOpts =
                    TestOptsMonoid
                      { toMonoidRerunTests = First { getFirst = Nothing }
                      , toMonoidAdditionalArgs = []
                      , toMonoidCoverage = First { getFirst = Just False }
                      , toMonoidDisableRun = First { getFirst = Just False }
                      }
                , buildMonoidBenchmarks = First { getFirst = Nothing }
                , buildMonoidBenchmarkOpts =
                    BenchmarkOptsMonoid
                      { beoMonoidAdditionalArgs = First { getFirst = Nothing }
                      , beoMonoidDisableRun = First { getFirst = Just False }
                      }
                , buildMonoidReconfigure = First { getFirst = Nothing }
                , buildMonoidCabalVerbose = First { getFirst = Nothing }
                , buildMonoidSplitObjs = First { getFirst = Nothing }
                , buildMonoidSkipComponents = []
                }
          , configMonoidDockerOpts =
              DockerOptsMonoid
                { dockerMonoidDefaultEnable = Any { getAny = False }
                , dockerMonoidEnable = First { getFirst = Nothing }
                , dockerMonoidRepoOrImage = First { getFirst = Nothing }
                , dockerMonoidRegistryLogin = First { getFirst = Nothing }
                , dockerMonoidRegistryUsername = First { getFirst = Nothing }
                , dockerMonoidRegistryPassword = First { getFirst = Nothing }
                , dockerMonoidAutoPull = First { getFirst = Nothing }
                , dockerMonoidDetach = First { getFirst = Nothing }
                , dockerMonoidPersist = First { getFirst = Nothing }
                , dockerMonoidContainerName = First { getFirst = Nothing }
                , dockerMonoidRunArgs = []
                , dockerMonoidMount = []
                , dockerMonoidEnv = []
                , dockerMonoidDatabasePath = First { getFirst = Nothing }
                , dockerMonoidStackExe = First { getFirst = Nothing }
                , dockerMonoidSetUser = First { getFirst = Nothing }
                , dockerMonoidRequireDockerVersion =
                    IntersectingVersionRange
                      { getIntersectingVersionRange =
                          IntersectVersionRanges AnyVersion AnyVersion
                      }
                }
          , configMonoidNixOpts =
              NixOptsMonoid
                { nixMonoidDefaultEnable = Any { getAny = False }
                , nixMonoidEnable = First { getFirst = Just True }
                , nixMonoidPureShell = First { getFirst = Nothing }
                , nixMonoidPackages = First { getFirst = Nothing }
                , nixMonoidInitFile = First { getFirst = Nothing }
                , nixMonoidShellOptions = First { getFirst = Nothing }
                , nixMonoidPath = First { getFirst = Nothing }
                , nixMonoidAddGCRoots = First { getFirst = Nothing }
                }
          , configMonoidConnectionCount = First { getFirst = Nothing }
          , configMonoidHideTHLoading = First { getFirst = Nothing }
          , configMonoidLatestSnapshotUrl = First { getFirst = Nothing }
          , configMonoidUrls =
              UrlsMonoid
                { urlsMonoidLatestSnapshot = First { getFirst = Nothing }
                , urlsMonoidLtsBuildPlans = First { getFirst = Nothing }
                , urlsMonoidNightlyBuildPlans = First { getFirst = Nothing }
                }
          , configMonoidPackageIndices = First { getFirst = Nothing }
          , configMonoidSystemGHC = First { getFirst = Nothing }
          , configMonoidInstallGHC = First { getFirst = Nothing }
          , configMonoidSkipGHCCheck = First { getFirst = Nothing }
          , configMonoidSkipMsys = First { getFirst = Nothing }
          , configMonoidCompilerCheck = First { getFirst = Nothing }
          , configMonoidRequireStackVersion =
              IntersectingVersionRange
                { getIntersectingVersionRange =
                    IntersectVersionRanges AnyVersion AnyVersion
                }
          , configMonoidArch = First { getFirst = Nothing }
          , configMonoidGHCVariant = First { getFirst = Nothing }
          , configMonoidGHCBuild = First { getFirst = Nothing }
          , configMonoidJobs = First { getFirst = Just 8 }
          , configMonoidExtraIncludeDirs =
              S.fromList
                [ "/nix/store/209qyx70k56xzc53iaal7vzx5mv5ybs6-stack-1.4.0/include"
                , "/nix/store/38j0xh4ywnzmxxrbqg4wmw2p3rz2yn6c-openssl-1.0.2l-dev/include"
                , "/nix/store/48h16g02yadv8kml8pjqr02132fhmdwk-zlib-1.2.11-dev/include"
                , "/nix/store/4wzk6si1afgsg5bjj65dz292blm49a4l-rocksdb-5.1.2/include"
                , "/nix/store/5ld04wdc8fffqsh4v34l0srrjnkpgpd7-openssh-7.5p1/include"
                , "/nix/store/72j5bx3dc2kfd2h9hj3rgxs2sbbqjn3k-cpphs-1.20.8/include"
                , "/nix/store/cczrp49krx20h7a819v43d0mnkyiwrp9-gmp-6.1.2-dev/include"
                , "/nix/store/g83lwg1m50mbc59v3niznp8hn9v6485m-happy-1.19.5/include"
                , "/nix/store/i6r4rnd96jj4z40wiqfj12sj255xnc98-git-2.13.3/include"
                , "/nix/store/mcdyadfdn4an8cd85b6lxxrz4sqvjfic-bsdiff-4.3/include"
                , "/nix/store/ngmfaskrn0vsvw14fivpq5lg4mkcq1mb-libc++-4.0.1/include"
                , "/nix/store/v90hwy08flwl4yva5fpdpjn8f0hckix1-hook/include"
                , "/nix/store/zaprhlgknyj8yy7kqdv7h1kcwq0x8lz2-cabal-install-1.24.0.2/include"
                ]
          , configMonoidExtraLibDirs =
              S.fromList
                [ "/nix/store/069ir6yxjpzlvh0wlcl0g7zsgygsafng-zlib-1.2.11/lib"
                , "/nix/store/209qyx70k56xzc53iaal7vzx5mv5ybs6-stack-1.4.0/lib"
                , "/nix/store/4wzk6si1afgsg5bjj65dz292blm49a4l-rocksdb-5.1.2/lib"
                , "/nix/store/5ld04wdc8fffqsh4v34l0srrjnkpgpd7-openssh-7.5p1/lib"
                , "/nix/store/72j5bx3dc2kfd2h9hj3rgxs2sbbqjn3k-cpphs-1.20.8/lib"
                , "/nix/store/c9fg9z6a74n6f3g94q5d3k704b5wfm6x-openssl-1.0.2l/lib"
                , "/nix/store/g83lwg1m50mbc59v3niznp8hn9v6485m-happy-1.19.5/lib"
                , "/nix/store/i6r4rnd96jj4z40wiqfj12sj255xnc98-git-2.13.3/lib"
                , "/nix/store/mcdyadfdn4an8cd85b6lxxrz4sqvjfic-bsdiff-4.3/lib"
                , "/nix/store/ngmfaskrn0vsvw14fivpq5lg4mkcq1mb-libc++-4.0.1/lib"
                , "/nix/store/s4hnhs3wm75is31sx5mjvqhw2mva5x0q-gmp-6.1.2/lib"
                , "/nix/store/v90hwy08flwl4yva5fpdpjn8f0hckix1-hook/lib"
                , "/nix/store/zaprhlgknyj8yy7kqdv7h1kcwq0x8lz2-cabal-install-1.24.0.2/lib"
                ]
          , configMonoidOverrideGccPath = First { getFirst = Nothing }
          , configMonoidConcurrentTests = First { getFirst = Nothing }
          , configMonoidLocalBinPath = First { getFirst = Nothing }
          , configMonoidImageOpts = ImageOptsMonoid { imgMonoidDockers = [] }
          , configMonoidTemplateParameters = M.fromList []
          , configMonoidScmInit = First { getFirst = Nothing }
          , configMonoidGhcOptions =
              GhcOptions { unGhcOptions = M.fromList [] }
          , configMonoidExtraPath = []
          , configMonoidSetupInfoLocations = []
          , configMonoidLocalProgramsBase = First { getFirst = Nothing }
          , configMonoidPvpBounds = First { getFirst = Nothing }
          , configMonoidModifyCodePage = First { getFirst = Nothing }
          , configMonoidExplicitSetupDeps = M.fromList []
          , configMonoidRebuildGhcOptions = First { getFirst = Nothing }
          , configMonoidApplyGhcOptions = First { getFirst = Nothing }
          , configMonoidAllowNewer = First { getFirst = Nothing }
          , configMonoidDefaultTemplate = First { getFirst = Nothing }
          , configMonoidAllowDifferentUser = First { getFirst = Nothing }
          , configMonoidDumpLogs = First { getFirst = Nothing }
          , configMonoidSaveHackageCreds = First { getFirst = Nothing }
          }
    , globalResolver = Nothing
    , globalCompiler = Nothing
    , globalTerminal = False
    , globalColorWhen = ColorAuto
    , globalStackYaml = SYLDefault
    }

buildOpts :: BuildOptsCLI
buildOpts =
  BuildOptsCLI { boptsCLITargets = []
               , boptsCLIDryrun = True
               , boptsCLIGhcOptions = []
               , boptsCLIFlags = M.fromList []
               , boptsCLIBuildSubset = BSAll
               , boptsCLIFileWatch = NoFileWatch
               , boptsCLIExec = []
               , boptsCLIOnlyConfigure = False
               , boptsCLICommand = Build
               , boptsCLIInitialBuildSteps = False
               }




-- nixOptsMonoid :: NixOptsMonoid
-- nixOptsMonoid = mempty { nixMonoidEnable = pure True }

-- configMonoid :: ConfigMonoid
-- configMonoid = mempty { configMonoidNixOpts = nixOptsMonoid }

-- globalOpts :: GlobalOpts
-- globalOpts =
--   GlobalOpts { globalReExecVersion = Nothing
--              , globalDockerEntrypoint = Nothing
--              , globalLogLevel = defaultLogLevel
--              , globalTimeInLog = False
--              , globalConfigMonoid = configMonoid
--              , globalResolver = Nothing
--              , globalCompiler = Nothing
--              , globalTerminal = True
--              , globalColorWhen = ColorAuto
--              , globalStackYaml = SYLDefault -- TODO: revisit this
--              }

-- buildOpts :: BuildOptsCLI
-- buildOpts =
--   BuildOptsCLI { boptsCLITargets = []
--                , boptsCLIDryrun = True
--                , boptsCLIGhcOptions = ["-Wall", "-Werror", "-O0"]
--                , boptsCLIFlags = empty
--                , boptsCLIBuildSubset = BSAll
--                , boptsCLIFileWatch = NoFileWatch
--                , boptsCLIExec = []
--                , boptsCLIOnlyConfigure = False
--                , boptsCLICommand = Build
--                , boptsCLIInitialBuildSteps = False
--                }

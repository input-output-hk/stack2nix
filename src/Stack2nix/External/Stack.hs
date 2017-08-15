{-# LANGUAGE OverloadedStrings #-}

module Stack2nix.External.Stack
  ( PackageRef(..), runPlan
  ) where

import           Data.List                     (nubBy, sortBy)
import qualified Data.Map.Strict               as M
import           Data.Maybe                    (fromJust)
import qualified Data.Set                      as S
import           Data.Text                     (unpack)
import           Options.Applicative
import           Stack.Build                   (mkBaseConfigOpts,
                                                withLoadPackage)
import           Stack.Build.ConstructPlan     (constructPlan)
import           Stack.Build.Haddock           (shouldHaddockDeps)
import           Stack.Build.Installed         (GetInstalledOpts (..),
                                                getInstalled)
import           Stack.Build.Source            (loadSourceMapFull)
import           Stack.Build.Target            (NeedTargets (..))
import           Stack.Options.BuildParser
import           Stack.Options.GlobalParser
import           Stack.Options.Utils           (GlobalOptsContext (..))
import           Stack.Prelude                 hiding (mapConcurrently)
import           Stack.Runners                 (withBuildConfig)
import           Stack.Types.Build             (Plan (..), Task (..),
                                                TaskConfigOpts (..),
                                                TaskType (..), lpDir)
import           Stack.Types.BuildPlan         (Repo (..), Subdirs (..))
import           Stack.Types.Config
import           Stack.Types.Config.Build      (BuildCommand (..))
import           Stack.Types.Nix
import           Stack.Types.PackageIdentifier (PackageIdentifier (..),
                                                packageIdentifierString)
import           Stack2nix.External.Cabal2nix  (cabal2nix)
import           Stack2nix.External.Util       (failHard, runCmd)
import           Stack2nix.Util                (mapPool)
import           System.Directory              (makeRelativeToCurrentDirectory)
import           System.FilePath               ((</>))
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
    LocalPackage _ident path mrev -> do
      relPath <- makeRelativeToCurrentDirectory path
      void $ cabal2nix (fromMaybe (baseDir </> relPath) uri) mrev (const relPath <$> uri) (Just outDir)
    CabalPackage pkg ->
      void $ cabal2nix ("cabal://" <> packageIdentifierString pkg) Nothing Nothing (Just outDir)
    RepoPackage repo ->
      case repoSubdirs repo of
        ExplicitSubdirs sds ->
          mapM_ (\sd -> cabal2nix (unpack $ repoUrl repo) (Just $ repoCommit repo) (Just sd) (Just outDir)) sds
        DefaultSubdirs ->
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
                                not (isNothing n1 || isNothing n2) && n1 == n2) .
             sortBy (\p1 p2 ->
                       case (p1, p2) of
                         (LocalPackage pid1 _ _, LocalPackage pid2 _ _) -> compare (show pid1) (show pid2)
                         (LocalPackage{}, _) -> LT
                         (_, LocalPackage{}) -> GT
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
  plan <- withLoadPackage $ \loadPackage ->
    constructPlan mbp baseConfigOpts locals extraToBuild localDumpPkgs loadPackage sourceMap installedMap (boptsCLIInitialBuildSteps boptsCli)
  let pkgs = prioritize $ planToPackages plan ++ revPkgs
  liftIO $ hPutStrLn stderr $ "plan:\n" ++ ppShow pkgs

  void $ liftIO $ mapM_ (\pkg -> cabal2nix ("cabal://" ++ pkg) Nothing Nothing (Just outDir)) $ words "hscolour stringbuilder"
  void $ liftIO $ mapPool 4 (genNixFile baseDir outDir remoteUri) pkgs
  liftIO doAfter

runPlan :: FilePath
        -> FilePath
        -> Maybe String
        -> [PackageRef]
        -> LoadConfig
        -> IO ()
        -> IO ()
runPlan baseDir outDir remoteUri revPkgs lc doAfter = do
  let pkgsInConfig = nixPackages (configNix $ lcConfig lc)
  let pkgs = map unpack pkgsInConfig ++ ["ghc", "git"]
  globals <- queryNixPkgsPaths Include pkgs >>= \includes ->
             queryNixPkgsPaths Lib pkgs >>= \libs ->
             pure $ globalOpts baseDir includes libs
  hPutStrLn stderr $ "stack global opts:\n" ++ ppShow globals
  hPutStrLn stderr $ "stack build opts:\n" ++ ppShow buildOpts
  withBuildConfig globals $ planAndGenerate buildOpts baseDir outDir remoteUri revPkgs doAfter

{-
  TODO:
  - replace "ghc" in package list with value encoding compiler version
  - handle custom shell.nix  (see mshellFile in Stack.Nix.runShellAndExit)
-}

data NixPkgPath = Lib
                | Include

queryNixPkgsPaths :: NixPkgPath -> [String] -> IO (Set FilePath)
queryNixPkgsPaths kind pkgs = do
  (_, out, _) <- runCmd "nix-instantiate" [ "--eval"
                                          , "-E"
                                          , "with import <nixpkgs>{}; lib.concatMapStringsSep \" \" (pkg: ''" ++ query kind ++ "'') [" ++ unwords pkgs ++ "]"
                                          ]
                 >>= failHard
  pure . S.fromList . words . filter (/= '"') $ out
    where
      query Lib     = "${lib.getLib pkg}/lib"
      query Include = "${lib.getDev pkg}/include"

globalOpts :: FilePath -> Set FilePath -> Set FilePath -> GlobalOpts
globalOpts currentDir extraIncludes extraLibs =
  go { globalReExecVersion = Just "1.5.1" -- TODO: obtain from stack lib if exposed
     , globalConfigMonoid =
         (globalConfigMonoid go)
         { configMonoidExtraIncludeDirs = extraIncludes
         , configMonoidExtraLibDirs = extraLibs
         }
     }
  where
    pinfo = info (globalOptsParser currentDir OuterGlobalOpts (Just LevelError)) briefDesc
    args = ["--work-dir", "./.s2n", "--stack-root", "/tmp/s2n", "--jobs", "8", "--nix"]
    go = globalOptsFromMonoid False . fromJust . getParseResult $ execParserPure defaultPrefs pinfo args

buildOpts :: BuildOptsCLI
buildOpts = fromJust . getParseResult $ execParserPure defaultPrefs (info (buildOptsParser Build) briefDesc) ["--dry-run"]

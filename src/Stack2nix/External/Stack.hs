{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix.External.Stack
  ( PackageRef(..), runPlan
  ) where

import           Control.Applicative           ((<|>))
import           Control.Monad                 (unless)
import           Data.List                     (isInfixOf, nubBy, sortBy)
import qualified Data.Map.Strict               as M
import           Data.Maybe                    (fromJust)
import qualified Data.Set                      as S
import           Data.Text                     (pack, unpack)
import           Data.Time                     (UTCTime)
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
import           Stack2nix.Types               (Args (..))
import           Stack2nix.Util                (mapPool)
import           System.Directory              (canonicalizePath,
                                                createDirectoryIfMissing,
                                                getCurrentDirectory,
                                                makeRelativeToCurrentDirectory)
import           System.FilePath               (makeRelative, (</>))
import           System.IO                     (hPutStrLn, stderr)

data PackageRef = LocalPackage PackageIdentifier FilePath (Maybe Text)
                | CabalPackage PackageIdentifier
                | RepoPackage (Repo Subdirs)
                deriving (Eq, Show)

genNixFile :: FilePath -> FilePath -> Maybe String -> Maybe String -> Maybe UTCTime -> PackageRef  -> IO ()
genNixFile baseDir outDir uri argRev hSnapshot pkgRef = do
  cwd <- getCurrentDirectory
  -- hPutStrLn stderr $ "\nGenerating nix expression for " ++ show pkgRef
  -- hPutStrLn stderr $ "genNixFile (cwd): " ++ cwd
  -- hPutStrLn stderr $ "genNixFile (baseDir): " ++ baseDir
  -- hPutStrLn stderr $ "genNixFile (outDir): " ++ outDir
  -- hPutStrLn stderr $ "genNixFile (uri): " ++ show uri
  -- hPutStrLn stderr $ "genNixFile (pkgRef): " ++ show pkgRef
  case pkgRef of
    LocalPackage _ident path mrev -> do
      relPath <- makeRelativeToCurrentDirectory path
      -- hPutStrLn stderr $ "genNixFile (LocalPackage: relPath): " ++ relPath
      projRoot <- canonicalizePath $ cwd </> baseDir
      -- hPutStrLn stderr $ "genNixFile (LocalPackage: projRoot): " ++ projRoot
      let defDir = baseDir </> makeRelative projRoot path
      -- hPutStrLn stderr $ "genNixFile (LocalPackage: defDir): " ++ defDir
      unless (".s2n" `isInfixOf` path) $
        void $ cabal2nix (fromMaybe defDir uri) (mrev <|> (pack <$> argRev)) (const relPath <$> uri) (Just outDir) hSnapshot
    CabalPackage pkg ->
      void $ cabal2nix ("cabal://" <> packageIdentifierString pkg) Nothing Nothing (Just outDir) hSnapshot
    RepoPackage repo ->
      case repoSubdirs repo of
        ExplicitSubdirs sds ->
          mapM_ (\sd -> cabal2nix (unpack $ repoUrl repo) (Just $ repoCommit repo) (Just sd) (Just outDir) hSnapshot) sds
        DefaultSubdirs ->
          void $ cabal2nix (unpack $ repoUrl repo) (Just $ repoCommit repo) Nothing (Just outDir) hSnapshot

planToPackages :: Plan -> [PackageRef]
planToPackages plan = concatMap taskToPackages $ M.elems $ planTasks plan
  where
    taskToPackages :: Task -> [PackageRef]
    taskToPackages task =
      let provided = case taskType task of
                       TTFiles lp _il -> LocalPackage (taskProvides task) (toFilePath $ lpDir lp) Nothing
                       TTIndex{} -> CabalPackage (taskProvides task) in
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
                -> Maybe String
                -> Maybe UTCTime
                -> Int
                -> IO ()
                -> RIO env ()
planAndGenerate boptsCli baseDir outDir remoteUri revPkgs argRev hSnapshot threads doAfter = do
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
  liftIO $ hPutStrLn stderr $ "plan:\n" ++ show pkgs

  void $ liftIO $ mapM_ (\pkg -> cabal2nix ("cabal://" ++ pkg) Nothing Nothing (Just outDir) hSnapshot) $ words "hscolour stringbuilder"
  void $ liftIO $ mapPool threads (genNixFile baseDir outDir remoteUri argRev hSnapshot) pkgs
  liftIO doAfter

runPlan :: FilePath
        -> FilePath
        -> Maybe String
        -> [PackageRef]
        -> LoadConfig
        -> Args
        -> IO ()
        -> IO ()
runPlan baseDir outDir remoteUri revPkgs lc args@Args{..} doAfter = do
  let pkgsInConfig = nixPackages (configNix $ lcConfig lc)
  let pkgs = map unpack pkgsInConfig ++ ["ghc", "git"]
  let stackRoot = "/tmp/s2n"
  createDirectoryIfMissing True stackRoot
  globals <- queryNixPkgsPaths Include pkgs >>= \includes ->
             queryNixPkgsPaths Lib pkgs >>= \libs ->
             pure $ globalOpts baseDir stackRoot includes libs args
  -- hPutStrLn stderr $ "stack global opts:\n" ++ ppShow globals
  -- hPutStrLn stderr $ "stack build opts:\n" ++ ppShow buildOpts
  withBuildConfig globals $ planAndGenerate buildOpts baseDir outDir remoteUri revPkgs argRev argHackageSnapshot argThreads doAfter

{-
  TODO:
  - replace "ghc" in package list with value encoding compiler version
  - handle custom shell.nix  (see mshellFile in Stack.Nix.runShellAndExit)
  - remove baseDir arguments; due to withCurrentDirectory it should always be PWD.
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

globalOpts :: FilePath -> FilePath -> Set FilePath -> Set FilePath -> Args -> GlobalOpts
globalOpts currentDir stackRoot extraIncludes extraLibs Args{..} =
  go { globalReExecVersion = Just "1.5.1" -- TODO: obtain from stack lib if exposed
     , globalConfigMonoid =
         (globalConfigMonoid go)
         { configMonoidExtraIncludeDirs = extraIncludes
         , configMonoidExtraLibDirs = extraLibs
         }
     }
  where
    pinfo = info (globalOptsParser currentDir OuterGlobalOpts (Just LevelError)) briefDesc
    args = concat [ ["--work-dir", "./.s2n"]
                  , ["--stack-root", stackRoot]
                  , ["--jobs", show argThreads]
                  , ["--test" | argTest]
                  , ["--haddock" | argHaddock]
                  , ["--nix"]
                  ]
    go = globalOptsFromMonoid False . fromJust . getParseResult $ execParserPure defaultPrefs pinfo args

buildOpts :: BuildOptsCLI
buildOpts = fromJust . getParseResult $ execParserPure defaultPrefs (info (buildOptsParser Build) briefDesc) ["--dry-run"]

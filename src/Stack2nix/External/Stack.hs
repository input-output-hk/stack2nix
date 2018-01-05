{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix.External.Stack
  ( PackageRef(..), runPlan
  ) where

import           Control.Applicative           ((<|>))
import           Control.Monad.Reader          (local)
import           Data.List                     (isInfixOf, nubBy, sortBy, concat)
import qualified Data.Map.Strict               as M
import           Data.Maybe                    (fromJust)
import qualified Data.Set                      as S
import           Data.Text                     (pack, unpack)
import           Lens.Micro                    (set)
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
                                                packageIdentifierString,
                                                parsePackageIdentifier)
import           Stack2nix.External.Cabal2nix  (cabal2nix)
import           Stack2nix.External.Util       (failHard, runCmd)
import           Stack2nix.Render              (render)
import           Stack2nix.Types               (Args (..))
import           Stack2nix.Util                (mapPool)
import           System.Directory              (canonicalizePath,
                                                createDirectoryIfMissing,
                                                getCurrentDirectory,
                                                makeRelativeToCurrentDirectory)
import           System.FilePath               (makeRelative, (</>))
import           System.IO                     (hPutStrLn, stderr)
import qualified Distribution.Nixpkgs.Haskell.Hackage as DB
import           Distribution.Nixpkgs.Haskell.Derivation (Derivation)
import           Text.PrettyPrint.HughesPJClass (Doc)
import Distribution.Nixpkgs.Haskell.PackageSourceSpec (loadHackageDB)

data PackageRef = LocalPackage PackageIdentifier FilePath (Maybe Text)
                | CabalPackage PackageIdentifier
                | RepoPackage (Repo Subdirs)
                deriving (Eq, Show)

genNixFile :: Args -> FilePath -> FilePath -> Maybe String -> Maybe String -> DB.HackageDB -> PackageRef -> IO [Either Doc Derivation]
genNixFile args baseDir outDir uri argRev hackageDB pkgRef = do
  cwd <- getCurrentDirectory
  case pkgRef of
    LocalPackage _ident path mrev -> do
      relPath <- makeRelativeToCurrentDirectory path
      projRoot <- canonicalizePath $ cwd </> baseDir
      let defDir = baseDir </> makeRelative projRoot path
      if (".s2n" `isInfixOf` path)
      then return []
      else fmap (:[]) $ cabal2nix args (fromMaybe defDir uri) (mrev <|> (pack <$> argRev)) (const relPath <$> uri) (Just outDir) hackageDB
    CabalPackage pkg ->
      fmap (:[]) $ cabal2nix args ("cabal://" <> packageIdentifierString pkg) Nothing Nothing (Just outDir) hackageDB
    RepoPackage repo ->
      case repoSubdirs repo of
        ExplicitSubdirs sds ->
          mapM (\sd -> cabal2nix args (unpack $ repoUrl repo) (Just $ repoCommit repo) (Just sd) (Just outDir) hackageDB) sds
        DefaultSubdirs ->
          fmap (:[]) $ cabal2nix args (unpack $ repoUrl repo) (Just $ repoCommit repo) Nothing (Just outDir) hackageDB

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
                -> Args
                -> RIO env ()
planAndGenerate boptsCli baseDir outDir remoteUri revPkgs args@Args{..} = do
  local (set platformL argPlatform) $ do
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
    -- hscolour is needed until https://github.com/NixOS/nixpkgs/issues/32609 is addressed
    hscolour <- parsePackageIdentifier "hscolour-1.24.4"
    let pkgs = prioritize $ planToPackages plan ++ revPkgs ++ [CabalPackage hscolour]
    liftIO $ hPutStrLn stderr $ "plan:\n" ++ show pkgs

    hackageDB <- liftIO $ loadHackageDB Nothing argHackageSnapshot
    drvs <- liftIO $ mapPool argThreads (genNixFile args baseDir outDir remoteUri argRev hackageDB) pkgs
    liftIO $ render (concat drvs)

runPlan :: FilePath
        -> FilePath
        -> Maybe String
        -> [PackageRef]
        -> LoadConfig
        -> Args
        -> IO ()
runPlan baseDir outDir remoteUri revPkgs lc args@Args{..} = do
  let pkgsInConfig = nixPackages (configNix $ lcConfig lc)
  let pkgs = map unpack pkgsInConfig ++ ["ghc", "git"]
  let stackRoot = "/tmp/s2n"
  createDirectoryIfMissing True stackRoot
  globals <- queryNixPkgsPaths Include pkgs >>= \includes ->
             queryNixPkgsPaths Lib pkgs >>= \libs ->
             pure $ globalOpts baseDir stackRoot includes libs args
  -- hPutStrLn stderr $ "stack global opts:\n" ++ ppShow globals
  -- hPutStrLn stderr $ "stack build opts:\n" ++ ppShow buildOpts
  withBuildConfig globals $ planAndGenerate buildOpts baseDir outDir remoteUri revPkgs args

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
     , globalLogLevel = if argVerbose then LevelDebug else LevelInfo
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

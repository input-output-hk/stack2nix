{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}

module Stack2nix.External.Stack
  ( PackageRef(..), runPlan
  ) where

import           Control.Lens                                   ((<>~))
import qualified Data.Map.Strict                                as M
import           Data.Maybe                                     (fromJust)
import qualified Data.Set                                       as Set (fromList)
import           Data.Text                                      (pack,
                                                                 unpack)
import           Distribution.Nixpkgs.Haskell.Derivation        (Derivation,
                                                                 configureFlags)
import qualified Distribution.Nixpkgs.Haskell.Hackage           as DB
import           Distribution.Pretty                            (prettyShow)
import           Distribution.Types.PackageName                 (unPackageName)
import           Options.Applicative
import           Path                                           (fromRelDir,
                                                                 mkAbsDir)
import           Path.IO
import           Stack.Build.Target                             (NeedTargets (..))
import           Stack.Options.BuildParser
import           Stack.Options.GlobalParser
import           Stack.Options.Utils                            (GlobalOptsContext (..))
import           Stack.Prelude                                  hiding
                                                                (logDebug)
import           Stack.Runners                                  (ShouldReexec(..),
                                                                 withConfig,
                                                                 withEnvConfig,
                                                                 withRunnerGlobal)
import           Stack.Types.Compiler                           (ActualCompiler(..))
import           Stack.Types.Config
import           Stack.Types.Nix
import           Stack.Types.SourceMap                          (SourceMap(..),
                                                                 CommonPackage(..))
import           Stack2nix.External.Cabal2nix                   (cabal2nix)
import           Stack2nix.Hackage                              (loadHackageDB)
import           Stack2nix.Render                               (render)
import           Stack2nix.Types                                (Args (..), Flags, GhcOptions)
import           Stack2nix.Util                                 (ensureExecutable,
                                                                 logDebug,
                                                                 mapPool)
import           Text.PrettyPrint.HughesPJClass                 (Doc)

data PackageRef
  = HackagePackage GhcOptions Flags PackageIdentifier -- TODO: what about revisions?
  | NonHackagePackage GhcOptions Flags (ResolvedPath Dir)
  deriving (Eq, Show)

genNixFile :: Args -> Version -> Path Abs Dir -> Maybe String -> Maybe String -> DB.HackageDB -> PackageRef -> IO (Either Doc Derivation)
genNixFile args ghcVersion _baseDir uri argRev hackageDB pkgRef = do
  case pkgRef of
    HackagePackage ghcOptions flags pkgId ->
      fmap (addGhcOptions ghcOptions) <$>
        cabal2nix args ghcVersion ("cabal://" <> packageIdentifierString pkgId) Nothing Nothing flags hackageDB
    NonHackagePackage ghcOptions flags path -> do
      relPath <- fromRelDir <$> makeRelativeToCurrentDir (resolvedAbsolute path)
      let cabal2nix_uri = fromMaybe (toFilePath $ resolvedAbsolute path) uri
      let commit = pack <$> argRev
      let subpath = const relPath <$> uri
      fmap (addGhcOptions ghcOptions) <$>
        cabal2nix args ghcVersion cabal2nix_uri commit subpath flags hackageDB

-- TODO: remove once we use flags, options
sourceMapToPackages :: SourceMap -> [PackageRef]
sourceMapToPackages sm =
    map depPkgToPackage (M.elems $ smDeps sm) <> map projPkgToPackage (M.elems $ smProject sm)
  where
    depPkgToPackage ::DepPackage -> PackageRef
    depPkgToPackage dp = case dpLocation dp of
      PLMutable _ ->
        error "depPkgToPackage/PLMutable TBD"
      PLImmutable (PLIHackage pkgId _blobKey _treeKey) ->
        let common = dpCommon dp
        in HackagePackage (cpGhcOptions common) (M.toList $ cpFlags common) pkgId
      PLImmutable (PLIArchive{}) ->
        error "depPkgToPackage/PLIArchive TBD"
      PLImmutable (PLIRepo{}) ->
        error "depPkgToPackage/PLIRepo TBD"
    projPkgToPackage :: ProjectPackage -> PackageRef
    projPkgToPackage pp =
      let common = ppCommon pp
      in NonHackagePackage (cpGhcOptions common) (M.toList $ cpFlags common) (ppResolvedDir pp)

planAndGenerate
  :: HasEnvConfig env
  => Path Abs Dir
  -> Maybe String
  -> Args
  -> RIO env ()
planAndGenerate baseDir remoteUri args@Args {..} = do
  sourceMap <- view sourceMapL
  ghcVersion <- case smCompiler sourceMap of
    ACGhc v ->
      pure v
    ACGhcGit _ _ ->
      error "stack2nix doesn't support GHC from git"
  when argEnsureExecutables $
    liftIO $ ensureExecutable ("haskell.compiler.ghc" ++ nixVersion ghcVersion)

  let pkgs = sourceMapToPackages sourceMap
  liftIO $ logDebug args $ "plan:\n" ++ show pkgs

  hackageDB <- liftIO $ loadHackageDB Nothing argHackageSnapshot
  drvs      <- liftIO $ mapPool
    argThreads
    (genNixFile args ghcVersion baseDir remoteUri argRev hackageDB)
    pkgs
  let locals = map show $ M.keys (smProject sourceMap)
  let basePackageNames = Set.fromList . map unPackageName $ M.keys (smGlobal sourceMap)
  liftIO $ render drvs args locals (nixVersion ghcVersion) basePackageNames

addGhcOptions :: GhcOptions -> Derivation -> Derivation
addGhcOptions ghcOptions drv =
  drv & configureFlags <>~ (Set.fromList . map (unpack . ("--ghc-option=" <>)) $ ghcOptions)

runPlan :: Path Abs Dir
        -> Maybe String
        -> Args
        -> IO ()
runPlan baseDir remoteUri args = do
  let stackRoot = $(mkAbsDir "/tmp/s2n")
  ensureDir stackRoot
  globals <- globalOpts baseDir stackRoot args
  withRunnerGlobal globals $ withConfig NoReexec $ withEnvConfig NeedTargets buildOpts $
    planAndGenerate baseDir remoteUri args

nixVersion :: Version -> String
nixVersion =
  filter (/= '.') . prettyShow

globalOpts :: MonadIO m => Path Abs Dir -> Path b Dir -> Args -> m GlobalOpts
globalOpts currentDir stackRoot Args{..} = do
  go0 <- globalOptsFromMonoid False . fromJust . getParseResult $
      execParserPure defaultPrefs pinfo args
  globalStackYaml <- resolveFile currentDir argStackYaml
  pure $ go0 { globalReExecVersion = Just "2.3.3" -- TODO: obtain from stack lib if exposed
             , globalConfigMonoid =
               (globalConfigMonoid go0)
               { configMonoidNixOpts = mempty
                 { nixMonoidEnable = First (Just True)
                 }
               , configMonoidSystemGHC = First (Just True)
               }
             , globalStackYaml = SYLOverride globalStackYaml
             , globalLogLevel = if argVerbose then LevelDebug else LevelInfo
             }
  where
    pinfo = info (globalOptsParser (toFilePath currentDir) OuterGlobalOpts (Just LevelError)) briefDesc
    args = concat [ ["--stack-root", toFilePath stackRoot]
                  , ["--jobs", show argThreads]
                  , ["--test" | argTest]
                  , ["--bench" | argBench]
                  , ["--haddock" | argHaddock]
                  , ["--no-install-ghc"]
                  , ["--system-ghc"]
                  ]

buildOpts :: BuildOptsCLI
buildOpts = fromJust . getParseResult $ execParserPure defaultPrefs (info (buildOptsParser Build) briefDesc) ["--dry-run"]

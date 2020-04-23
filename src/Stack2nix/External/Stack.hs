{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix.External.Stack
  ( PackageRef(..), runPlan
  ) where

import           Control.Lens                                   ((%~))
import           Control.Monad                                  (when)
import           Data.List                                      (concat)
import qualified Data.Map.Strict                                as M
import           Data.Maybe                                     (fromJust)
import qualified Data.Set                                       as Set (fromList,
                                                                        union)
import           Data.Text                                      (pack, unpack)
import qualified Data.Text                                      as Text
import           Distribution.Nixpkgs.Haskell.Derivation        (Derivation,
                                                                 configureFlags)
import qualified Distribution.Nixpkgs.Haskell.Hackage           as DB
import           Distribution.Types.Version                     (nullVersion, versionNumbers)
import           Options.Applicative
import           Path                                           (parseRelFile, parseAbsDir, fromAbsDir)
import qualified Path                                           ((</>))
import           Stack.Build.Target                             (NeedTargets (..))
import           Stack.Config
import           Stack.Options.BuildParser
import           Stack.Options.GlobalParser
import           Stack.Options.Utils                            (GlobalOptsContext (..))
import           Stack.Prelude                                  hiding
                                                                 (local, logDebug)
import           Stack.Runners                                  (ShouldReexec(..), withConfig, withRunnerGlobal)
import           Stack.Setup                                    (setupEnv)
import           Stack.Types.Compiler                           (getGhcVersion, wantedToActual)
import           Stack.Types.Config
import           Stack.Types.Config.Build                       (BuildCommand (..))
import           Stack.Types.Nix
import           Stack.Types.SourceMap                          (CommonPackage(..), DepPackage(..), SourceMap(..))
import           Stack.Types.Version                            (Version)
import           Stack2nix.External.Cabal2nix                   (cabal2nix)
import           Stack2nix.Hackage                              (loadHackageDB)
import           Stack2nix.Render                               (render)
import           Stack2nix.Types                                (Args (..), Flags)
import           Stack2nix.Util                                 (ensureExecutable, 
                                                                 logDebug,
                                                                 mapPool)
import           System.Directory                               (canonicalizePath,
                                                                 createDirectoryIfMissing,
                                                                 getCurrentDirectory,
                                                                 makeAbsolute,
                                                                 makeRelativeToCurrentDirectory)
import           System.FilePath                                (makeRelative,
                                                                 (</>))
import           Text.PrettyPrint.HughesPJClass                 (Doc)

data PackageRef
  = HackagePackage Flags PackageIdentifier
  | NonHackagePackage Flags PackageLocation PackageIdentifier
  deriving (Eq, Show)

genNixFile :: Args -> Version -> FilePath -> Maybe String -> Maybe String -> DB.HackageDB -> PackageRef -> IO (Either Doc Derivation)
genNixFile args ghcVersion baseDir uri argRev hackageDB pkgRef = do
  cwd <- getCurrentDirectory
  case pkgRef of
    NonHackagePackage flags (PLImmutable (PLIArchive (Archive (ALUrl url) _ _ _)  _)) _ -> do
      let parts = Text.splitOn "/" url
      case parts of
        ("https:" : "" : "github.com" : owner : repo : "archive" : file) -> do
          let repoUrl = "https://github.com/" <> owner <> "/" <> repo <> ".git"
              rev = head . Text.splitOn "." . head $ file
          cabal2nix args ghcVersion (unpack repoUrl) (Just rev) Nothing flags hackageDB
        _ -> do
          error $ "genNixFile: unsupported archive URL: " <> show url 
    
    NonHackagePackage _flags (PLImmutable (PLIArchive (Archive (ALFilePath _path) _ _ _)  _)) _ -> do
      error $ "genNixFile: local archives are not supported"
    
    NonHackagePackage flags (PLImmutable (PLIRepo repo _)) _ ->
      cabal2nix args ghcVersion (unpack $ repoUrl repo) (Just $ repoCommit repo) (Just (unpack . repoSubdir $ repo)) flags hackageDB
    
    NonHackagePackage flags (PLMutable (ResolvedPath path _)) _ -> do
      relPath <- makeRelativeToCurrentDirectory (unpack . textDisplay $ path)
      projRoot <- canonicalizePath $ cwd </> baseDir
      let defDir = baseDir </> makeRelative projRoot (unpack . textDisplay $ path)
      cabal2nix args ghcVersion (fromMaybe defDir uri) (pack <$> argRev) (const relPath <$> uri) flags hackageDB
    
    NonHackagePackage _ (PLImmutable (PLIHackage _ _ _)) _ -> do
      error $ "genNixFile: impossible happened! got NonHackage Hackage package!"
    
    HackagePackage flags pkg@(PackageIdentifier _ _) ->
      cabal2nix args ghcVersion ("cabal://" <> packageIdentifierString pkg) Nothing Nothing flags hackageDB

-- TODO: remove once we use flags, options
sourceMapToPackages :: Map PackageName DepPackage -> [PackageRef]
sourceMapToPackages = map sourceToPackage . M.elems
  where
    sourceToPackage :: DepPackage -> PackageRef
    sourceToPackage dPkg = 
      let loc = dpLocation dPkg
          cPkg = dpCommon dPkg
      in
        case loc of
          PLImmutable (PLIHackage pir _ _) -> HackagePackage (M.toList . cpFlags $ cPkg) pir
          PLImmutable (PLIRepo _repo meta) -> NonHackagePackage (M.toList . cpFlags $ cPkg) loc (pmIdent meta)
          PLImmutable (PLIArchive _archive meta) -> NonHackagePackage (M.toList . cpFlags $ cPkg) loc (pmIdent meta)
          PLMutable (ResolvedPath _ _) -> NonHackagePackage (M.toList . cpFlags $ cPkg) loc undefined 

planAndGenerate
  :: BuildOptsCLI
  -> FilePath
  -> Maybe String
  -> Args
  -> Version
  -> RIO BuildConfig ()
planAndGenerate boptsCli baseDir remoteUri args@Args {..} ghcVersion = do
  envConfig <- setupEnv NeedTargets boptsCli Nothing
  let sourceMap = envConfigSourceMap envConfig
  let deps = smDeps sourceMap

  -- Stackage lists bin-package-db but it's in GHC 7.10's boot libraries
  binPackageDb <- parsePackageNameThrowing "bin-package-db"
  let projectPackages = M.elems 
                        . M.map
                        (\ projectPackage ->
                        let dir = ppResolvedDir projectPackage 
                            cPkg = ppCommon projectPackage
                        in NonHackagePackage (M.toList . cpFlags $ cPkg) (PLMutable dir) (PackageIdentifier (cpName . ppCommon $ projectPackage) nullVersion)
                        )
                        . smProject 
                        $ sourceMap
  let pkgs = sourceMapToPackages (M.delete binPackageDb deps) <> projectPackages
  liftIO $ logDebug args $ "plan:\n" ++ show pkgs

  hackageDB     <- liftIO $ loadHackageDB Nothing argHackageSnapshot
  let buildConf = envConfigBuildConfig envConfig
  drvs          <- liftIO $ mapPool
    argThreads
    (\p ->
      fmap (addGhcOptions buildConf p)
        <$> genNixFile args ghcVersion baseDir remoteUri argRev hackageDB p
    )
    pkgs
  let locals = M.elems . M.map (\ local -> show . cpName . ppCommon $ local) . smProject $ sourceMap
  liftIO . render drvs args locals $ (mconcat . map show . versionNumbers $ ghcVersion)

-- | Add ghc-options declared in stack.yaml to the nix derivation for a package
--   by adding to the configureFlags attribute of the derivation
addGhcOptions :: BuildConfig -> PackageRef -> Derivation -> Derivation
addGhcOptions buildConf pkgRef drv =
  drv & configureFlags %~ (Set.union stackGhcOptions)
 where
  stackGhcOptions :: Set String
  stackGhcOptions =
    let config = bcConfig buildConf
        opts   = fromMaybe [] . M.lookup pkgName . configGhcOptionsByName $ config
    in Set.fromList . map (unpack . ("--ghc-option=" <>)) $ opts
  pkgName :: PackageName
  pkgName = case pkgRef of
    HackagePackage _ (PackageIdentifier n  _) -> n
    NonHackagePackage  _ _ (PackageIdentifier n _) -> n

runPlan :: FilePath
        -> Maybe String
        -> Args
        -> IO ()
runPlan baseDir remoteUri args@Args{..} = do
  let stackRoot = "/tmp/s2n"
  createDirectoryIfMissing True stackRoot
  
  baseDir' <- parseAbsDir =<< makeAbsolute baseDir
  stackYaml <- parseRelFile argStackYaml

  globals <- globalOpts baseDir' stackRoot stackYaml args
  let stackFile = baseDir </> argStackYaml

  ghcVersion <- getGhcVersionIO globals stackFile
  when argEnsureExecutables $
    ensureExecutable ("haskell.compiler.ghc" ++ (mconcat . map show . versionNumbers $ ghcVersion))
  withRunnerGlobal globals $ withConfig NoReexec $ withBuildConfig $ planAndGenerate buildOpts baseDir remoteUri args ghcVersion

getGhcVersionIO :: GlobalOpts -> FilePath -> IO Version
getGhcVersionIO go _stackFile = do
  ver <- getGhcVersion . wantedToActual <$> (withRunnerGlobal go $ loadConfig $ \ _config -> withConfig NoReexec $ withBuildConfig $ 
    view wantedCompilerVersionL)
  return ver

-- globalOpts :: FilePath -> FilePath -> Args -> GlobalOpts
globalOpts 
  :: MonadIO m
  => Path Abs Dir
  -> String
  -> Path Rel File
  -> Args
  -> m GlobalOpts
globalOpts currentDir stackRoot stackYaml Args{..} = do
  opts <- go
  return $ opts { globalReExecVersion = Just "1.5.1" -- TODO: obtain from stack lib if exposed
     , globalConfigMonoid =
         (globalConfigMonoid opts)
         { configMonoidNixOpts = mempty
           { nixMonoidEnable = First (Just True)
           }
         }
     , globalStackYaml = SYLOverride $ currentDir Path.</> stackYaml
     , globalLogLevel = if argVerbose then LevelDebug else LevelInfo
     }
  where
    pinfo = info (globalOptsParser (fromAbsDir currentDir) OuterGlobalOpts (Just LevelError)) briefDesc
    args = concat [ ["--stack-root", stackRoot]
                  , ["--jobs", show argThreads]
                  , ["--test" | argTest]
                  , ["--bench" | argBench]
                  , ["--haddock" | argHaddock]
                  , ["--no-install-ghc"]
                  , ["--system-ghc"]
                  ]
    go = globalOptsFromMonoid False . fromJust . getParseResult $
      execParserPure defaultPrefs pinfo args

buildOpts :: BuildOptsCLI
buildOpts = fromJust . getParseResult $ execParserPure defaultPrefs (info (buildOptsParser Build) briefDesc) ["--dry-run"]

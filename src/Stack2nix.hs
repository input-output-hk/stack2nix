{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix
  ( Args(..)
  , stack2nix
  , version
  ) where

import           Control.Monad              (unless, void)
import           Data.Char                  (toLower)
import           Data.Fix                   (Fix (..))
import           Data.List                  (foldl', isInfixOf, isSuffixOf,
                                             sort, union, (\\))
import qualified Data.Map.Strict            as Map
import           Data.Maybe                 (isJust)
import           Data.Monoid                ((<>))
import           Data.Text                  (Text, unpack)
import           Path                       (parseAbsFile)
import           Paths_stack2nix            (version)
import           Stack.Config
import           Stack.Prelude              (LogLevel (..), runRIO)
import           Stack.Types.BuildPlan
import           Stack.Types.Config
import           Stack.Types.Runner
import           Stack2nix.External.Stack
import           Stack2nix.External.Util    (runCmdFrom)
import           Stack2nix.External.VCS.Git (Command (..), ExternalCmd (..),
                                             InternalCmd (..), git)
import           Stack2nix.Types            (Args (..))
import           Stack2nix.Util
import           System.Directory           (canonicalizePath, doesFileExist,
                                             getCurrentDirectory, withCurrentDirectory)
import           System.Environment         (getEnv)
import           System.FilePath            (dropExtension, isAbsolute,
                                             normalise, takeDirectory,
                                             takeFileName, (<.>), (</>))
import           System.FilePath.Glob       (glob)
import           System.IO.Temp             (withSystemTempDirectory)

stack2nix :: Args -> IO ()
stack2nix args@Args{..} = do
  checkRuntimeDeps
  updateCabalPackageIndex
  -- cwd <- getCurrentDirectory
  -- let projRoot = if isAbsolute argUri then argUri else cwd </> argUri
  let projRoot = argUri
  isLocalRepo <- doesFileExist $ projRoot </> "stack.yaml"
  logDebug args $ "stack2nix (isLocalRepo): " ++ show isLocalRepo
  logDebug args $ "stack2nix (projRoot): " ++ show projRoot
  logDebug args $ "stack2nix (argUri): " ++ show argUri
  if isLocalRepo
  then handleStackConfig Nothing projRoot
  else withSystemTempDirectory "s2n-" $ \tmpDir ->
    tryGit tmpDir >> handleStackConfig (Just argUri) tmpDir
  where
    checkRuntimeDeps :: IO ()
    checkRuntimeDeps = do
      assertMinVer "git" "2"
      assertMinVer "cabal" "2"

    updateCabalPackageIndex :: IO ()
    updateCabalPackageIndex =
      getEnv "HOME" >>= \home -> void $ runCmdFrom home "cabal" ["update"]

    tryGit :: FilePath -> IO ()
    tryGit tmpDir = do
      void $ git $ OutsideRepo $ Clone argUri tmpDir
      case argRev of
        Just r  -> void $ git $ InsideRepo tmpDir (Checkout r)
        Nothing -> return mempty

    handleStackConfig :: Maybe String -> FilePath -> IO ()
    handleStackConfig remoteUri localDir = do
      cwd <- getCurrentDirectory
      logDebug args $ "handleStackConfig (cwd): " ++ cwd
      logDebug args $ "handleStackConfig (localDir): " ++ localDir
      logDebug args $ "handleStackConfig (remoteUri): " ++ show remoteUri
      let stackFile = localDir </> "stack.yaml"
      alreadyExists <- doesFileExist stackFile
      unless alreadyExists $ error $ stackFile <> " does not exist. Use 'stack init' to create it."
      logDebug args $ "handleStackConfig (alreadyExists): " ++ show alreadyExists
      cp <- canonicalizePath stackFile
      fp <- parseAbsFile cp
      lc <- withRunner LevelError True False ColorAuto Nothing False $ \runner ->
        -- https://www.fpcomplete.com/blog/2017/07/the-rio-monad
        runRIO runner $ loadConfig mempty Nothing (SYLOverride fp)
      let go = if isJust remoteUri
               then withCurrentDirectory localDir
               else id
      go $ do
        bc <- lcLoadBuildConfig lc Nothing -- compiler
        withSystemTempDirectory "s2n" $ \outDir -> do
          let packages = filter (\p -> case p of
                                         PLIndex _          -> False
                                         PLOther (PLRepo _) -> True
                                         _ -> error $ "Unsupported build config dependency: " ++ show p) (bcDependencies bc)
          runPlan localDir outDir remoteUri (map toPackageRef packages) lc args

toPackageRef :: PackageLocationIndex Subdirs -> PackageRef
toPackageRef (PLOther (PLRepo repo)) = RepoPackage repo
toPackageRef p = error $ "Unsupported package location index: " ++ show p

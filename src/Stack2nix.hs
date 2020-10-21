{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix
  ( Args(..)
  , stack2nix
  , version
  ) where

import           Control.Monad              (unless, void, when)
import           Data.Maybe                 (isJust)
import           Path
import           Path.IO
import           Paths_stack2nix            (version)
import           Stack2nix.External.Stack
import           Stack2nix.External.Util    (runCmdFrom, failHard)
import           Stack2nix.External.VCS.Git (Command (..), ExternalCmd (..),
                                             InternalCmd (..), git)
import           Stack2nix.Types            (Args (..))
import           Stack2nix.Util
import           System.Environment         (getEnv, setEnv)

stack2nix :: Args -> IO ()
stack2nix args@Args{..} = do
  when argEnsureExecutables $ do
    ensureExecutableExists "cabal" "cabal-install"
    ensureExecutableExists "git" "git"
    ensureExecutableExists "nix-prefetch-git" "nix-prefetch-scripts"
  assertMinVer "git" "2"
  assertMinVer "cabal" "2"
  setEnv "GIT_QUIET" "y"
  updateCabalPackageIndex
  -- cwd <- getCurrentDirectory
  -- let projRoot = if isAbsolute argUri then argUri else cwd </> argUri
  projRoot <- resolveDir' argUri
  stackYaml <- resolveFile projRoot argStackYaml
  isLocalRepo <- doesFileExist stackYaml
  logDebug args $ "stack2nix (isLocalRepo): " ++ show isLocalRepo
  logDebug args $ "stack2nix (projRoot): " ++ show projRoot
  logDebug args $ "stack2nix (argUri): " ++ show argUri
  if isLocalRepo
  then handleStackConfig Nothing projRoot
  else withSystemTempDir "s2n-" $ \tmpDir ->
    tryGit (fromAbsDir tmpDir) >> handleStackConfig (Just argUri) tmpDir
  where
    updateCabalPackageIndex :: IO ()
    updateCabalPackageIndex = do
      home <- getEnv "HOME"
      out <- runCmdFrom home "cabal" ["update"]
      void $ failHard out

    tryGit :: FilePath -> IO ()
    tryGit tmpDir = do
      void $ git $ OutsideRepo $ Clone argUri tmpDir
      case argRev of
        Just r  -> void $ git $ InsideRepo tmpDir (Checkout r)
        Nothing -> return mempty

    handleStackConfig :: Maybe String -> Path Abs Dir -> IO ()
    handleStackConfig remoteUri localDir = do
      cwd <- getCurrentDir
      logDebug args $ "handleStackConfig (cwd): " ++ fromAbsDir cwd
      logDebug args $ "handleStackConfig (localDir): " ++ fromAbsDir localDir
      logDebug args $ "handleStackConfig (remoteUri): " ++ show remoteUri
      stackFile <- resolveFile localDir argStackYaml
      alreadyExists <- doesFileExist stackFile
      unless alreadyExists $ error $ fromAbsFile stackFile <> " does not exist. Use 'stack init' to create it."
      logDebug args $ "handleStackConfig (alreadyExists): " ++ show alreadyExists
      let go = if isJust remoteUri
               then withCurrentDir localDir
               else id
      go $ runPlan localDir remoteUri args

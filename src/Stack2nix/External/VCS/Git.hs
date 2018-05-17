module Stack2nix.External.VCS.Git
  ( Command(..), ExternalCmd(..), InternalCmd(..)
  , git
  ) where

import           Stack2nix.External.Util (failHard, runCmd, runCmdFrom)
import           System.Exit             (ExitCode (..))

data Command
  = OutsideRepo ExternalCmd
  | InsideRepo FilePath InternalCmd

data ExternalCmd
  = Clone RepoUri FilePath
  | CloneRecursive RepoUri FilePath

data InternalCmd 
  = Checkout CommitRef
  | CheckoutRecursive CommitRef

type RepoUri = String
type CommitRef = String

exe :: String
exe = "git"

-- Requires git binary in PATH
git :: Command -> IO (ExitCode, String, String)
git (OutsideRepo cmd)    = runExternal cmd
git (InsideRepo dir cmd) = runInternal dir cmd

runExternal :: ExternalCmd -> IO (ExitCode, String, String)
runExternal (Clone uri dir) =
  runCmd exe ["clone", uri, dir] >>= failHard
runExternal (CloneRecursive uri dir) =
  runCmd exe ["clone", "--recurse-submodules", uri, dir] >>= failHard

runInternal :: FilePath -> InternalCmd -> IO (ExitCode, String, String)
runInternal repoDir (Checkout ref) = 
  runCmdFrom repoDir exe ["checkout", ref]  >>= failHard
runInternal repoDir (CheckoutRecursive ref) = do
  checkoutCmd <- runCmdFrom repoDir exe ["checkout", ref] 
  _ <- failHard checkoutCmd
  submoduleCmd <- runCmdFrom repoDir exe ["submodule", "update", "--init", "--recursive"]
  failHard submoduleCmd

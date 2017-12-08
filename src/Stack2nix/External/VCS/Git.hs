module Stack2nix.External.VCS.Git
  ( Command(..), ExternalCmd(..), InternalCmd(..)
  , git
  ) where

import           Stack2nix.External.Util (failHardWith, runCmd, runCmdFrom)
import           System.Exit             (ExitCode (..))

data Command = OutsideRepo ExternalCmd
             | InsideRepo FilePath InternalCmd
data ExternalCmd = Clone String FilePath
data InternalCmd = Checkout CommitRef

type CommitRef = String

exe :: String
exe = "git"

-- Requires git binary in PATH
git :: Command -> IO (ExitCode, String, String)
git (OutsideRepo cmd)    = runExternal cmd
git (InsideRepo dir cmd) = runInternal dir cmd

runExternal :: ExternalCmd -> IO (ExitCode, String, String)
runExternal (Clone uri dir) =
  runCmd exe ["clone", uri, dir] >>= failHardWith ("git: expected " ++ uri ++ " to be a repository, but it can't be cloned")

runInternal :: FilePath -> InternalCmd -> IO (ExitCode, String, String)
runInternal repoDir (Checkout ref) =
  runCmdFrom repoDir exe ["checkout", ref] >>= failHardWith ("git: failed to checkout revision " ++ ref)

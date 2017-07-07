module Stack2nix.External.VCS.Git
  ( Command(..), ExternalCmd(..), InternalCmd(..)
  , git
  ) where

import           Stack2nix.External.Util (failHard, runCmd, runCmdFrom)
import           Stack2nix.Types

data Command = OutsideRepo ExternalCmd
             | InsideRepo FilePath InternalCmd
data ExternalCmd = Clone String FilePath
data InternalCmd = Checkout CommitRef

type CommitRef = String

exe :: String
exe = "git"

-- Requires git binary in PATH
git :: Args -> Command -> IO ()
git args (OutsideRepo cmd)    = runExternal args  cmd
git args (InsideRepo dir cmd) = runInternal args dir cmd

runExternal :: Args -> ExternalCmd -> IO ()
runExternal args (Clone uri dir) = do
   runCmd args exe ["clone", uri, dir] >>= failHard

runInternal :: Args -> FilePath -> InternalCmd -> IO ()
runInternal args repoDir (Checkout ref) = do
   runCmdFrom args repoDir exe ["checkout", ref] >>= failHard

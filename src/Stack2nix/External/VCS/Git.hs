module Stack2nix.External.VCS.Git
  ( Command(..), ExternalCmd(..), InternalCmd(..)
  , git
  ) where

import           Stack2nix.External.Util (failHard, runCmd, runCmdFrom)

data Command = OutsideRepo ExternalCmd
             | InsideRepo FilePath InternalCmd
data ExternalCmd = Clone String FilePath
data InternalCmd = Checkout CommitRef

type CommitRef = String

exe :: String
exe = "git"

-- Requires git binary in PATH
git :: Command -> IO ()
git (OutsideRepo cmd)    = runExternal cmd
git (InsideRepo dir cmd) = runInternal dir cmd

runExternal :: ExternalCmd -> IO ()
runExternal (Clone uri dir) = do
   runCmd exe ["clone", uri, dir] >>= failHard

runInternal :: FilePath -> InternalCmd -> IO ()
runInternal repoDir (Checkout ref) = do
   runCmdFrom repoDir exe ["checkout", ref] >>= failHard

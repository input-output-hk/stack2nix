module Stack2nix.External.VCS.Git
  ( git
  ) where

import           Stack2nix.External.Util (runCmd, runCmdFrom)

data Command = OutsideRepo ExternalCmd
             | InsideRepo FilePath InternalCmd
data ExternalCmd = Clone String FilePath
data InternalCmd = Checkout CommitRef

data CommitRef = Sha1 String

exe :: String
exe = "git"

-- Requires git binary in PATH
git :: Command -> IO ()
git (OutsideRepo cmd)    = runExternal cmd
git (InsideRepo dir cmd) = runInternal dir cmd

runExternal :: ExternalCmd -> IO ()
runExternal (Clone uri dir) =
  runCmd exe ["clone", uri, dir] $ return mempty

runInternal :: FilePath -> InternalCmd -> IO ()
runInternal repoDir (Checkout ref) =
  runCmdFrom repoDir exe ["checkout", showRef ref] $ return mempty
  where
    showRef :: CommitRef -> String
    showRef (Sha1 hash) = hash

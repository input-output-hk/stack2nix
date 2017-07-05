module Stack2nix.External.Util where

import           System.Directory (getCurrentDirectory)
import           System.Exit      (ExitCode (..))
import           System.Process   (CreateProcess (..))
import           System.Process   (proc, readCreateProcessWithExitCode)

type CmdResult = (Bool, String, String)

runCmdFrom :: FilePath -> String -> [String] -> IO CmdResult
runCmdFrom dir prog args = do
  (exitCode, stdout, stderr) <- readCreateProcessWithExitCode (fromDir dir (proc prog args)) ""
  case exitCode of
    ExitSuccess -> return $ (True,  stdout, stderr)
    _           -> return $ (False, stdout, stderr)
  where
    fromDir :: FilePath -> CreateProcess -> CreateProcess
    fromDir d procDesc = procDesc { cwd = Just d }

runCmd :: String -> [String] -> IO CmdResult
runCmd prog args = getCurrentDirectory >>= (\d -> runCmdFrom d prog args)

failHard :: CmdResult -> IO ()
failHard (False, _, stderr) = error $ show stderr
failHard (True, _, _)       = mempty

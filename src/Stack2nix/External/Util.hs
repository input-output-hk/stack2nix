module Stack2nix.External.Util where

import           System.Process (CreateProcess(..))
import           System.Directory (getCurrentDirectory)
import           System.Exit    (ExitCode (..))
import           System.Process (proc, readCreateProcessWithExitCode)

runCmdFrom :: FilePath -> String -> [String] -> (String -> IO ()) -> IO ()
runCmdFrom dir prog args onSuccess = do
  (exitCode, stdout, stderr) <- readCreateProcessWithExitCode (fromDir dir (proc prog args)) ""
  case exitCode of
    ExitSuccess -> onSuccess stdout
    _ -> error stderr
  where
    fromDir :: FilePath -> CreateProcess -> CreateProcess
    fromDir d procDesc = procDesc { cwd = Just d }

runCmd :: String -> [String] -> (String -> IO ()) -> IO ()
runCmd prog args onSuccess = getCurrentDirectory >>= (\d -> runCmdFrom d prog args onSuccess)

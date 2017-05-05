module Stack2nix.External.Util where

import           Data.List        (intercalate)
import           Data.Monoid      ((<>))
import           System.Directory (getCurrentDirectory)
import           System.Exit      (ExitCode (..))
import           System.Process   (CreateProcess (..))
import           System.Process   (proc, readCreateProcessWithExitCode)

runCmdFrom :: FilePath -> String -> [String] -> (String -> IO ()) -> IO ()
runCmdFrom dir prog args onSuccess = do
  (exitCode, stdout, stderr) <- readCreateProcessWithExitCode (fromDir dir (proc prog args)) ""
  case exitCode of
    ExitSuccess -> onSuccess stdout
    _           -> error $ "Failed to run: '" <> cmd <> "'\n\n" <> stderr
  where
    fromDir :: FilePath -> CreateProcess -> CreateProcess
    fromDir d procDesc = procDesc { cwd = Just d }

    cmd = "cd \"" <> dir <> "\" && " <> intercalate " " (prog:args)

runCmd :: String -> [String] -> (String -> IO ()) -> IO ()
runCmd prog args onSuccess = getCurrentDirectory >>= (\d -> runCmdFrom d prog args onSuccess)

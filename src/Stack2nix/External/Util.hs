module Stack2nix.External.Util where

import           Data.Monoid      ((<>))
import           System.Directory (getCurrentDirectory)
import           System.Exit      (ExitCode (..))
import           System.Process   (CreateProcess (..), proc,
                                   readCreateProcessWithExitCode)

runCmdFrom :: FilePath -> String -> [String] -> IO (ExitCode, String, String)
runCmdFrom dir prog args =
  readCreateProcessWithExitCode (fromDir dir (proc prog args)) ""
  where
    fromDir :: FilePath -> CreateProcess -> CreateProcess
    fromDir d procDesc = procDesc { cwd = Just d }

runCmd :: String -> [String] -> IO (ExitCode, String, String)
runCmd prog args = getCurrentDirectory >>= (\d -> runCmdFrom d prog args)

failHardWith :: String -> (ExitCode, String, String) -> IO (ExitCode, String, String)
failHardWith _msg r@(ExitSuccess, _, _)        = pure r
failHardWith msg (ExitFailure code, _, stderr) =
  error $ unlines [ "Failed with exit code " <> show code <> "..."
                  , stderr
                  , msg
                  ]

failHard :: (ExitCode, String, String) -> IO (ExitCode, String, String)
failHard = failHardWith ""

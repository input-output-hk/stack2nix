module Stack2nix.External.Util where

import           Data.List        (intercalate)
import           Data.Monoid      ((<>))
import           System.Directory (getCurrentDirectory)
import           System.Exit      (ExitCode (..))
import           System.Process   (CreateProcess (..))
import           System.Process   (proc, readCreateProcessWithExitCode)

runCmdFrom :: FilePath -> String -> [String] -> IO (Either String String)
runCmdFrom dir prog args = do
  (exitCode, stdout, stderr) <- readCreateProcessWithExitCode (fromDir dir (proc prog args)) ""
  case exitCode of
    ExitSuccess -> return $ Right stdout
    _           -> return $ Left stderr
  where
    fromDir :: FilePath -> CreateProcess -> CreateProcess
    fromDir d procDesc = procDesc { cwd = Just d }

    cmd = "cd \"" <> dir <> "\" && " <> intercalate " " (prog:args)

runCmd :: String -> [String] -> IO (Either String String)
runCmd prog args = getCurrentDirectory >>= (\d -> runCmdFrom d prog args)

failHard :: Show a => Either a b -> IO ()
failHard (Left stderr) = error $ show stderr
failHard (Right _)     = mempty

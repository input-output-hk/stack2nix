{-# LANGUAGE RecordWildCards   #-}

module Stack2nix.External.Util where

import           Control.Monad
import           Data.List
import           Data.Monoid
import           System.Directory (getCurrentDirectory)
import           System.Exit      (ExitCode (..))
import           System.Process   (CreateProcess (..))
import           System.Process   (proc, readCreateProcessWithExitCode)
import qualified System.IO               as Sys
import           Text.Printf      (printf)

import           Stack2nix.Types


type CmdResult = (Bool, String, String)


runCmdFrom :: Args -> FilePath -> String -> [String] -> IO CmdResult
runCmdFrom Args{..} dir prog args = do
  when argVerbose $
    Sys.hPutStrLn Sys.stderr $ "runCmdFrom \"" <> dir <> "\" " <> prog <> " " <> show (intercalate " " args)
  (exitCode, stdout, stderr) <- readCreateProcessWithExitCode (fromDir dir (proc prog args)) ""
  case exitCode of
    ExitSuccess -> return $ (True,  stdout, stderr)
    _           -> return $ if argErrorsFatal
                            then error $ printf "FATAL: command %s %s returned exitCore=%s" prog (intercalate " " args) (show exitCode)
                            else (False, stdout, stderr)
  where
    fromDir :: FilePath -> CreateProcess -> CreateProcess
    fromDir d procDesc = procDesc { cwd = Just d }

runCmd :: Args -> String -> [String] -> IO CmdResult
runCmd args prog progargs = getCurrentDirectory >>= (\d -> runCmdFrom args d prog progargs)

failHard :: CmdResult -> IO ()
failHard (False, _, stderr) = error $ show stderr
failHard (True, _, _)       = mempty

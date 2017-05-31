module Main ( main ) where

import           Data.Semigroup      ((<>))
import           Options.Applicative
import           Stack2nix

args :: Parser Args
args = Args
       <$> optional (strOption $ long "revision" <> help "revision to use when fetching from VCS")
       <*> optional (strOption $ long "outdir" <> help "output directory for generated nix expressions")
       <*> strArgument (metavar "URI")

main :: IO ()
main = stack2nix =<< execParser opts
  where
    opts = info (args <**> helper) $
      fullDesc
      <> progDesc "this is a progDesc"

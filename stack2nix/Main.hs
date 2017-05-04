module Main ( main ) where

import           Data.Semigroup      ((<>))
import           Options.Applicative
import           Stack2nix

args :: Parser Args
args = Args
       <$> strArgument (metavar "URI")

main :: IO ()
main = stack2nix =<< execParser opts
  where
    opts = info (args <**> helper) $
      fullDesc
      <> progDesc "this is a progDesc"

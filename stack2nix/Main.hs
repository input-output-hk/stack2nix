module Main ( main ) where

import           Data.Semigroup      ((<>))
import           Distribution.Text   (display)
import           Options.Applicative
import           Stack2nix

args :: Parser Args
args = Args
       <$> optional (strOption $ long "revision" <> help "revision to use when fetching from VCS")
       <*> optional (strOption $ short 'o' <> help "output file for generated nix expression")
       <*> strArgument (metavar "URI")

main :: IO ()
main = stack2nix =<< execParser opts
  where
    opts = info
      (helper
       <*> infoOption ("stack2nix " ++ display version) (long "version" <> help "Show version number")
       <*> args) $
      fullDesc
      <> progDesc "Generate a nix expression for a Haskell package using stack"

{-# LANGUAGE RecordWildCards #-}

module Main
  ( Options
  , main
  , run
  ) where

import Data.Semigroup ((<>))
import Stack2nix
import Options.Applicative

data Options = Options
  { optUrl :: String
  }
  deriving (Show)

options :: Parser Options
options = Options
          <$> strArgument (metavar "URI")

main :: IO ()
main = run =<< execParser opts
  where
    opts = info (options <**> helper) $
      fullDesc
      <> progDesc "this is a progDesc"

run :: Options -> IO ()
run Options{..} = stack2nix optUrl

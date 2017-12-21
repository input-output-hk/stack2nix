module Stack2nix.Types where

import Data.Time (UTCTime)

data Args = Args
  { argRev             :: Maybe String
  , argOutFile         :: Maybe FilePath
  , argThreads         :: Int
  , argTest            :: Bool
  , argHaddock         :: Bool
  , argHackageSnapshot :: Maybe UTCTime
  , argUri             :: String
  , argVerbose         :: Bool
  }
  deriving (Show)

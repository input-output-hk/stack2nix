module Stack2nix.Types where

import Data.Time (UTCTime)
import Distribution.System (Platform)

data Args = Args
  { argRev             :: Maybe String
  , argOutFile         :: Maybe FilePath
  , argStackYaml       :: FilePath
  , argThreads         :: Int
  , argTest            :: Bool
  , argHaddock         :: Bool
  , argHackageSnapshot :: Maybe UTCTime
  , argPlatform        :: Platform
  , argUri             :: String
  , argVerbose         :: Bool
  , argStackYaml       :: String
  }
  deriving (Show)

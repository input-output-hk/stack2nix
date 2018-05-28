module Stack2nix.Types where

import           Data.Time           (UTCTime)
import           Distribution.System (Platform)

data Args = Args
  { argRev             :: Maybe String
  , argOutFile         :: Maybe FilePath
  , argStackYaml       :: FilePath
  , argThreads         :: Int
  , argTest            :: Bool
  , argBench           :: Bool
  , argHaddock         :: Bool
  , argHackageSnapshot :: Maybe UTCTime
  , argPlatform        :: Platform
  , argUri             :: String
  , argIndent          :: Bool
  , argVerbose         :: Bool
  }
  deriving (Show)

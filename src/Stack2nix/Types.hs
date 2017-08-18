module Stack2nix.Types where

data Args = Args
  { argRev     :: Maybe String
  , argOutFile :: Maybe FilePath
  , argThreads :: Int
  , argTest    :: Bool
  , argHaddock :: Bool
  , argUri     :: String
  }
  deriving (Show)

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix.Types where

data Args = Args
  { argRev         :: Maybe String
  , argOutFile     :: Maybe FilePath
  , argUri         :: String
  , argErrorsFatal :: Bool
  , argSerialise   :: Bool
  , argVerbose     :: Bool
  }
  deriving (Show)

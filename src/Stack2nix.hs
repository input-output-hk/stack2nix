{-# LANGUAGE OverloadedStrings #-}

module Stack2nix
  ( Config(..)
  , Package(..)
  , RemotePkgConf(..)
  , parseStackYaml
  ) where

import Data.ByteString (ByteString)
import Data.Maybe (fromMaybe)
import Data.Text (Text, unpack)
import qualified Data.Yaml as Y
import Data.Yaml (FromJSON(..), (.:), (.:?), (.!=))

data Config =
  Config { resolver  :: Text
         , packages  :: [Package]
         , extraDeps :: [Text]
         }
  deriving (Show, Eq)

data Package = LocalPkg FilePath
             | RemotePkg RemotePkgConf
             deriving (Show, Eq)

data RemotePkgConf =
  RemotePkgConf { gitUrl :: Text
                , commit :: Text
                , extraDep :: Bool
                }
  deriving (Show, Eq)

instance FromJSON Config where
  parseJSON (Y.Object v) =
    Config <$>
    v .: "resolver" <*>
    v .: "packages" <*>
    v .: "extra-deps"
  parseJSON _ = fail "Expected Object for Config value"

instance FromJSON Package where
  parseJSON (Y.String v) = return $ LocalPkg $ unpack v
  parseJSON obj@(Y.Object _) = RemotePkg <$> parseJSON obj
  parseJSON _ = fail "Expected String or Object for Package value"

instance FromJSON RemotePkgConf where
  parseJSON (Y.Object v) = do
    loc <- v .: "location"
    git <- loc .: "git"
    commit <- loc .: "commit"
    extra <- v .:? "extra-dep" .!= False
    return $ RemotePkgConf git commit extra
  parseJSON _ = fail "Expected Object for RemotePkgConf value"

parseStackYaml :: ByteString -> Maybe Config
parseStackYaml = Y.decode

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix
  ( Args(..)
  , Package(..)
  , RemotePkgConf(..)
  , StackConfig(..)
  , parseStackYaml
  , stack2nix
  ) where

import qualified Data.ByteString      as BS
import           Data.Foldable        (traverse_)
import           Data.Monoid          ((<>))
import           Data.Text            (Text, unpack)
import           Data.Yaml            (FromJSON (..), (.!=), (.:), (.:?))
import qualified Data.Yaml            as Y
import           Stack2nix.External   (cabal2nix)
import           Stack2nix.Repo       (readRepoFile)
import           System.FilePath      (dropExtension, takeFileName, (</>))
import           System.FilePath.Glob (glob)

data Args = Args
  { argUri :: String
  }
  deriving (Show)

data StackConfig = StackConfig
  { resolver  :: Text
  , packages  :: [Package]
  , extraDeps :: [Text]
  }
  deriving (Show, Eq)

data Package = LocalPkg FilePath
             | RemotePkg RemotePkgConf
             deriving (Show, Eq)

data RemotePkgConf = RemotePkgConf
  { gitUrl   :: Text
  , commit   :: Text
  , extraDep :: Bool
  }
  deriving (Show, Eq)

instance FromJSON StackConfig where
  parseJSON (Y.Object v) =
    StackConfig <$>
    v .: "resolver" <*>
    v .: "packages" <*>
    v .: "extra-deps"
  parseJSON _ = fail "Expected Object for StackConfig value"

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

parseStackYaml :: BS.ByteString -> Maybe StackConfig
parseStackYaml = Y.decode

{-
  Unused parts of sample input stack.yaml

  * resolver
  * extraDep and extraDeps
-}

-- TODO: Factor out pure parts.
stack2nix :: Args -> IO ()
stack2nix Args{..} = do
  yaml <- readRepoFile argUri "stack.yaml"
  case parseStackYaml yaml of
    Just config -> toNix argUri config
    Nothing     -> error $ "Failed to parse " <> argUri

toNix :: FilePath -> StackConfig -> IO ()
toNix baseDir StackConfig{..} = do
  traverse_ genNixFile packages
  nixFiles <- glob "*.nix"
  writeFile "default.nix" $ defaultNix $ map overrideFor nixFiles
    where
      genNixFile :: Package -> IO ()
      genNixFile (LocalPkg relPath) = cabal2nix dir Nothing Nothing
        where
          dir = if relPath == "." then baseDir else baseDir </> relPath
      genNixFile (RemotePkg RemotePkgConf{..}) = cabal2nix (unpack gitUrl) (Just commit) Nothing

      overrideFor :: FilePath -> String
      overrideFor nixFile = "    " <> name <> " = super.callPackage " <> nixFile <> " { };"
        where
          name = dropExtension $ takeFileName nixFile

      defaultNix overrides = unlines $
        [ "{ pkgs ? (import <nixpkgs> {})"
        , ", compiler ? pkgs.haskell.packages.ghc802"
        , "}:"
        , ""
        , "with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit pkgs; });"
        , ""
        , "compiler.override {"
        , "  overrides = self: super: {"
        ] ++ overrides ++
        [ "  };"
        , "}"
        ]

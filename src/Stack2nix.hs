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

import qualified Data.ByteString            as BS
import           Data.Fix                   (Fix (..))
import           Data.Foldable              (traverse_)
import           Data.Map.Strict            (member)
import           Data.Monoid                ((<>))
import           Data.Text                  (Text, intercalate, pack, unpack)
import           Data.Yaml                  (FromJSON (..), (.!=), (.:), (.:?))
import qualified Data.Yaml                  as Y
import           Nix.Expr                   (NExprF (..), ParamSet (..),
                                             Params (..))
import           Nix.Parser                 (Result (..), parseNixFile)
import           Stack2nix.External         (cabal2nix)
import           Stack2nix.External.VCS.Git (Command (..), ExternalCmd (..),
                                             InternalCmd (..), git)
import           System.Directory           (doesFileExist)
import           System.FilePath            (dropExtension, takeFileName, (</>))
import           System.FilePath.Glob       (glob)
import           System.IO.Temp             (withSystemTempDirectory)

data Args = Args
  { argRev :: Maybe String
  , argUri :: String
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
    gitUrl <- loc .: "git"
    commit <- loc .: "commit"
    extra <- v .:? "extra-dep" .!= False
    return $ RemotePkgConf gitUrl commit extra
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
  isLocalRepo <- doesFileExist (argUri </> "stack.yaml")
  if isLocalRepo
  then handleStackConfig False =<< BS.readFile (argUri </> "stack.yaml")
  else handleStackConfig True =<< withSystemTempDirectory "s2n-" tryGit
  where
    tryGit :: FilePath -> IO BS.ByteString
    tryGit tmpDir = do
      git (OutsideRepo (Clone argUri tmpDir))
      case argRev of
        Just r  -> git (InsideRepo tmpDir (Checkout r))
        Nothing -> return mempty
      BS.readFile (tmpDir </> "stack.yaml")

    handleStackConfig :: Bool -> BS.ByteString -> IO ()
    handleStackConfig isRemote yaml = do
      case parseStackYaml yaml of
        Just config -> toNix isRemote argUri config
        Nothing     -> error $ "Failed to parse " <> argUri

toNix :: Bool -> FilePath -> StackConfig -> IO ()
toNix _isRemote baseDir StackConfig{..} = do
  traverse_ genNixFile packages
  putStrLn . unpack $ "TODO: handle extra-deps section:\n  " <> intercalate "\n  " extraDeps
  nixFiles <- glob "*.nix"
  overrides <- mapM overrideFor nixFiles
  writeFile "default.nix" $ defaultNix overrides
    where
      genNixFile :: Package -> IO ()
      genNixFile (LocalPkg relPath) =
        cabal2nix baseDir Nothing (Just relPath)
      genNixFile (RemotePkg RemotePkgConf{..}) =
        cabal2nix (unpack gitUrl) (Just commit) Nothing

      overrideFor :: FilePath -> IO String
      overrideFor nixFile = do
        deps <- externalDeps
        return $ "    " <> name <> " = super.callPackage ./" <> name <> ".nix { " <> deps <> " };"
        where
          name = dropExtension $ takeFileName nixFile

          externalDeps :: IO String
          externalDeps = do
            collide <- hasNameCollision nixFile
            return $ if collide
                     then name <> " = pkgs." <> name <> ";"
                     else ""

          hasNameCollision :: FilePath -> IO Bool
          hasNameCollision fname = do
            nf <- parseNixFile fname
            case nf of
              Success expr -> do
                case expr of
                  Fix (NAbs (ParamSet (FixedParamSet deps) _) _) ->
                    return $ member (pack name) deps
                  _ -> return False
              Failure err -> error $ show err


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

{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}

module Stack2nix.External.Cabal2nix (
  cabal2nix
  ) where

import           Cabal2nix                   (cabal2nixWithDB, parseArgs, optNixpkgsIdentifier, Options)
import           Control.Lens
import           Data.Maybe                  (fromMaybe)
import           Data.Text                   (Text, unpack)
import qualified Distribution.Nixpkgs.Haskell.Hackage as DB
import           Distribution.Nixpkgs.Haskell.Derivation (Derivation)
import           Distribution.System         (Platform(..), Arch(..), OS(..))
import           Language.Nix
import           System.IO                   (hPutStrLn, stderr)
import           Stack2nix.Types             (Args (..))

import           Text.PrettyPrint.HughesPJClass (Doc)

cabal2nix :: Args -> FilePath -> Maybe Text -> Maybe FilePath -> DB.HackageDB -> IO (Either Doc Derivation)
cabal2nix Args{..} uri commit subpath hackageDB = do
  let runCmdArgs = args $ fromMaybe "." subpath
  hPutStrLn stderr $ unwords ("+ cabal2nix":runCmdArgs)
  options <- parseArgs runCmdArgs
  cabal2nixWithDB hackageDB $ cabalOptions options

  where
    args :: FilePath -> [String]
    args dir = concat
      [ maybe [] (\c -> ["--revision", unpack c]) commit
      , ["--subpath", dir]
      , ["--system", fromCabalPlatform argPlatform]
      , [uri]
      ]

-- Override default nixpkgs resolver to do pkgs.attr instead of attr
cabalOptions :: Options -> Options
cabalOptions options =
  options {
    optNixpkgsIdentifier = \i -> Just (binding # (i, path # ["pkgs", i]))
  }

-- | Copied (and modified) from src/Distribution/Nixpkgs/Meta.hs
fromCabalPlatform :: Platform -> String
fromCabalPlatform (Platform I386 Linux)   = "i686-linux"
fromCabalPlatform (Platform X86_64 Linux) = "x86_64-linux"
fromCabalPlatform (Platform X86_64 OSX)   = "x86_64-darwin"
fromCabalPlatform p                       = error ("fromCabalPlatform: invalid Nix platform" ++ show p)

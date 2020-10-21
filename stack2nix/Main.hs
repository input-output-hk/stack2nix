{-# LANGUAGE LambdaCase #-}

module Main ( main ) where

import           Data.List                 (intercalate, isPrefixOf)
import           Data.List.Split           (splitOn)
import           Data.Maybe                (fromMaybe, listToMaybe)
import           Data.Time                 (UTCTime, defaultTimeLocale,
                                            parseTimeM)
import           Data.Version              (showVersion)
import           Distribution.System       (Arch (..), OS (..), Platform (..),
                                            ClassificationStrictness(..),
                                            buildPlatform, classifyArch, classifyOS)
import           Distribution.Text         (display)
import           Options.Applicative
import           Stack2nix
import           System.IO                 (BufferMode (..), hSetBuffering,
                                            stderr, stdout)


args :: Parser Args
args = Args
       <$> optional (strOption $ long "revision" <> help "revision to use when fetching from VCS")
       <*> optional (strOption $ short 'o' <> help "output file for generated nix expression" <> metavar "PATH")
       <*> strOption (long "stack-yaml" <> help "Override project stack.yaml file" <> showDefault <> value "stack.yaml")
       <*> option auto (short 'j' <> help "number of threads for subprocesses" <> showDefault <> value 4 <> metavar "INT")
       <*> switch (long "test" <> help "enable tests")
       <*> switch (long "bench" <> help "enable benchmarks")
       <*> switch (long "haddock" <> help "enable documentation generation")
       <*> optional (option utcTimeReader (long "hackage-snapshot" <> help "hackage snapshot time, ISO format"))
       <*> option (maybeReader parsePlatform) (long "platform" <> help "target platform to use when invoking stack or cabal2nix" <> value buildPlatform <> showDefaultWith display)
       <*> strArgument (metavar "URI")
       <*> flag True False (long "no-indent" <> help "disable indentation and place one item per line")
       <*> switch (long "verbose" <> help "verbose output")
       <*> optional (strOption $ long "cabal2nix-args" <> help "extra arguments for cabal2nix")
       <*> flag True False (long "no-ensure-executables" <> help "do not ensure required executables are installed")
  where
    -- | A parser for the date. Hackage updates happen maybe once or twice a month.
    -- Example: parseTime defaultTimeLocale "%FT%T%QZ" "2017-11-20T12:18:35Z" :: Maybe UTCTime
    utcTimeReader :: ReadM UTCTime
    utcTimeReader = eitherReader $ \arg ->
        case parseTimeM True defaultTimeLocale "%FT%T%QZ" arg of
            Nothing      -> Left $ "Cannot parse date, ISO format used ('2017-11-20T12:18:35Z'): " ++ arg
            Just utcTime -> Right utcTime

    -- | A String parser for Distribution.System.Platform
    -- | Copied from cabal2nix/src/Cabal2nix.hs
    parsePlatform :: String -> Maybe Platform
    parsePlatform = parsePlatformParts . splitOn "-"

    parsePlatformParts :: [String] -> Maybe Platform
    parsePlatformParts = \case
      [arch, os] ->
        Just $ Platform (parseArch arch) (parseOS os)
      (arch : _ : osParts) ->
        Just $ Platform (parseArch arch) $ parseOS $ intercalate "-" osParts
      _ -> Nothing

    parseArch :: String -> Arch
    parseArch = classifyArch Permissive . ghcConvertArch

    parseOS :: String -> OS
    parseOS = classifyOS Permissive . ghcConvertOS
    ghcConvertArch :: String -> String
    ghcConvertArch arch = case arch of
      "i486"  -> "i386"
      "i586"  -> "i386"
      "i686"  -> "i386"
      "amd64" -> "x86_64"
      _ -> fromMaybe arch $ listToMaybe
        [prefix | prefix <- archPrefixes, prefix `isPrefixOf` arch]
      where archPrefixes =
              [ "aarch64", "alpha", "arm", "hppa1_1", "hppa", "m68k", "mipseb"
              , "mipsel", "mips", "powerpc64le", "powerpc64", "powerpc", "s390x"
              , "sparc64", "sparc"
              ]

    -- | Replicate the normalization performed by GHC_CONVERT_OS in GHC's aclocal.m4
    -- since the output of that is what Cabal parses.
    ghcConvertOS :: String -> String
    ghcConvertOS os = case os of
      "watchos"       -> "ios"
      "tvos"          -> "ios"
      "linux-android" -> "linux-android"
      "linux-androideabi" -> "linux-androideabi"
      _ | "linux-" `isPrefixOf` os -> "linux"
      _ -> fromMaybe os $ listToMaybe
        [prefix | prefix <- osPrefixes, prefix `isPrefixOf` os]
      where osPrefixes =
              [ "gnu", "openbsd", "aix", "darwin", "solaris2", "freebsd", "nto-qnx"]

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering
  hSetBuffering stderr LineBuffering
  stack2nix =<< execParser opts
  where
    opts = info
      (helper
       <*> infoOption ("stack2nix " ++ showVersion version) (long "version" <> help "Show version number")
       <*> args) $
      fullDesc
      <> progDesc "Generate a nix expression for a Haskell package using stack"

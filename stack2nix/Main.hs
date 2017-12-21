module Main ( main ) where

import           Data.Semigroup      ((<>))
import           Data.Time           (UTCTime, parseTimeM, defaultTimeLocale)
import           Distribution.Text   (display)
import           Options.Applicative
import           Stack2nix
import           System.IO           (BufferMode (..), hSetBuffering, stderr,
                                      stdout)

args :: Parser Args
args = Args
       <$> optional (strOption $ long "revision" <> help "revision to use when fetching from VCS")
       <*> optional (strOption $ short 'o' <> help "output file for generated nix expression" <> metavar "PATH")
       <*> option auto (short 'j' <> help "number of threads for subprocesses" <> showDefault <> value 4 <> metavar "INT")
       <*> switch (long "test" <> help "enable tests")
       <*> switch (long "haddock" <> help "enable documentation generation")
       <*> optional (option utcTimeReader (long "hackage-snapshot" <> help "hackage snapshot time, ISO format"))
       <*> strArgument (metavar "URI")
       <*> switch (long "verbose" <> help "verbose output")
  where
    -- | A parser for the date. Hackage updates happen maybe once or twice a month.
    -- Example: parseTime defaultTimeLocale "%FT%T%QZ" "2017-11-20T12:18:35Z" :: Maybe UTCTime
    utcTimeReader :: ReadM UTCTime
    utcTimeReader = eitherReader $ \arg ->
        case parseTimeM True defaultTimeLocale "%FT%T%QZ" arg of
            Nothing      -> Left $ "Cannot parse date, ISO format used ('2017-11-20T12:18:35Z'): " ++ arg
            Just utcTime -> Right utcTime

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering
  hSetBuffering stderr LineBuffering
  stack2nix =<< execParser opts
  where
    opts = info
      (helper
       <*> infoOption ("stack2nix " ++ display version) (long "version" <> help "Show version number")
       <*> args) $
      fullDesc
      <> progDesc "Generate a nix expression for a Haskell package using stack"

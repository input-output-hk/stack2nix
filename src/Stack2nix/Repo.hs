module Stack2nix.Repo where

import qualified Data.ByteString as BS
import           System.FilePath ((</>))

-- TODO: Support URIs from version control systems.
readRepoFile :: String -> FilePath -> IO BS.ByteString
readRepoFile uri fname = BS.readFile $ uri </> fname

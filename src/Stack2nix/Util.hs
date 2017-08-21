module Stack2nix.Util
  ( mapPool
  ) where

import           Control.Concurrent.Async
import           Control.Concurrent.MSem
import qualified Data.Traversable         as T

-- Credit: https://stackoverflow.com/a/18898822/204305
mapPool :: T.Traversable t => Int -> (a -> IO b) -> t a -> IO (t b)
mapPool max' f xs = do
  sem <- new max'
  mapConcurrently (with sem . f) xs

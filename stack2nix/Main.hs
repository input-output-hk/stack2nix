module Main where

import Stack2nix
import System.Environment

main :: IO ()
main = getArgs >>= (\[fname] -> stack2nix fname)

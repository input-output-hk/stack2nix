{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

import           Stack2nix

import           Data.ByteString   (ByteString)
import           Test.Hspec
import           Text.RawString.QQ

main :: IO ()
main = hspec $
  describe "Stack2nix.parseStackYaml" $
    it "can parse example" $ do
      let yaml = [r|
resolver: lts-8.9

packages:
- '.'
- dep1
- dep2
- location:
    git: https://github.com/jmitchell/haskell-dummy-project1
    commit: 7e7d91d86ba0f86633ab37279c013879ade09e32
  extra-dep: true

extra-deps: []

flags: {}

extra-package-dbs: []
|]
      let config = Config { resolver = "lts-8.9"
                , packages = [ LocalPkg "."
                             , LocalPkg "dep1"
                             , LocalPkg "dep2"
                             , RemotePkg RemotePkgConf {
                                             gitUrl = "https://github.com/jmitchell/haskell-dummy-project1"
                                           , commit = "7e7d91d86ba0f86633ab37279c013879ade09e32"
                                           , extraDep = True
                                           }]
                , extraDeps = []
                }
      parseStackYaml yaml `shouldBe` Just config

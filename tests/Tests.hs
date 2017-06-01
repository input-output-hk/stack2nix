{-# LANGUAGE OverloadedStrings #-}

import           Test.Tasty
import           Test.Tasty.Golden
import           Test.Tasty.HUnit
import           Test.Tasty.Program

import qualified Data.ByteString       as BS
import qualified Data.ByteString.Char8 as BSC
import           System.Directory      (createDirectoryIfMissing)
import           System.Environment    (setEnv)
import           System.FilePath       (takeDirectory, takeFileName, (<.>),
                                        (</>))
import           System.Process

import           Stack2nix

nixPath = "nixpkgs=https://github.com/NixOS/nixpkgs/archive/21a8239452adae3a4717772f4e490575586b2755.tar.gz"


main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [unitTests, programTests, goldenTests]

unitTests :: TestTree
unitTests = testGroup "Unit tests"
  [ testCase "Parses stack.yaml file" $
      parseStackYaml stackYaml @?= Just parsedConfig
  ]
  where
    stackYaml :: BS.ByteString
    stackYaml = BSC.unlines $
      [ "resolver: lts-8.9"
      , ""
      , "packages:"
      , "- '.'"
      , "- dep1"
      , "- dep2"
      , "- location:"
      , "    git: https://github.com/jmitchell/haskell-dummy-project1"
      , "    commit: 7e7d91d86ba0f86633ab37279c013879ade09e32"
      , "  extra-dep: true"
      , ""
      , "extra-deps: []"
      , ""
      , "flags: {}"
      , ""
      , "extra-package-dbs: []"
      ]

    parsedConfig =
      StackConfig { resolver = "lts-8.9"
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

programTests :: TestTree
programTests = testGroup "executable exit code tests"
  [ testProgram "supports --help" "stack2nix" ["--help"] Nothing
  ]

goldenTests :: TestTree
goldenTests = testGroup "executable output tests"
  [ nixFile "https://github.com/jmitchell/haskell-multi-package-demo1.git" "e3d9bd6d6066dab5222ce53fb7d234f28eafa2d5" "haskell-multi-proj-demo1" "default.nix"
  -- , nixFile "https://github.com/input-output-hk/cardano-sl.git" "be7cb65f71e7bd5b34778652009469c4513ecb79" "cardano-sl" "default.nix"
  ]
  where
    shouldVerifyBuild = False

    nixFile proj rev targetAttr nixFname =
      let
        nickname = takeFileName proj
        description = "generates usable " ++ nixFname ++ " for " ++ nickname
        goldFile = "./tests/gold" </> nickname </> nixFname <.> "golden"
        -- TODO: replace /tmp with portable solution
        outDir = "/tmp" </> nickname
        actualFile = outDir </> nixFname
        task = do
          setEnv "NIX_PATH" nixPath
          createDirectoryIfMissing True $ takeDirectory goldFile
          readCreateProcess (proc "stack2nix" ["--outdir", outDir, "--revision", rev, proj]) "" >> return ()
          if shouldVerifyBuild
            then readCreateProcess (proc "nix-build" ["-A", targetAttr]){ cwd = Just outDir } "" >> return ()
            else return ()
      in
        goldenVsFile description goldFile actualFile task

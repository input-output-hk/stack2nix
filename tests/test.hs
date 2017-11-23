import           Test.Tasty
import           Test.Tasty.HUnit

import           Data.Version     (makeVersion)
import           Stack2nix.Util

main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [unitTests]

unitTests = testGroup "Unit tests" [versionExtraction]

versionExtraction = testGroup "Version extraction"
  [ testCase "cabal --version" $
      extractVersion "cabal-install version 2.0.0.0" @?= Just (makeVersion [2, 0, 0, 0])

  -- see issue 67
  , testCase "git --version" $
      extractVersion "git version 2.11.0 (Apple Git-81)" @?= Just (makeVersion [2, 11, 0])

  , testCase "cabal2nix --version" $
      extractVersion "cabal2nix 2.7" @?= Just (makeVersion [2, 7])
  ]

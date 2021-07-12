{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE RankNTypes          #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications    #-}

module Stack2nix.Render
   (render) where

import           Control.Lens
import           Control.Monad                           (when)
import qualified Data.ByteString                         as BS
import           Data.Either                             (lefts, rights)
import           Data.List                               (isPrefixOf,
                                                          sort)
import           Data.Set                                (Set)
import qualified Data.Set                                as Set
import qualified Data.Text                               as Text
import           Data.Text.Encoding                      (encodeUtf8)
import           Data.Version                            (showVersion)
import           Distribution.Nixpkgs.Haskell.BuildInfo  (haskell, pkgconfig,
                                                          system, tool)
import           Distribution.Nixpkgs.Haskell.Derivation (Derivation,
                                                          benchmarkDepends,
                                                          dependencies, doCheck,
                                                          pkgid, runHaddock,
                                                          testDepends)
import           Distribution.Types.PackageId            (PackageIdentifier (..),
                                                          pkgName)
import           Distribution.Types.PackageName          (unPackageName)
import           Language.Nix                            (path)
import           Language.Nix.Binding                    (Binding, reference)
import           Paths_stack2nix                         (version)
import           Stack2nix.Types                         (Args (..))
import           Stack2nix.PP                            (ppIndented, ppSingletons)
import           System.IO                               (hPutStrLn, stderr)
import qualified Text.PrettyPrint                        as PP
import           Text.PrettyPrint.HughesPJClass          (Doc, fcat, nest,
                                                          pPrint, prettyShow, punctuate,
                                                          semi, space, text)

render :: [Either Doc Derivation] -> Args -> [String] -> String -> Set String -> IO ()
render results args locals ghcnixversion basePackages = do
   let docs = lefts results
   when (length docs > 0) $ do
     hPutStrLn stderr $ show docs
     error "Error(s) happened during cabal2nix generation ^^"
   let drvs = rights results

   -- See what base packages are missing in the derivations list and null them
   let missing = sort $ Set.toList $ Set.difference basePackages $ Set.fromList (map drvToName drvs)
   let renderedMissing = map (\b -> nest 6 (text (b <> " = null;"))) missing
   let pp = if argIndent args then ppIndented else ppSingletons

   let out = defaultNix pp ghcnixversion $ renderedMissing ++ map (renderOne args locals) drvs

   case argOutFile args of
     Just fname -> BS.writeFile fname (encodeUtf8 $ Text.pack out)
     Nothing    -> putStrLn out

renderOne :: Args -> [String] -> Derivation -> Doc
renderOne args locals drv' = nest 6 $ PP.hang
  (PP.doubleQuotes (text pid) <> " = callPackage")
  2
  ("(" <> pPrint drv <> ") {" <> text (show pkgs) <> "};")
 where
  pid  = drvToName drv
  deps = view dependencies drv
  nixPkgs :: [Binding]
  nixPkgs  = Set.toList $ Set.union (view pkgconfig deps) (view system deps)
  -- filter out libX stuff to prevent breakage in generated set
  nonXpkgs = filter
    (\e -> not
      (                      "libX"
      `Data.List.isPrefixOf` (prettyShow (((view (reference . path) e) !! 1)))
      )
    )
    nixPkgs
  pkgs = fcat $ punctuate space [ pPrint b <> semi | b <- nonXpkgs ]
  drv =
    filterDepends args isLocal drv'
      &  doCheck
      .~ (argTest args && isLocal)
      &  runHaddock
      .~ (argHaddock args && isLocal)
  isLocal = elem pid locals

filterDepends :: Args -> Bool -> Derivation -> Derivation
filterDepends args isLocal drv = drv & foldr
  (.)
  id
  (do
    (depend, predicate) <-
      [(Lens testDepends, argTest args), (Lens benchmarkDepends, argBench args)]
    binding <- [Lens haskell, Lens pkgconfig, Lens system, Lens tool]
    pure
      $  runLens depend
      .  runLens binding
      .~ (if predicate && isLocal
           then view (runLens depend . runLens binding) drv
           else Set.empty
         )
  )

drvToName :: Derivation -> String
drvToName drv = unPackageName $ pkgName $ view pkgid drv

defaultNix :: (Doc -> String) -> String -> [Doc] -> String
defaultNix pp ghcnixversion drvs = unlines $
 [ "# Generated using stack2nix " <> showVersion version <> "."
 , ""
 , "{ pkgs ? (import <nixpkgs> {})"
 , ", compiler ? pkgs.haskell.packages.ghc" ++ ghcnixversion
 , "}:"
 , ""
 , "with pkgs.haskell.lib;"
 , ""
 , "let"
 , "  stackPackages = { pkgs, lib, callPackage, ... }:"
 , "    self: {"
 ] ++ (map pp drvs) ++
 [ "    };"
 , "in compiler.override {"
 , "  initialPackages = stackPackages;"
 , "  configurationCommon = { ... }: self: super: {};"
 , "  compilerConfig = self: super: {};"
 , "}"
 ]

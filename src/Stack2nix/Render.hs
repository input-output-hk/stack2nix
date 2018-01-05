{-# LANGUAGE OverloadedStrings #-}
module Stack2nix.Render
   (render) where

import qualified Data.Set as Set
import           Control.Monad                           (when)
import           Data.Either                             (rights, lefts)
import           Data.List                               (sort)
import           Data.Monoid                             ((<>))
import           System.IO                               (hPutStrLn, stderr)
import           Distribution.Text                       (display)
import           Distribution.Types.PackageId            ( PackageIdentifier(..))
import           Distribution.Types.PackageName          (unPackageName)
import           Lens.Micro.Extras                       (view)
import           Paths_stack2nix                         (version)
import           Distribution.Nixpkgs.Haskell.Derivation (Derivation, pkgid, extraFunctionArgs, dependencies)
import           Distribution.Nixpkgs.Haskell.BuildInfo  (system)
import           Text.PrettyPrint.HughesPJClass          (semi, nest, pPrint, fcat, punctuate, space, text, Doc, prettyShow, pPrint)
import qualified Text.PrettyPrint                        as PP
import           Language.Nix.PrettyPrinting             (disp)

render :: [Either Doc Derivation] -> IO ()
render results = do
   let docs = lefts results
   when (length docs > 0) $ do
     hPutStrLn stderr $ show docs
     error "Error(s) happened during cabal2nix generation ^^"
   let drvs = rights results
   -- doCheck &&~ optDoCheck
   putStrLn $ (defaultNix $ map renderOne drvs)

renderOne :: Derivation -> Doc
renderOne drv =
   nest 6 $ PP.hang (PP.doubleQuotes (text pid) <> " = callPackage") 2 ("(" <> pPrint drv <> ") {" <> text (show args) <> "};")
     where pid = unPackageName $ pkgName $ view pkgid drv
           args = fcat $ punctuate space [ disp b <> semi | b <- Set.toList $ view system (view dependencies drv) ]

defaultNix :: [Doc] -> String
defaultNix drvs = unlines $
 [ "# Generated using stack2nix " <> display version <> "."
 , "#"
 , "# Only works with sufficiently recent nixpkgs, e.g. \"NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/21a8239452adae3a4717772f4e490575586b2755.tar.gz\"."
 , ""
 , "{ pkgs ? (import <nixpkgs> {})"
 , ", compiler ? pkgs.haskell.packages.ghc802"
 , "}:"
 , ""
 , "with pkgs.haskell.lib;"
 , ""
 , "let"
 , "  stackPackages = { pkgs, stdenv, callPackage }:"
 , "    self: {"
 ] ++ (map PP.render drvs) ++
 [ "    };"
 , "in compiler.override {"
 , "  initialPackages = stackPackages;"
 , "  configurationCommon = { ... }: self: super: {};"
 , "}"
 ]

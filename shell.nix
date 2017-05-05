{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc802" }:

with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit nixpkgs; });
(import ./default.nix { inherit nixpkgs compiler; }).env

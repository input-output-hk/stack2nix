{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc802" }:
let
  h = nixpkgs.haskell.packages.${compiler}.override {
    overrides = self: super: {
      cabal2nix = super.callPackage ./cabal2nix.nix { };
    };
  };
in
h.callPackage ./stack2nix.nix { }

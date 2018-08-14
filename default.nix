{ pkgs ? import (import ./fetch-nixpkgs.nix) {} }:

with pkgs.haskell.lib;

((import ./stack2nix.nix { inherit pkgs; }).override {
  overrides = self: super: {
    # TODO: separate out output
    stack2nix = justStaticExecutables super.stack2nix;

    # https://github.com/commercialhaskell/lts-haskell/issues/149
    stack = doJailbreak super.stack;

    # needed until we upgrade to 18.09
    yaml = disableCabalFlag super.yaml "system-libyaml";

    # https://github.com/NixOS/cabal2nix/issues/146
    hinotify = if pkgs.stdenv.isDarwin then self.hfsevents else super.hinotify;
  };
}).stack2nix

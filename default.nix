{ pkgs ? import <nixpkgs> {}}:

with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit pkgs; } ); 

((import ./stack2nix.nix { inherit pkgs; }).override {
  overrides = self: super: {
    stack2nix = justStaticExecutables super.stack2nix;

    # https://github.com/NixOS/cabal2nix/issues/146
    hinotify = if pkgs.stdenv.isDarwin then self.hfsevents else super.hinotify;
    # Darwin fixes upstreamed in nixpkgs commit 71bebd52547f4486816fd320bb3dc6314f139e67
    hfsevents = self.callPackage ./hfsevents.nix { inherit (pkgs.darwin.apple_sdk.frameworks) Cocoa CoreServices; };
    fsnotify = if pkgs.stdenv.isDarwin
      then addBuildDepend (dontCheck super.fsnotify) pkgs.darwin.apple_sdk.frameworks.Cocoa
      else dontCheck super.fsnotify;
  };
}).stack2nix

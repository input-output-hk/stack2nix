{ pkgs ? import <nixpkgs> {}}:

with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit pkgs; } ); 

justStaticExecutables (import ./stack2nix.nix { inherit pkgs; }).stack2nix

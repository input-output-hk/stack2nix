{ pkgs ? import (import ./fetch-nixpkgs.nix) {} }:

pkgs.haskellPackages.shellFor {
  packages = _: [
    (import ./default.nix {})
  ];
  
  withHoogle = true;
}

#!/usr/bin/env nix-shell
#! nix-shell -p cabal2nix stack nix-prefetch-git git cabal-install ghc -i bash
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/f4312a30241fd88c3b4bb38ba62999865073ad94.tar.gz

export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/f4312a30241fd88c3b4bb38ba62999865073ad94.tar.gz


set -xe

fail_stack2nix_check() {
  echo "ERROR: you need to run 'stack2nix . > stack2nix.nix' and commit the changes" >&2
  exit 1
}

# Get relative path to script directory
scriptDir=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")

~/.local/bin/stack2nix . > stack2nix.nix

git diff --text --exit-code || fail_stack2nix_check


#!/usr/bin/env bash

set -ex

# set up local environment
PATH="$HOME/.local/bin:$HOME/.nix-profile/bin:$PATH"

# install dependencies from nix
time nix-env -j2 -i cabal-install ghc git nix-prefetch-git stack

# install cabal2nix 2.2.1 and stack2nix
time nix-env -j2 -f . -i cabal2nix stack2nix

# update cabal package index
time cabal update

# smoke tests
NIX_PATH="nixpkgs=https://github.com/NixOS/nixpkgs/archive/21a8239452adae3a4717772f4e490575586b2755.tar.gz"

time stack2nix -o /tmp/haskell-dummy-project1.nix \
     --revision 7e7d91d86ba0f86633ab37279c013879ade09e32 \
     https://github.com/jmitchell/haskell-dummy-project1.git
time nix-build -A haskell-dummy-package1 /tmp/haskell-dummy-project1.nix

time stack2nix -o /tmp/haskell-multi-package-demo1.nix \
     --revision e3d9bd6d6066dab5222ce53fb7d234f28eafa2d5 \
     https://github.com/jmitchell/haskell-multi-package-demo1.git
time nix-build -A haskell-multi-proj-demo1 /tmp/haskell-multi-package-demo1.nix

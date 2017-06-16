#!/usr/bin/env bash

set -ex

# set up local environment
PATH="$HOME/.local/bin:$HOME/.nix-profile/bin:$PATH"
NIX_PATH="nixpkgs=https://github.com/NixOS/nixpkgs/archive/21a8239452adae3a4717772f4e490575586b2755.tar.gz"

# install dependencies from nix
nix-env -i stack nix-prefetch-git git cabal-install ghc

# install cabal2nix 2.2.1
stack --nix --system-ghc install cabal2nix-2.2.1

# build and install
stack --nix --system-ghc setup
stack --nix --system-ghc install

# smoke tests
stack2nix -o /tmp/haskell-dummy-project1.nix \
	  --revision 7e7d91d86ba0f86633ab37279c013879ade09e32 \
	  https://github.com/jmitchell/haskell-dummy-project1.git
nix-build -A haskell-dummy-package1 /tmp/haskell-dummy-project1.nix

stack2nix -o /tmp/haskell-multi-package-demo1.nix \
	  --revision e3d9bd6d6066dab5222ce53fb7d234f28eafa2d5 \
	  https://github.com/jmitchell/haskell-multi-package-demo1.git
nix-build -A haskell-multi-proj-demo1 /tmp/haskell-multi-package-demo1.nix

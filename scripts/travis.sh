#!/usr/bin/env bash

set -ex

# install dependencies from nix
nix-env -i stack nix-prefetch-git git cabal-install

# install cabal2nix 2.2.1
PATH="$HOME/.local/bin:$PATH"
stack install --install-ghc cabal2nix-2.2.1
which cabal2nix
cabal2nix --version

# run stack2nix tests
cabal update
stack setup
stack test

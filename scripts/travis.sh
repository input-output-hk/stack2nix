#!/usr/bin/env bash

set -ex

# install dependencies from nix
nix-env -i stack nix-prefetch-git git

# install cabal2nix 2.2.1
PATH="$HOME/.local/bin:$PATH"
stack install cabal2nix-2.2.1
which cabal2nix
cabal2nix --version

# run stack2nix tests
stack setup
stack test

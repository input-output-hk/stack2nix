#!/usr/bin/env bash

readlink=$(nix-instantiate --eval -E "/. + (import <nix/config.nix>).coreutils")/readlink
scriptDir=$(dirname -- "$($readlink -f -- "${BASH_SOURCE[0]}")")
NIXPKGS=$(nix-build "${scriptDir}/../fetch-nixpkgs.nix" --no-out-link)
export NIX_PATH="nixpkgs=$NIXPKGS"


set -ex

STACK=$(nix-build -A stack $NIXPKGS)/bin
NIX_PREFETCH=$(nix-build -A nix-prefetch-git $NIXPKGS)/bin
GIT=$(nix-build -A git $NIXPKGS)/bin
CABAL_INSTALL=$(nix-build -A cabal-install $NIXPKGS)/bin
# set up local environment
PATH="$HOME/.local/bin:$STACK:$NIX_PREFETCH:$GIT:$CABAL_INSTALL:$PATH"

# build and install
stack --nix --system-ghc install --fast --ghc-options="+RTS -A128m -n2m -RTS"
stack --nix --system-ghc test --ghc-options="+RTS -A128m -n2m -RTS"

# SMOKE TESTS

# basic remote
stack2nix -o /tmp/haskell-dummy-project1.nix \
	  --revision 7e7d91d86ba0f86633ab37279c013879ade09e32 \
	  https://github.com/jmitchell/haskell-dummy-project1.git
nix-build -A haskell-dummy-package1 /tmp/haskell-dummy-project1.nix

# multi remote
stack2nix -o /tmp/haskell-multi-package-demo1.nix \
	  --revision e3d9bd6d6066dab5222ce53fb7d234f28eafa2d5 \
	  https://github.com/jmitchell/haskell-multi-package-demo1.git
nix-build -A haskell-multi-proj-demo1 /tmp/haskell-multi-package-demo1.nix

# multi local and ../ relpath
TMP_REPO="$(mktemp -d)"
git clone https://github.com/jmitchell/haskell-multi-package-demo1.git "$TMP_REPO"
cd "$TMP_REPO"
git checkout e3d9bd6d6066dab5222ce53fb7d234f28eafa2d5
cd src
stack2nix -o hmpd.nix ../
nix-build -A haskell-multi-proj-demo1 hmpd.nix
test $(grep "src = ../dep1" hmpd.nix | wc -l) -eq 1

#!/usr/bin/env nix-shell
#! nix-shell -p cabal2nix stack nix-prefetch-git git cabal-install ghc -i bash
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/a905b7cd0c2dc0714195a50bf176cd8e4593502d.tar.gz

readlink=$(nix-instantiate --eval -E "/. + (import <nix/config.nix>).coreutils")/readlink
scriptDir=$(dirname -- "$($readlink -f -- "${BASH_SOURCE[0]}")")
export NIX_PATH="nixpkgs=$(nix-build "${scriptDir}/../fetch-nixpkgs.nix" --no-out-link)"


set -ex

# set up local environment
PATH="$HOME/.local/bin:$PATH"

# install cabal2nix 2.2.1
cabal2nix --version

# build and install
stack --nix --system-ghc setup
stack --nix --system-ghc install --fast
stack --nix --system-ghc test

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

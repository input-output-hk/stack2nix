#!/usr/bin/env nix-shell
#! nix-shell -p cabal2nix stack nix-prefetch-git git cabal-install ghc -i bash
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/a905b7cd0c2dc0714195a50bf176cd8e4593502d.tar.gz

export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/a905b7cd0c2dc0714195a50bf176cd8e4593502d.tar.gz

set -ex

# set up local environment
PATH="$HOME/.local/bin:$PATH"

# install cabal2nix 2.2.1
cabal2nix --version

# build and install
stack --nix --system-ghc setup
stack --nix --system-ghc install --fast

# smoke tests
stack2nix -o /tmp/haskell-dummy-project1.nix \
	  --revision 7e7d91d86ba0f86633ab37279c013879ade09e32 \
	  https://github.com/jmitchell/haskell-dummy-project1.git
nix-build -A haskell-dummy-package1 /tmp/haskell-dummy-project1.nix

stack2nix -o /tmp/haskell-multi-package-demo1.nix \
	  --revision e3d9bd6d6066dab5222ce53fb7d234f28eafa2d5 \
	  https://github.com/jmitchell/haskell-multi-package-demo1.git
nix-build -A haskell-multi-proj-demo1 /tmp/haskell-multi-package-demo1.nix

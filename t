#!/usr/bin/env bash

set -e

RED="\033[1;31m"
GREEN="\033[1;32m"
NC="\033[0m"

build_repo() {
    local description=$1
    local repo=$2
    local build_target=$3
    local job="$description: $repo; $build_target"

    rm *.nix
    echo "Running stack2nix on $repo"
    stack exec stack2nix -- $repo || (echo -e "${RED}FAIL: stack2nix: $description${NC}"; exit 1)

    echo "Running nix-build on $build_target"
    nix-build -A $build_target --show-trace || (echo -e "${RED}FAIL: nix-build: $description${NC}"; exit 1)

    echo -e "${GREEN}PASS: $description${NC}"
    echo ""
}

# TODO: Assumptions about stack configuration may affect your
# system. Currently the focus is getting the project to work on Travis
# CI.
which stack || export PATH="$HOME/.local/bin:$PATH"
stack config set system-ghc --global true
stack build

build_repo "Remote simple" https://github.com/jmitchell/haskell-multi-package-demo1 haskell-multi-proj-demo1
build_repo "Local simple" ../haskell-multi-package-demo1 haskell-multi-proj-demo1
build_repo "Remote Cardano-SL" https://github.com/input-output-hk/cardano-sl cardano-sl
build_repo "Remote Cardano-SL-Explorer" https://github.com/input-output-hk/cardano-sl-explorer cardano-sl-explorer

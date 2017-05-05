#!/usr/bin/env bash

set -e

RED="\033[1;31m"
GREEN="\033[1;32m"
NC="\033[0m"

build_self() {
    local bin="$(mktemp -d)/bin"

    echo "Building stack2nix..."
    cabal sandbox init
    cabal configure
    cabal build

    echo "Installing stack2nix to $bin"
    mkdir -p "$bin"
    cabal install --bindir="$bin"
    export PATH="$bin:$PATH"
    echo "stack2nix path: $(which stack2nix)"
}

build_repo() {
    local description=$1
    local repo=$2
    local build_target=$3
    local work_dir="$(mktemp -d)"

    echo "Running stack2nix on $repo"
    pushd "$work_dir"
    stack2nix $repo || (echo -e "${RED}FAIL: stack2nix: $description${NC}"; popd; exit 1)

    echo "Running nix-build on $build_target"
    nix-build -A $build_target --show-trace || (echo -e "${RED}FAIL: nix-build: $description${NC}"; popd; exit 1)

    echo -e "${GREEN}PASS: $description${NC}"
    echo ""

    popd
}

run_tests() {
    echo "Running tests..."
    build_repo "Remote simple" https://github.com/jmitchell/haskell-multi-package-demo1 haskell-multi-proj-demo1

    local clone_dir="$(mktemp -d)"
    git clone https://github.com/jmitchell/haskell-multi-package-demo1 "$clone_dir"
    build_repo "Local simple" "$clone_dir" haskell-multi-proj-demo1

    build_repo "Remote Cardano-SL" https://github.com/input-output-hk/cardano-sl cardano-sl
    build_repo "Remote Cardano-SL-Explorer" https://github.com/input-output-hk/cardano-sl-explorer cardano-sl-explorer
}

build_self && run_tests

#!/usr/bin/env bash

set -e

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
NC="\033[0m"

build_self() {
    local bin="$(mktemp -d)/bin"

    echo -e "${YELLOW}Building stack2nix...${NC}"
    cabal update
    cabal sandbox init
    cabal configure
    cabal build

    echo -e "${YELLOW}Installing stack2nix to $bin${NC}"
    mkdir -p "$bin"
    cabal install --bindir="$bin"
    export PATH="$bin:$PATH"
    echo "stack2nix path: $(which stack2nix)"
}

build_repo() {
    local description=$1
    local repo=$2
    local build_target=$3
    local rev="${4:-master}"
    local work_dir="$(mktemp -d)"

    echo -e "${YELLOW}Running stack2nix on $repo${NC}"
    pushd "$work_dir"
    stack2nix --revision "$rev" $repo || (echo -e "${RED}FAIL: stack2nix: $description${NC}"; popd; exit 1)

    echo -e "${YELLOW}Running nix-build on $build_target${NC}"
    nix-build -A $build_target --show-trace || (echo -e "${RED}FAIL: nix-build: $description${NC}"; popd; exit 1)

    echo -e "${GREEN}PASS: $description${NC}"
    echo ""

    popd
}

run_tests() {
    echo -e "${YELLOW}Running tests...${NC}"

    build_repo "Remote simple" https://github.com/jmitchell/haskell-multi-package-demo1 haskell-multi-proj-demo1

    local clone_dir="$(mktemp -d)"
    git clone https://github.com/jmitchell/haskell-multi-package-demo1 "$clone_dir"
    build_repo "Local simple" "$clone_dir" haskell-multi-proj-demo1

    # Haskell package whose name matches one of its external dependencies
    build_repo "Remote rocksdb-haskell" https://github.com/serokell/rocksdb-haskell rocksdb

    # An extra-dep of cardano-sl
    build_repo "Remote cardano-crypto" https://github.com/input-output-hk/cardano-crypto cardano-crypto
}

build_self && run_tests

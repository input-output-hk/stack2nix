#!/usr/bin/env bash

readlink=$(nix-instantiate --eval -E "/. + (import <nix/config.nix>).coreutils")/readlink
scriptDir=$(dirname -- "$($readlink -f -- "${BASH_SOURCE[0]}")")
source $scriptDir/init-env.sh

set -xe

fail_stack2nix_check() {
  echo "ERROR: you need to run 'stack2nix . > stack2nix.nix' and commit the changes" >&2
  exit 1
}

~/.local/bin/stack2nix . > $scriptDir/../stack2nix.nix

git diff --text --exit-code || fail_stack2nix_check


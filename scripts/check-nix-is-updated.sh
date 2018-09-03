#!/usr/bin/env bash

readlink=$(nix-instantiate --eval -E "/. + (import <nix/config.nix>).coreutils")/readlink
scriptDir=$(dirname -- "$($readlink -f -- "${BASH_SOURCE[0]}")")
source $scriptDir/init-env.sh

set -xe

fail_stack2nix_check() {
  echo "ERROR: you need to run './scripts/check-nix-is-updated.sh' and commit the changes" >&2
  exit 1
}

\time ~/.local/bin/stack2nix --hackage-snapshot 2018-09-03T15:17:10Z . > $scriptDir/../stack2nix.nix

git diff --text --exit-code || fail_stack2nix_check

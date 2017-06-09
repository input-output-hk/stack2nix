#!/usr/bin/env bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$DIR/.."
vagrant up
vagrant ssh -c "sudo mount -o remount,exec,size=4G,mode=755 /run/user"
vagrant ssh -c "echo export PATH=\"\$PATH:\$HOME/.local/bin\" > \$HOME/.bash_profile"
vagrant ssh -c "curl https://nixos.org/nix/install | sh"
vagrant ssh -c "cd /vagrant && ./scripts/travis.sh"

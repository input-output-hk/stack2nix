# stack2nix

[![Build Status](https://travis-ci.org/input-output-hk/stack2nix.svg)](https://travis-ci.org/input-output-hk/stack2nix)

## About

`stack2nix` automates conversion from [Stack](https://docs.haskellstack.org/en/stable/README/) configuration file to [Nix](http://nixos.org/nix/) expressions.

`stack2nix` high-level workflow:

- invoke `stack list-dependencies` to determine complete fixed version list of packages based on resolver
- apply any additional configuration (local packages, extra dependencies, etc) from `stack.yaml`
- generate complete list of dependencies to Nix expressions, overriding upstream `hackage-packages.nix`

## Installation

Other installation methods will be supported, but for now this is the
recommended way.

1. Install [nix](https://nixos.org/nix/).
2. Clone this repo.
4. Run `stack install` to install.
5. Ensure `cabal2nix` version 2.2.1 is in your PATH.

## Usage

Following examples are based on stack2nix repository.

1. Given https://github.com/input-output-hk/stack2nix.git is cloned in current directory:

```
    $ stack2nix . > default.nix
    $ nix-build -A stack2nix
```

2. Given a git URL:

```
    $ stack2nix --revision 8f087b92f83be078e8cfe86fb243121dca4601ba https://github.com/input-output-hk/stack2nix.git > default.nix
    $ nix-build -A stack2nix
```

## Testing

Run `./scripts/travis.sh` to build and test.

{ mkDerivation, aeson, ansi-wl-pprint, base, bytestring, Cabal
, containers, deepseq, directory, distribution-nixpkgs, doctest
, fetchgit, filepath, hackage-db, language-nix, lens, monad-par
, monad-par-extras, mtl, optparse-applicative, pretty, process, SHA
, split, stdenv, text, time, transformers, utf8-string, yaml
}:
mkDerivation {
  pname = "cabal2nix";
  version = "2.2";
  src = fetchgit {
    url = "https://github.com/NixOS/cabal2nix";
    sha256 = "084x2npqkdfhlrzxk1b8lhxjk90zbj1p6wmsbmrp3j6iahdr5bfk";
    rev = "d2334f4e68a6a7d5a4a2b62dff0e62f81800a0b2";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs filepath hackage-db language-nix
    lens optparse-applicative pretty process SHA split text
    transformers yaml
  ];
  executableHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs filepath hackage-db language-nix
    lens monad-par monad-par-extras mtl optparse-applicative pretty
    process SHA split text time transformers utf8-string yaml
  ];
  testHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs doctest filepath hackage-db
    language-nix lens optparse-applicative pretty process SHA split
    text transformers yaml
  ];
  homepage = "https://github.com/nixos/cabal2nix#readme";
  description = "Convert Cabal files into Nix build instructions";
  license = stdenv.lib.licenses.bsd3;
}

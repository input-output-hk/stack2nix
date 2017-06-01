{ mkDerivation, aeson, ansi-wl-pprint, base, bytestring, Cabal
, containers, deepseq, directory, distribution-nixpkgs, doctest
, fetchgit, filepath, hackage-db, language-nix, lens, monad-par
, monad-par-extras, mtl, optparse-applicative, pretty, process, SHA
, split, stdenv, text, time, transformers, utf8-string, yaml
}:
mkDerivation {
  pname = "cabal2nix";
  version = "2.2.1";
  src = fetchgit {
    url = "https://github.com/NixOS/cabal2nix";
    sha256 = "1ia2iw137sza655b0hf4hghpmjbsg3gz3galpvr5pbbsljp26m6p";
    rev = "b6834fd420e0223d0d57f8f98caeeb6ac088be88";
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
  doHaddock = false;
  doCheck = false;
  homepage = "https://github.com/nixos/cabal2nix#readme";
  description = "Convert Cabal files into Nix build instructions";
  license = stdenv.lib.licenses.bsd3;
}

{ mkDerivation, base, bytestring, Cabal, cabal2nix, cabal-install
, directory, filepath, gitAndTools, Glob, hspec, nix-prefetch-git
, optparse-applicative, process, raw-strings-qq, stdenv
, temporary, text, which, yaml
}:
mkDerivation {
  pname = "stack2nix";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base bytestring directory filepath Glob process temporary text yaml
  ];
  executableHaskellDepends = [ base optparse-applicative ];
  testHaskellDepends = [
    base bytestring Cabal hspec raw-strings-qq
  ];
  testSystemDepends = [
    cabal2nix
    cabal-install
    gitAndTools.gitFull
    nix-prefetch-git
    which
  ];
  description = "Convert stack.yaml files into Nix build instructions.";
  license = stdenv.lib.licenses.bsd3;
}

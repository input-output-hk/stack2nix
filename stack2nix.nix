# Generated using stack2nix 0.1.3.1.
#
# Only works with sufficiently recent nixpkgs, e.g. "NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/21a8239452adae3a4717772f4e490575586b2755.tar.gz".

{ pkgs ? (import <nixpkgs> {})
, compiler ? pkgs.haskell.packages.ghc802
, ghc ? pkgs.haskell.compiler.ghc802
}:

with pkgs.haskell.lib;

let
  stackPackages = { callPackage, pkgs, stdenv }:
self: {
      Cabal = callPackage ({ array, base, binary, bytestring, containers, deepseq, directory, filepath, mkDerivation, pretty, process, stdenv, time, unix }:
      mkDerivation {
          pname = "Cabal";
          version = "2.0.0.2";
          sha256 = "6c99fe6cc71f868308f946fa76a0105c05895b4e1d32ff4a836ac91182a01032";
          revision = "1";
          editedCabalFile = "1k4alrrz7yza66kaya69m0rkcz45mw48afrcv1x54q31cka9xyx1";
          libraryHaskellDepends = [
            array
            base
            binary
            bytestring
            containers
            deepseq
            directory
            filepath
            pretty
            process
            time
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://www.haskell.org/cabal/";
          description = "A framework for packaging Haskell software";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      Glob = callPackage ({ base, containers, directory, dlist, filepath, mkDerivation, stdenv, transformers, transformers-compat }:
      mkDerivation {
          pname = "Glob";
          version = "0.8.0";
          sha256 = "38f011be0e7818ab1e76880882b15217cd7d5be56a3dab631c14d614e2b2e896";
          libraryHaskellDepends = [
            base
            containers
            directory
            dlist
            filepath
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://iki.fi/matti.niemenmaa/glob/";
          description = "Globbing library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      HUnit = callPackage ({ base, call-stack, deepseq, mkDerivation, stdenv }:
      mkDerivation {
          pname = "HUnit";
          version = "1.5.0.0";
          sha256 = "65c51d17ced1c0646d888cd8caf195df67f6fdc1394c34459bcfd1be0f9ddea0";
          libraryHaskellDepends = [
            base
            call-stack
            deepseq
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/hspec/HUnit#readme";
          description = "A unit testing framework for Haskell";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      MonadRandom = callPackage ({ base, fail, mkDerivation, mtl, primitive, random, stdenv, transformers, transformers-compat }:
      mkDerivation {
          pname = "MonadRandom";
          version = "0.5.1";
          sha256 = "9e3f0f92807285302036dc504066ae6d968c8b0b4c25d9360888f31fe1730d87";
          libraryHaskellDepends = [
            base
            fail
            mtl
            primitive
            random
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          description = "Random-number generation monad";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      QuickCheck = callPackage ({ base, containers, mkDerivation, random, stdenv, template-haskell, tf-random, transformers }:
      mkDerivation {
          pname = "QuickCheck";
          version = "2.9.2";
          sha256 = "155c1656f583bc797587846ee1959143d2b1b9c88fbcb9d3f510f58d8fb93685";
          libraryHaskellDepends = [
            base
            containers
            random
            template-haskell
            tf-random
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/nick8325/quickcheck";
          description = "Automatic testing of Haskell programs";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      SafeSemaphore = callPackage ({ base, containers, mkDerivation, stdenv, stm }:
      mkDerivation {
          pname = "SafeSemaphore";
          version = "0.10.1";
          sha256 = "21e5b737a378cae9e1faf85cab015316d4c84d4b37e6d9d202111cef8c4cef66";
          revision = "1";
          editedCabalFile = "1k61gqgfh6n3sj8ni8sfvpcm39nqc2msjfxk2pgmhfabvv48w5hv";
          libraryHaskellDepends = [
            base
            containers
            stm
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/ChrisKuklewicz/SafeSemaphore";
          description = "Much safer replacement for QSemN, QSem, and SampleVar";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      StateVar = callPackage ({ base, mkDerivation, stdenv, stm, transformers }:
      mkDerivation {
          pname = "StateVar";
          version = "1.1.0.4";
          sha256 = "7ad68decb5c9a76f83c95ece5fa13d1b053e4fb1079bd2d3538f6b05014dffb7";
          libraryHaskellDepends = [
            base
            stm
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-opengl/StateVar";
          description = "State variables";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      abstract-deque = callPackage ({ array, base, containers, mkDerivation, random, stdenv, time }:
      mkDerivation {
          pname = "abstract-deque";
          version = "0.3";
          sha256 = "09aa10f38193a8275a7791b92a4f3a7192a304874637e2a35c897dde25d75ca2";
          libraryHaskellDepends = [
            array
            base
            containers
            random
            time
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/rrnewton/haskell-lockfree/wiki";
          description = "Abstract, parameterized interface to mutable Deques";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      abstract-par = callPackage ({ base, deepseq, mkDerivation, stdenv }:
      mkDerivation {
          pname = "abstract-par";
          version = "0.3.3";
          sha256 = "248a8739bd902462cb16755b690b55660e196e58cc7e6ef8157a72c2a3d5d860";
          libraryHaskellDepends = [
            base
            deepseq
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/simonmar/monad-par";
          description = "Type classes generalizing the functionality of the 'monad-par' library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      adjunctions = callPackage ({ array, base, comonad, containers, contravariant, distributive, free, mkDerivation, mtl, profunctors, semigroupoids, semigroups, stdenv, tagged, transformers, transformers-compat, void }:
      mkDerivation {
          pname = "adjunctions";
          version = "4.3";
          sha256 = "b948a14fafe8857f451ae3e474f5264c907b5a2d841d52bf78249ae4749c3ecc";
          revision = "1";
          editedCabalFile = "1079l9szyr7ybi9wcvv1vjsjfrqirkn9z3j7dann8vbk81a4z37q";
          libraryHaskellDepends = [
            array
            base
            comonad
            containers
            contravariant
            distributive
            free
            mtl
            profunctors
            semigroupoids
            semigroups
            tagged
            transformers
            transformers-compat
            void
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/adjunctions/";
          description = "Adjunctions and representable functors";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      aeson = callPackage ({ attoparsec, base, base-compat, bytestring, containers, deepseq, dlist, ghc-prim, hashable, mkDerivation, scientific, stdenv, tagged, template-haskell, text, time, time-locale-compat, unordered-containers, uuid-types, vector }:
      mkDerivation {
          pname = "aeson";
          version = "1.1.2.0";
          sha256 = "37488cfbf6ecf65c4d63164d760c1a0f3bcc3371a35a50e5c4a3c0fd2ffac5ff";
          revision = "1";
          editedCabalFile = "06acsik1qcn5r1z1y3n7iw5h8x0h3hdcjii0bq9nf9ncvc71h1d4";
          libraryHaskellDepends = [
            attoparsec
            base
            base-compat
            bytestring
            containers
            deepseq
            dlist
            ghc-prim
            hashable
            scientific
            tagged
            template-haskell
            text
            time
            time-locale-compat
            unordered-containers
            uuid-types
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/aeson";
          description = "Fast JSON parsing and encoding";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      aeson-compat = callPackage ({ aeson, attoparsec, base, base-compat, bytestring, containers, exceptions, hashable, mkDerivation, nats, scientific, semigroups, stdenv, tagged, text, time, time-locale-compat, unordered-containers, vector }:
      mkDerivation {
          pname = "aeson-compat";
          version = "0.3.6";
          sha256 = "7aa365d9f44f708f25c939489528836aa10b411e0a3e630c8c2888670874d142";
          revision = "6";
          editedCabalFile = "1hvq2pp7k2wqlzd192l7dz1dhld7m3slhv84hnmh4jz8g618xzsc";
          libraryHaskellDepends = [
            aeson
            attoparsec
            base
            base-compat
            bytestring
            containers
            exceptions
            hashable
            nats
            scientific
            semigroups
            tagged
            text
            time
            time-locale-compat
            unordered-containers
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/phadej/aeson-compat#readme";
          description = "Compatibility layer for aeson";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      annotated-wl-pprint = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "annotated-wl-pprint";
          version = "0.7.0";
          sha256 = "0c262d7fe13a9a50216438ec882c13e25f31236b886a5692e3c35b85cd773d18";
          revision = "1";
          editedCabalFile = "138k24qxvl90l7dwdw1b3w36mpw93n0xi0nljblqg88pxg7jcvjx";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/david-christiansen/annotated-wl-pprint";
          description = "The Wadler/Leijen Pretty Printer, with annotation support";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      ansi-terminal = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "ansi-terminal";
          version = "0.6.3.1";
          sha256 = "458f98e0c9217897f0ff07f730cfc3ed380089936fb31942aec31bb336608095";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
          ];
          executableHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/feuerbach/ansi-terminal";
          description = "Simple ANSI terminal support, with Windows compatibility";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      ansi-wl-pprint = callPackage ({ ansi-terminal, base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "ansi-wl-pprint";
          version = "0.6.7.3";
          sha256 = "3789ecaa89721eabef58ddc5711f7fd1ff67e262da1659f3b20d38a9e1f5b708";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            ansi-terminal
            base
          ];
          executableHaskellDepends = [
            ansi-terminal
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/ansi-wl-pprint";
          description = "The Wadler/Leijen Pretty Printer for colored ANSI terminal output";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      asn1-encoding = callPackage ({ asn1-types, base, bytestring, hourglass, mkDerivation, stdenv }:
      mkDerivation {
          pname = "asn1-encoding";
          version = "0.9.5";
          sha256 = "1e863bfd363f6c3760cc80f2c0d422e17845a9f79fe006030db202ecab5aaf29";
          libraryHaskellDepends = [
            asn1-types
            base
            bytestring
            hourglass
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-asn1";
          description = "ASN1 data reader and writer in RAW, BER and DER forms";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      asn1-parse = callPackage ({ asn1-encoding, asn1-types, base, bytestring, mkDerivation, stdenv }:
      mkDerivation {
          pname = "asn1-parse";
          version = "0.9.4";
          sha256 = "c6a328f570c69db73f8d2416f9251e8a03753f90d5d19e76cbe69509a3ceb708";
          libraryHaskellDepends = [
            asn1-encoding
            asn1-types
            base
            bytestring
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/vincenthz/hs-asn1";
          description = "Simple monadic parser for ASN1 stream types";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      asn1-types = callPackage ({ base, bytestring, hourglass, memory, mkDerivation, stdenv }:
      mkDerivation {
          pname = "asn1-types";
          version = "0.3.2";
          sha256 = "0c571fff4a10559c6a630d4851ba3cdf1d558185ce3dcfca1136f9883d647217";
          libraryHaskellDepends = [
            base
            bytestring
            hourglass
            memory
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-asn1-types";
          description = "ASN.1 types";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      async = callPackage ({ base, mkDerivation, stdenv, stm }:
      mkDerivation {
          pname = "async";
          version = "2.1.1.1";
          sha256 = "cd83e471466ea6885b2e8fb60f452db3ac3fdf3ea2d6370aa1e071ebc37544e2";
          libraryHaskellDepends = [
            base
            stm
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/simonmar/async";
          description = "Run IO operations asynchronously and wait for their results";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      attoparsec = callPackage ({ array, base, bytestring, containers, deepseq, mkDerivation, scientific, stdenv, text, transformers }:
      mkDerivation {
          pname = "attoparsec";
          version = "0.13.1.0";
          sha256 = "52dc74d4955e457ce4f76f5c9d6dba05c1d07e2cd2a542d6251c6dbc66ce3f64";
          libraryHaskellDepends = [
            array
            base
            bytestring
            containers
            deepseq
            scientific
            text
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/attoparsec";
          description = "Fast combinator parsing for bytestrings and text";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      attoparsec-iso8601 = callPackage ({ attoparsec, base, base-compat, mkDerivation, stdenv, text, time }:
      mkDerivation {
          pname = "attoparsec-iso8601";
          version = "1.0.0.0";
          sha256 = "aa6c6d87587383e386cb85e7ffcc4a6317aa8dafb8ba9a104ecac365ce2a858a";
          libraryHaskellDepends = [
            attoparsec
            base
            base-compat
            text
            time
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/aeson";
          description = "Parsing of ISO 8601 dates, originally from aeson";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      auto-update = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "auto-update";
          version = "0.1.4";
          sha256 = "5e96c151024e8bcaf4eaa932e16995872b2017f46124b967e155744d9580b425";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/yesodweb/wai";
          description = "Efficiently run periodic, on-demand actions";
          license = stdenv.lib.licenses.mit;
        }) {};
      base-compat = callPackage ({ base, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "base-compat";
          version = "0.9.3";
          sha256 = "7d602b0f0543fadbd598a090c738e9ce9b07a1896673dc27f1503ae3bea1a210";
          libraryHaskellDepends = [
            base
            unix
          ];
          doHaddock = false;
          doCheck = false;
          description = "A compatibility layer for base";
          license = stdenv.lib.licenses.mit;
        }) {};
      base-orphans = callPackage ({ base, ghc-prim, mkDerivation, stdenv }:
      mkDerivation {
          pname = "base-orphans";
          version = "0.6";
          sha256 = "c7282aa7516652e6e4a78ccdfb654a99c9da683875748ad5898a3f200be7ad0e";
          libraryHaskellDepends = [
            base
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-compat/base-orphans#readme";
          description = "Backwards-compatible orphan instances for base";
          license = stdenv.lib.licenses.mit;
        }) {};
      base16-bytestring = callPackage ({ base, bytestring, ghc-prim, mkDerivation, stdenv }:
      mkDerivation {
          pname = "base16-bytestring";
          version = "0.1.1.6";
          sha256 = "5afe65a152c5418f5f4e3579a5e0d5ca19c279dc9bf31c1a371ccbe84705c449";
          libraryHaskellDepends = [
            base
            bytestring
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/bos/base16-bytestring";
          description = "Fast base16 (hex) encoding and decoding for ByteStrings";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      base64-bytestring = callPackage ({ base, bytestring, mkDerivation, stdenv }:
      mkDerivation {
          pname = "base64-bytestring";
          version = "1.0.0.1";
          sha256 = "ab25abf4b00a2f52b270bc3ed43f1d59f16c8eec9d7dffb14df1e9265b233b50";
          libraryHaskellDepends = [
            base
            bytestring
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/base64-bytestring";
          description = "Fast base64 encoding and decoding for ByteStrings";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      basement = callPackage ({ base, ghc-prim, mkDerivation, stdenv }:
      mkDerivation {
          pname = "basement";
          version = "0.0.4";
          sha256 = "68448325bacc85dcb8764d9f78d27285b56e978df03187bee912edbf1adab8fd";
          libraryHaskellDepends = [
            base
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-foundation/foundation";
          description = "Foundation scrap box of array & string";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      bifunctors = callPackage ({ base, base-orphans, comonad, containers, mkDerivation, semigroups, stdenv, tagged, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "bifunctors";
          version = "5.4.2";
          sha256 = "38620267824abbf834f708f1b7cf10307c1d2719b1a0f8ae49330a1002dfdc8d";
          libraryHaskellDepends = [
            base
            base-orphans
            comonad
            containers
            semigroups
            tagged
            template-haskell
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/bifunctors/";
          description = "Bifunctors";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      bindings-uname = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "bindings-uname";
          version = "0.1";
          sha256 = "130e75c3fd95e232452c7d903efbfab2d2ff6c9d455b617adeaebe5d60235cd3";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "Low-level binding to POSIX uname(3)";
          license = stdenv.lib.licenses.publicDomain;
        }) {};
      bitarray = callPackage ({ array, base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "bitarray";
          version = "0.0.1.1";
          sha256 = "b27f6f1065053a0e8e24fbf9382b7060af9962d8d150b631c682c0c58469d802";
          revision = "1";
          editedCabalFile = "10fk92v9afjqk43zi621jxl0n8kci0xjj32lz3vqa9xbh67zjz45";
          libraryHaskellDepends = [
            array
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://code.haskell.org/~bkomuves/";
          description = "Mutable and immutable bit arrays";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      blaze-builder = callPackage ({ base, bytestring, deepseq, mkDerivation, stdenv, text }:
      mkDerivation {
          pname = "blaze-builder";
          version = "0.4.0.2";
          sha256 = "9ad3e4661bf5556d650fb9aa56a3ad6e6eec7575e87d472e8ab6d15eaef163d4";
          libraryHaskellDepends = [
            base
            bytestring
            deepseq
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/lpsmith/blaze-builder";
          description = "Efficient buffered output";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      blaze-html = callPackage ({ base, blaze-builder, blaze-markup, bytestring, mkDerivation, stdenv, text }:
      mkDerivation {
          pname = "blaze-html";
          version = "0.9.0.1";
          sha256 = "aeceaab3fbccbf7f01a241819e6c16c0a1cf19dccecb795c5de5407bc8660a64";
          libraryHaskellDepends = [
            base
            blaze-builder
            blaze-markup
            bytestring
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://jaspervdj.be/blaze";
          description = "A blazingly fast HTML combinator library for Haskell";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      blaze-markup = callPackage ({ base, blaze-builder, bytestring, mkDerivation, stdenv, text }:
      mkDerivation {
          pname = "blaze-markup";
          version = "0.8.0.0";
          sha256 = "19e1cbb9303803273ed7f9fcf3b8b6938578afbed2bfafe5ea9fcc6d743f540f";
          libraryHaskellDepends = [
            base
            blaze-builder
            bytestring
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://jaspervdj.be/blaze";
          description = "A blazingly fast markup combinator library for Haskell";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      byteable = callPackage ({ base, bytestring, mkDerivation, stdenv }:
      mkDerivation {
          pname = "byteable";
          version = "0.1.1";
          sha256 = "243b34a1b5b64b39e39fe58f75c18f6cad5b668b10cabcd86816cbde27783fe2";
          enableSeparateDataOutput = true;
          libraryHaskellDepends = [
            base
            bytestring
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-byteable";
          description = "Type class for sequence of bytes";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      cabal-doctest = callPackage ({ Cabal, base, directory, filepath, mkDerivation, stdenv }:
      mkDerivation {
          pname = "cabal-doctest";
          version = "1.0.3";
          sha256 = "4c4747b954615812fb5af1459c5d7639623b2f01b2e0a19a4481845f78edd8e3";
          libraryHaskellDepends = [
            base
            Cabal
            directory
            filepath
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/phadej/cabal-doctest";
          description = "A Setup.hs helper for doctests running";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      cabal2nix = callPackage ({ Cabal, aeson, ansi-wl-pprint, base, bytestring, cabal-doctest, containers, deepseq, directory, distribution-nixpkgs, fetchgit, filepath, hackage-db, hopenssl, hpack, language-nix, lens, mkDerivation, monad-par, monad-par-extras, mtl, optparse-applicative, pretty, process, split, stdenv, text, time, transformers, utf8-string, yaml }:
      mkDerivation {
          pname = "cabal2nix";
          version = "2.7";
          src = fetchgit {
            url = "https://github.com/NixOS/cabal2nix.git";
            sha256 = "0h7395vmh0fpypjbqn6yqn2ms71g13w1wlwhnhz85ljdlfdhjq85";
            rev = "cba06639637a6764d78ab11bc0961a6815f699fd";
          };
          isLibrary = true;
          isExecutable = true;
          setupHaskellDepends = [
            base
            Cabal
            cabal-doctest
          ];
          libraryHaskellDepends = [
            aeson
            ansi-wl-pprint
            base
            bytestring
            Cabal
            containers
            deepseq
            directory
            distribution-nixpkgs
            filepath
            hackage-db
            hopenssl
            hpack
            language-nix
            lens
            optparse-applicative
            pretty
            process
            split
            text
            time
            transformers
            yaml
          ];
          executableHaskellDepends = [
            aeson
            ansi-wl-pprint
            base
            bytestring
            Cabal
            containers
            deepseq
            directory
            distribution-nixpkgs
            filepath
            hackage-db
            hopenssl
            hpack
            language-nix
            lens
            monad-par
            monad-par-extras
            mtl
            optparse-applicative
            pretty
            process
            split
            text
            time
            transformers
            utf8-string
            yaml
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/nixos/cabal2nix#readme";
          description = "Convert Cabal files into Nix build instructions";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      call-stack = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "call-stack";
          version = "0.1.0";
          sha256 = "f25f5e0992a39371079cc25c2a14b5abb872fa7d868a32753aac3a258b83b1e2";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/sol/call-stack#readme";
          description = "Use GHC call-stacks in a backward compatible way";
          license = stdenv.lib.licenses.mit;
        }) {};
      case-insensitive = callPackage ({ base, bytestring, deepseq, hashable, mkDerivation, stdenv, text }:
      mkDerivation {
          pname = "case-insensitive";
          version = "1.2.0.10";
          sha256 = "66321c40fffb35f3a3188ba508753b74aada53fb51c822a9752614b03765306c";
          libraryHaskellDepends = [
            base
            bytestring
            deepseq
            hashable
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/basvandijk/case-insensitive";
          description = "Case insensitive string comparison";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      cereal = callPackage ({ array, base, bytestring, containers, ghc-prim, mkDerivation, stdenv }:
      mkDerivation {
          pname = "cereal";
          version = "0.5.4.0";
          sha256 = "daca6c5aeff21ca233bebe006c158b0e4421b239c722768b568fca9b32cafee7";
          libraryHaskellDepends = [
            array
            base
            bytestring
            containers
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/GaloisInc/cereal";
          description = "A binary serialization library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      charset = callPackage ({ array, base, bytestring, containers, mkDerivation, semigroups, stdenv, unordered-containers }:
      mkDerivation {
          pname = "charset";
          version = "0.3.7.1";
          sha256 = "3d415d2883bd7bf0cc9f038e8323f19c71e07dd12a3c712f449ccb8b4daac0be";
          libraryHaskellDepends = [
            array
            base
            bytestring
            containers
            semigroups
            unordered-containers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/charset";
          description = "Fast unicode character sets based on complemented PATRICIA tries";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      clock = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "clock";
          version = "0.7.2";
          sha256 = "886601978898d3a91412fef895e864576a7125d661e1f8abc49a2a08840e691f";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/corsis/clock";
          description = "High-resolution clock functions: monotonic, realtime, cputime";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      comonad = callPackage ({ Cabal, base, cabal-doctest, containers, contravariant, distributive, mkDerivation, semigroups, stdenv, tagged, transformers, transformers-compat }:
      mkDerivation {
          pname = "comonad";
          version = "5.0.2";
          sha256 = "1bb0fe396ecd16008411862ee453e8bd7c3e0f3a7299537dd59466604a54b784";
          revision = "1";
          editedCabalFile = "1lnsnx8p3wlfhd1xfc68za3b00vq77z2m6b0vqiw2laqmpj9akcw";
          setupHaskellDepends = [
            base
            Cabal
            cabal-doctest
          ];
          libraryHaskellDepends = [
            base
            containers
            contravariant
            distributive
            semigroups
            tagged
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/comonad/";
          description = "Comonads";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      conduit = callPackage ({ base, exceptions, lifted-base, mkDerivation, mmorph, monad-control, mtl, primitive, resourcet, stdenv, transformers, transformers-base, transformers-compat }:
      mkDerivation {
          pname = "conduit";
          version = "1.2.12.1";
          sha256 = "0072bb2daf993227e7913f3011e0f0654e6847e818caebb7f066f803a97b867e";
          libraryHaskellDepends = [
            base
            exceptions
            lifted-base
            mmorph
            monad-control
            mtl
            primitive
            resourcet
            transformers
            transformers-base
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/snoyberg/conduit";
          description = "Streaming data processing library";
          license = stdenv.lib.licenses.mit;
        }) {};
      conduit-extra = callPackage ({ async, attoparsec, base, blaze-builder, bytestring, conduit, directory, exceptions, filepath, mkDerivation, monad-control, network, primitive, process, resourcet, stdenv, stm, streaming-commons, text, transformers, transformers-base }:
      mkDerivation {
          pname = "conduit-extra";
          version = "1.1.17";
          sha256 = "768e44686ce1ae362fce2ca766e18638129efb9e5348a361c65a123749c20a06";
          libraryHaskellDepends = [
            async
            attoparsec
            base
            blaze-builder
            bytestring
            conduit
            directory
            exceptions
            filepath
            monad-control
            network
            primitive
            process
            resourcet
            stm
            streaming-commons
            text
            transformers
            transformers-base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/snoyberg/conduit";
          description = "Batteries included conduit: adapters for common libraries";
          license = stdenv.lib.licenses.mit;
        }) {};
      connection = callPackage ({ base, byteable, bytestring, containers, data-default-class, mkDerivation, network, socks, stdenv, tls, x509, x509-store, x509-system, x509-validation }:
      mkDerivation {
          pname = "connection";
          version = "0.2.8";
          sha256 = "70b1f44e8786320c18b26fc5d4ec115fc8ac016ba1f852fa8137f55d785a93eb";
          libraryHaskellDepends = [
            base
            byteable
            bytestring
            containers
            data-default-class
            network
            socks
            tls
            x509
            x509-store
            x509-system
            x509-validation
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-connection";
          description = "Simple and easy network connections API";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      contravariant = callPackage ({ StateVar, base, mkDerivation, semigroups, stdenv, transformers, transformers-compat, void }:
      mkDerivation {
          pname = "contravariant";
          version = "1.4";
          sha256 = "e1666df1373ed784baa7d1e8e963bbc2d1f3c391578ac550ae74e7399173ee84";
          libraryHaskellDepends = [
            base
            semigroups
            StateVar
            transformers
            transformers-compat
            void
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/contravariant/";
          description = "Contravariant functors";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      cookie = callPackage ({ base, blaze-builder, bytestring, data-default-class, deepseq, mkDerivation, old-locale, stdenv, text, time }:
      mkDerivation {
          pname = "cookie";
          version = "0.4.3";
          sha256 = "fbfb0c4fcebe6cb85cb6b84572287a57ee7e3a380f2fe51c4885bfb460f3ed62";
          libraryHaskellDepends = [
            base
            blaze-builder
            bytestring
            data-default-class
            deepseq
            old-locale
            text
            time
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/snoyberg/cookie";
          description = "HTTP cookie parsing and rendering";
          license = stdenv.lib.licenses.mit;
        }) {};
      cryptohash = callPackage ({ base, byteable, bytestring, cryptonite, ghc-prim, memory, mkDerivation, stdenv }:
      mkDerivation {
          pname = "cryptohash";
          version = "0.11.9";
          sha256 = "c28f847fc1fcd65b6eea2e74a100300af940919f04bb21d391f6a773968f22fb";
          libraryHaskellDepends = [
            base
            byteable
            bytestring
            cryptonite
            ghc-prim
            memory
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-cryptohash";
          description = "collection of crypto hashes, fast, pure and practical";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      cryptohash-sha256 = callPackage ({ base, bytestring, mkDerivation, stdenv }:
      mkDerivation {
          pname = "cryptohash-sha256";
          version = "0.11.101.0";
          sha256 = "52756435dbea248e344fbcbcc5df5307f60dfacf337dfd11ae30f1c7a4da05dd";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            bytestring
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/hvr/cryptohash-sha256";
          description = "Fast, pure and practical SHA-256 implementation";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      cryptonite = callPackage ({ base, bytestring, deepseq, foundation, ghc-prim, integer-gmp, memory, mkDerivation, stdenv }:
      mkDerivation {
          pname = "cryptonite";
          version = "0.23";
          sha256 = "ee4a1c2cec13f3697a2a35255022fe802b2e29cd836b280702f2495b5f6f0099";
          libraryHaskellDepends = [
            base
            bytestring
            deepseq
            foundation
            ghc-prim
            integer-gmp
            memory
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-crypto/cryptonite";
          description = "Cryptography Primitives sink";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      cryptonite-conduit = callPackage ({ base, bytestring, conduit, conduit-extra, cryptonite, exceptions, memory, mkDerivation, resourcet, stdenv, transformers }:
      mkDerivation {
          pname = "cryptonite-conduit";
          version = "0.2.2";
          sha256 = "705d69ab3f79b7b8810c7b9e7da81a1c6686b6a4323b1e78150576a25a658dae";
          libraryHaskellDepends = [
            base
            bytestring
            conduit
            conduit-extra
            cryptonite
            exceptions
            memory
            resourcet
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-crypto/cryptonite-conduit";
          description = "cryptonite conduit";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      data-default-class = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "data-default-class";
          version = "0.1.2.0";
          sha256 = "4f01b423f000c3e069aaf52a348564a6536797f31498bb85c3db4bd2d0973e56";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "A class for types with a default value";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      data-fix = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "data-fix";
          version = "0.0.7";
          sha256 = "1098ccc68fd77959bc04eb69f16373ddbb07a7fb48d96eb897aa9e1456656912";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/anton-k/data-fix";
          description = "Fixpoint data types";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      deriving-compat = callPackage ({ base, containers, ghc-boot-th, ghc-prim, mkDerivation, stdenv, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "deriving-compat";
          version = "0.3.6";
          sha256 = "0c1fab416505e3fabaec007828073c065db077f004dcc6955f2cd32ca139356d";
          libraryHaskellDepends = [
            base
            containers
            ghc-boot-th
            ghc-prim
            template-haskell
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-compat/deriving-compat";
          description = "Backports of GHC deriving extensions";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      digest = callPackage ({ base, bytestring, mkDerivation, stdenv, zlib }:
      mkDerivation {
          pname = "digest";
          version = "0.0.1.2";
          sha256 = "641717eb16392abf8965986a9e8dc21eebf1d97775bbb6923c7b7f8fee17fe11";
          libraryHaskellDepends = [
            base
            bytestring
          ];
          librarySystemDepends = [ zlib ];
          doHaddock = false;
          doCheck = false;
          description = "Various cryptographic hashes for bytestrings; CRC32 and Adler32 for now";
          license = stdenv.lib.licenses.bsd3;
        }) { zlib = pkgs.zlib; };
      distribution-nixpkgs = callPackage ({ Cabal, aeson, base, bytestring, containers, deepseq, language-nix, lens, mkDerivation, pretty, process, split, stdenv }:
      mkDerivation {
          pname = "distribution-nixpkgs";
          version = "1.1";
          sha256 = "1d072e1918a494bd476f666d9665b4e14a7551f5c57cd9640f0f5f986b40a896";
          libraryHaskellDepends = [
            aeson
            base
            bytestring
            Cabal
            containers
            deepseq
            language-nix
            lens
            pretty
            process
            split
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/peti/distribution-nixpkgs#readme";
          description = "Types and functions to manipulate the Nixpkgs distribution";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      distributive = callPackage ({ Cabal, base, base-orphans, cabal-doctest, mkDerivation, stdenv, tagged, transformers, transformers-compat }:
      mkDerivation {
          pname = "distributive";
          version = "0.5.3";
          sha256 = "9173805b9c941bda1f37e5aeb68ae30f57a12df9b17bd2aa86db3b7d5236a678";
          revision = "2";
          editedCabalFile = "02j27xvlj0jw3b2jpfg6wbysj0blllin792wj6qnrgnrvd4haj7v";
          setupHaskellDepends = [
            base
            Cabal
            cabal-doctest
          ];
          libraryHaskellDepends = [
            base
            base-orphans
            tagged
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/distributive/";
          description = "Distributive functors -- Dual to Traversable";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      dlist = callPackage ({ base, deepseq, mkDerivation, stdenv }:
      mkDerivation {
          pname = "dlist";
          version = "0.8.0.3";
          sha256 = "876782c96957ff480863effb33878f48dd55de7fa64d036e12bf1fbd49542f2f";
          libraryHaskellDepends = [
            base
            deepseq
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/spl/dlist";
          description = "Difference lists";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      easy-file = callPackage ({ base, directory, filepath, mkDerivation, stdenv, time, unix }:
      mkDerivation {
          pname = "easy-file";
          version = "0.2.1";
          sha256 = "ff86e1b29284499bea5f1d0ff539b3ed64fa6d1a06c2243ca61f93be0202e56c";
          libraryHaskellDepends = [
            base
            directory
            filepath
            time
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/kazu-yamamoto/easy-file";
          description = "Cross-platform File handling";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      echo = callPackage ({ base, mkDerivation, process, stdenv }:
      mkDerivation {
          pname = "echo";
          version = "0.1.3";
          sha256 = "704f07310f8272d170f8ab7fb2a2c13f15d8501ef8310801e36964c8eff485ef";
          revision = "1";
          editedCabalFile = "0br8wfiybcw5hand4imiw0i5hacdmrax1dv8g95f35gazffbx42l";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            process
          ];
          executableHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/RyanGlScott/echo";
          description = "A cross-platform, cross-console way to handle echoing terminal input";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      ed25519 = callPackage ({ base, bytestring, ghc-prim, mkDerivation, stdenv }:
      mkDerivation {
          pname = "ed25519";
          version = "0.0.5.0";
          sha256 = "d8a5958ebfa9309790efade64275dc5c441b568645c45ceed1b0c6ff36d6156d";
          revision = "2";
          editedCabalFile = "1cq6h3jqkb1kvd9fjfhsllg5gq78sdiyf2gy9862xhlbv6wil19f";
          libraryHaskellDepends = [
            base
            bytestring
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://thoughtpolice.github.com/hs-ed25519";
          description = "Ed25519 cryptographic signatures";
          license = stdenv.lib.licenses.mit;
        }) {};
      either = callPackage ({ MonadRandom, base, bifunctors, exceptions, free, mkDerivation, mmorph, monad-control, mtl, profunctors, semigroupoids, semigroups, stdenv, transformers, transformers-base }:
      mkDerivation {
          pname = "either";
          version = "4.4.1.1";
          sha256 = "b087cb0fb63fec2fbdcac05fef0d03751daef5deb86cda3c732b9a6a31e634d3";
          revision = "2";
          editedCabalFile = "1n7792mcrvfh31qrbj8mpnx372s03kz83mypj7l4fm5h6zi4a3hs";
          libraryHaskellDepends = [
            base
            bifunctors
            exceptions
            free
            mmorph
            monad-control
            MonadRandom
            mtl
            profunctors
            semigroupoids
            semigroups
            transformers
            transformers-base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/either/";
          description = "An either monad transformer";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      exceptions = callPackage ({ base, mkDerivation, mtl, stdenv, stm, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "exceptions";
          version = "0.8.3";
          sha256 = "4d6ad97e8e3d5dc6ce9ae68a469dc2fd3f66e9d312bc6faa7ab162eddcef87be";
          revision = "2";
          editedCabalFile = "1vl59j0l7m53hkzlcfmdbqbab8dk4lp9gzwryn7nsr6ylg94wayw";
          libraryHaskellDepends = [
            base
            mtl
            stm
            template-haskell
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/exceptions/";
          description = "Extensible optionally-pure exceptions";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      extra = callPackage ({ base, clock, directory, filepath, mkDerivation, process, stdenv, time, unix }:
      mkDerivation {
          pname = "extra";
          version = "1.5.3";
          sha256 = "a44b5db0c7004a9299f738e30e4aa4cac1e4428a84fb67fd9b1b21f96fd58c70";
          libraryHaskellDepends = [
            base
            clock
            directory
            filepath
            process
            time
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/ndmitchell/extra#readme";
          description = "Extra functions I use";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      fail = callPackage ({ mkDerivation, stdenv }:
      mkDerivation {
          pname = "fail";
          version = "4.9.0.0";
          sha256 = "6d5cdb1a5c539425a9665f740e364722e1d9d6ae37fbc55f30fe3dbbbb91d4a2";
          doHaddock = false;
          doCheck = false;
          homepage = "https://prime.haskell.org/wiki/Libraries/Proposals/MonadFail";
          description = "Forward-compatible MonadFail class";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      fast-logger = callPackage ({ array, auto-update, base, bytestring, directory, easy-file, filepath, mkDerivation, stdenv, text, unix, unix-time }:
      mkDerivation {
          pname = "fast-logger";
          version = "2.4.10";
          sha256 = "dec4a5d1a88f822d08d334ee870a08a8bb63b2b226d145cd24a7f08676ce678d";
          libraryHaskellDepends = [
            array
            auto-update
            base
            bytestring
            directory
            easy-file
            filepath
            text
            unix
            unix-time
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/kazu-yamamoto/logger";
          description = "A fast logging system";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      file-embed = callPackage ({ base, bytestring, directory, filepath, mkDerivation, stdenv, template-haskell }:
      mkDerivation {
          pname = "file-embed";
          version = "0.0.10";
          sha256 = "f751925cec5773a4fad5a48ca0a86a21091ee5f1efccf618a64a89fa2cf5f711";
          libraryHaskellDepends = [
            base
            bytestring
            directory
            filepath
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/snoyberg/file-embed";
          description = "Use Template Haskell to embed file contents directly";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      filelock = callPackage ({ base, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "filelock";
          version = "0.1.1.2";
          sha256 = "0ff1dcb13ec619f72496035e2a1298ef9dc6a814ba304d882cd9b145eae3203d";
          libraryHaskellDepends = [
            base
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/takano-akio/filelock";
          description = "Portable interface to file locking (flock / LockFileEx)";
          license = stdenv.lib.licenses.publicDomain;
        }) {};
      fingertree = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "fingertree";
          version = "0.1.2.1";
          sha256 = "a5bbd45459df4e7a4e8225b9929f942f2cae08739778c4439737a60e17856c0f";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "Generic finger-tree structure, with example instances";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      foundation = callPackage ({ base, basement, ghc-prim, mkDerivation, stdenv }:
      mkDerivation {
          pname = "foundation";
          version = "0.0.17";
          sha256 = "04d1a273c5575ffd12c822995bbe4e93bfa92571b4eb9bc792ae84030fb9c201";
          revision = "1";
          editedCabalFile = "15y38y0mj4vc694jwh3cjgnq8xv5vv7954g633f7mw5f0hb3yxkn";
          libraryHaskellDepends = [
            base
            basement
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-foundation/foundation";
          description = "Alternative prelude with batteries and no dependencies";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      free = callPackage ({ base, bifunctors, comonad, containers, distributive, exceptions, mkDerivation, mtl, prelude-extras, profunctors, semigroupoids, semigroups, stdenv, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "free";
          version = "4.12.4";
          sha256 = "c9fe45aae387855626ecb5a0fea6afdb207143cb00af3b1f715d1032d2d08784";
          libraryHaskellDepends = [
            base
            bifunctors
            comonad
            containers
            distributive
            exceptions
            mtl
            prelude-extras
            profunctors
            semigroupoids
            semigroups
            template-haskell
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/free/";
          description = "Monads for free";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      fsnotify = callPackage ({ async, base, containers, directory, filepath, hinotify, mkDerivation, stdenv, text, time, unix-compat }:
      mkDerivation {
          pname = "fsnotify";
          version = "0.2.1.1";
          sha256 = "175a75962ad07c30c031fa8931f8d3e32abc06a96676e73e65cb7207e9d2dc90";
          libraryHaskellDepends = [
            async
            base
            containers
            directory
            filepath
            hinotify
            text
            time
            unix-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-fswatch/hfsnotify";
          description = "Cross platform library for file change notification";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      generic-deriving = callPackage ({ base, containers, ghc-prim, mkDerivation, stdenv, template-haskell }:
      mkDerivation {
          pname = "generic-deriving";
          version = "1.11.2";
          sha256 = "29960f2aa810abffc2f02658e7fa523cbfa4c92102e02d252482f9551bc122f9";
          libraryHaskellDepends = [
            base
            containers
            ghc-prim
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/dreixel/generic-deriving";
          description = "Generic programming library for generalised deriving";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      gitrev = callPackage ({ base, base-compat, directory, filepath, mkDerivation, process, stdenv, template-haskell }:
      mkDerivation {
          pname = "gitrev";
          version = "1.3.1";
          sha256 = "a89964db24f56727b0e7b10c98fe7c116d721d8c46f52d6e77088669aaa38332";
          libraryHaskellDepends = [
            base
            base-compat
            directory
            filepath
            process
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/acfoltzer/gitrev";
          description = "Compile git revision info into Haskell projects";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hackage-db = callPackage ({ Cabal, aeson, base, bytestring, containers, directory, filepath, mkDerivation, stdenv, tar, time, utf8-string }:
      mkDerivation {
          pname = "hackage-db";
          version = "2.0";
          sha256 = "f8390ab421f89bd8b03df9c3d34c86a82ea26d150dfb5cfb1bdb16f20452bf27";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            aeson
            base
            bytestring
            Cabal
            containers
            directory
            filepath
            tar
            time
            utf8-string
          ];
          executableHaskellDepends = [
            base
            bytestring
            Cabal
            containers
            utf8-string
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/peti/hackage-db#readme";
          description = "Access Hackage's package database via Data.Map";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hackage-security = callPackage ({ Cabal, base, base16-bytestring, base64-bytestring, bytestring, containers, cryptohash-sha256, directory, ed25519, filepath, ghc-prim, mkDerivation, mtl, network, network-uri, parsec, pretty, stdenv, tar, template-haskell, time, transformers, zlib }:
      mkDerivation {
          pname = "hackage-security";
          version = "0.5.2.2";
          sha256 = "507a837851264a774c8f4d400f798c3dac5be11dc428fe72d33ef594ca533c41";
          revision = "4";
          editedCabalFile = "154xjzmzg14zcqxzhcf0kmdmm6hwnhx19x6kddakkrylfqap14j2";
          libraryHaskellDepends = [
            base
            base16-bytestring
            base64-bytestring
            bytestring
            Cabal
            containers
            cryptohash-sha256
            directory
            ed25519
            filepath
            ghc-prim
            mtl
            network
            network-uri
            parsec
            pretty
            tar
            template-haskell
            time
            transformers
            zlib
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/well-typed/hackage-security";
          description = "Hackage security library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hashable = callPackage ({ base, bytestring, deepseq, ghc-prim, integer-gmp, mkDerivation, stdenv, text }:
      mkDerivation {
          pname = "hashable";
          version = "1.2.6.1";
          sha256 = "94ca8789e13bc05c1582c46b709f3b0f5aeec2092be634b8606dbd9c5915bb7a";
          revision = "2";
          editedCabalFile = "0w4756sa04nk2bw3vnysb0y9d09zzg3c77aydkjfxz1hnl1dvnjn";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            bytestring
            deepseq
            ghc-prim
            integer-gmp
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/tibbe/hashable";
          description = "A class for types that can be converted to a hash value";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hastache = callPackage ({ base, blaze-builder, bytestring, containers, directory, filepath, ieee754, mkDerivation, mtl, process, stdenv, syb, text, transformers }:
      mkDerivation {
          pname = "hastache";
          version = "0.6.1";
          sha256 = "8c8f89669d6125201d7163385ea9055ab8027a69d1513259f8fbdd53c244b464";
          revision = "5";
          editedCabalFile = "0fwd1jd6sqkscmy2yq1w3dcl4va4w9n8mhs6ldrilh1cj6b54r3f";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            blaze-builder
            bytestring
            containers
            directory
            filepath
            ieee754
            mtl
            syb
            text
            transformers
          ];
          executableHaskellDepends = [
            base
            blaze-builder
            bytestring
            containers
            directory
            filepath
            ieee754
            mtl
            process
            syb
            text
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/lymar/hastache";
          description = "Haskell implementation of Mustache templates";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hinotify = callPackage ({ async, base, containers, directory, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "hinotify";
          version = "0.3.9";
          sha256 = "f2480e4c08a516831c2221eebc6a9d3242e892932d9315c34cbe92a101c5df99";
          libraryHaskellDepends = [
            async
            base
            containers
            directory
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/kolmodin/hinotify.git";
          description = "Haskell binding to inotify";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hnix = callPackage ({ ansi-wl-pprint, base, containers, data-fix, deepseq, deriving-compat, mkDerivation, parsers, semigroups, stdenv, text, transformers, trifecta, unordered-containers }:
      mkDerivation {
          pname = "hnix";
          version = "0.3.4";
          sha256 = "ec890845cc8a782ff8a2e7a2dcbaf763d5ddb3ff202293f701828d04a85adbf2";
          revision = "1";
          editedCabalFile = "01svkjznkz51742k3hcc0ssz5m0kymk53ydrdwg4a24ygvb408iw";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            ansi-wl-pprint
            base
            containers
            data-fix
            deepseq
            deriving-compat
            parsers
            semigroups
            text
            transformers
            trifecta
            unordered-containers
          ];
          executableHaskellDepends = [
            ansi-wl-pprint
            base
            containers
            data-fix
            deepseq
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/jwiegley/hnix";
          description = "Haskell implementation of the Nix language";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hopenssl = callPackage ({ Cabal, base, bytestring, cabal-doctest, mkDerivation, openssl, stdenv }:
      mkDerivation {
          pname = "hopenssl";
          version = "2.2.1";
          sha256 = "7031aac15f132057f8013f819774081cd8fc4a14fb076bc3dffb478d66d0abdf";
          setupHaskellDepends = [
            base
            Cabal
            cabal-doctest
          ];
          libraryHaskellDepends = [
            base
            bytestring
          ];
          librarySystemDepends = [
            openssl
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/peti/hopenssl";
          description = "FFI Bindings to OpenSSL's EVP Digest Interface";
          license = stdenv.lib.licenses.bsd3;
        }) { openssl = pkgs.openssl; };
      hourglass = callPackage ({ base, deepseq, mkDerivation, stdenv }:
      mkDerivation {
          pname = "hourglass";
          version = "0.2.10";
          sha256 = "d553362d7a6f7df60d8ff99304aaad0995be81f9d302725ebe9441829a0f8d80";
          libraryHaskellDepends = [
            base
            deepseq
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/vincenthz/hs-hourglass";
          description = "simple performant time related library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hpack = callPackage ({ Glob, aeson, base, base-compat, bytestring, containers, deepseq, directory, filepath, mkDerivation, stdenv, text, unordered-containers, yaml }:
      mkDerivation {
          pname = "hpack";
          version = "0.18.1";
          sha256 = "f35434f67d71918991d0e1ef75a934044b854909169678ecefa01e148ce24aeb";
          revision = "1";
          editedCabalFile = "193hxa5ar54dhr0acp1y1c0990689srqqr2bygrv31ivhz6hj1sx";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            aeson
            base
            base-compat
            bytestring
            containers
            deepseq
            directory
            filepath
            Glob
            text
            unordered-containers
            yaml
          ];
          executableHaskellDepends = [
            aeson
            base
            base-compat
            bytestring
            containers
            deepseq
            directory
            filepath
            Glob
            text
            unordered-containers
            yaml
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/sol/hpack#readme";
          description = "An alternative format for Haskell packages";
          license = stdenv.lib.licenses.mit;
        }) {};
      hscolour = callPackage ({ base, containers, mkDerivation, stdenv }:
      mkDerivation {
          pname = "hscolour";
          version = "1.24.4";
          sha256 = "243332b082294117f37b2c2c68079fa61af68b36223b3fc07594f245e0e5321d";
          isLibrary = true;
          isExecutable = true;
          enableSeparateDataOutput = true;
          libraryHaskellDepends = [
            base
            containers
          ];
          executableHaskellDepends = [
            base
            containers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://code.haskell.org/~malcolm/hscolour/";
          description = "Colourise Haskell code";
          license = "LGPL";
        }) {};
      hspec = callPackage ({ HUnit, QuickCheck, base, call-stack, hspec-core, hspec-discover, hspec-expectations, mkDerivation, stdenv, stringbuilder, transformers }:
      mkDerivation {
          pname = "hspec";
          version = "2.4.4";
          sha256 = "b01a3245da9c597608befddc4fc3cae35e5bc753235877076f11ae8e0647cf21";
          libraryHaskellDepends = [
            base
            call-stack
            hspec-core
            hspec-discover
            hspec-expectations
            HUnit
            QuickCheck
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://hspec.github.io/";
          description = "A Testing Framework for Haskell";
          license = stdenv.lib.licenses.mit;
        }) {};
      hspec-core = callPackage ({ HUnit, QuickCheck, ansi-terminal, array, async, base, call-stack, deepseq, directory, filepath, hspec-expectations, mkDerivation, quickcheck-io, random, setenv, stdenv, tf-random, time, transformers }:
      mkDerivation {
          pname = "hspec-core";
          version = "2.4.4";
          sha256 = "601d321cdf7f2685880ee80c31154763884cb90dc512906005c4a485e8c8bfdf";
          libraryHaskellDepends = [
            ansi-terminal
            array
            async
            base
            call-stack
            deepseq
            directory
            filepath
            hspec-expectations
            HUnit
            QuickCheck
            quickcheck-io
            random
            setenv
            tf-random
            time
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          testTarget = "--test-option=--skip --test-option='Test.Hspec.Core.Runner.hspecResult runs specs in parallel'";
          homepage = "http://hspec.github.io/";
          description = "A Testing Framework for Haskell";
          license = stdenv.lib.licenses.mit;
        }) {};
      hspec-discover = callPackage ({ base, directory, filepath, mkDerivation, stdenv }:
      mkDerivation {
          pname = "hspec-discover";
          version = "2.4.4";
          sha256 = "76423bc72f3ed0a80ccefb26fbf3fb16c3d74a69d69b4ce0bc88db54984d5d47";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            directory
            filepath
          ];
          executableHaskellDepends = [
            base
            directory
            filepath
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://hspec.github.io/";
          description = "Automatically discover and run Hspec tests";
          license = stdenv.lib.licenses.mit;
        }) {};
      hspec-expectations = callPackage ({ HUnit, base, call-stack, mkDerivation, stdenv }:
      mkDerivation {
          pname = "hspec-expectations";
          version = "0.8.2";
          sha256 = "819607ea1faf35ce5be34be61c6f50f3389ea43892d56fb28c57a9f5d54fb4ef";
          libraryHaskellDepends = [
            base
            call-stack
            HUnit
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/hspec/hspec-expectations#readme";
          description = "Catchy combinators for HUnit";
          license = stdenv.lib.licenses.mit;
        }) {};
      hspec-smallcheck = callPackage ({ base, hspec-core, mkDerivation, smallcheck, stdenv }:
      mkDerivation {
          pname = "hspec-smallcheck";
          version = "0.4.2";
          sha256 = "ba09d4b2eb1c6ff2d680aa09b36eb6c0b395cc258ae716b8d1db511073385ed3";
          libraryHaskellDepends = [
            base
            hspec-core
            smallcheck
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://hspec.github.io/";
          description = "SmallCheck support for the Hspec testing framework";
          license = stdenv.lib.licenses.mit;
        }) {};
      http-api-data = callPackage ({ Cabal, attoparsec, attoparsec-iso8601, base, bytestring, cabal-doctest, containers, hashable, http-types, mkDerivation, stdenv, text, time, time-locale-compat, unordered-containers, uri-bytestring, uuid-types }:
      mkDerivation {
          pname = "http-api-data";
          version = "0.3.7.1";
          sha256 = "8c633e95113c8ab655f4ba67e51e41a2c9035f0122ea68bfbb876b37277075fd";
          setupHaskellDepends = [
            base
            Cabal
            cabal-doctest
          ];
          libraryHaskellDepends = [
            attoparsec
            attoparsec-iso8601
            base
            bytestring
            containers
            hashable
            http-types
            text
            time
            time-locale-compat
            unordered-containers
            uri-bytestring
            uuid-types
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/fizruk/http-api-data";
          description = "Converting to/from HTTP API data like URL pieces, headers and query parameters";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      http-client = callPackage ({ array, base, base64-bytestring, blaze-builder, bytestring, case-insensitive, containers, cookie, deepseq, exceptions, filepath, ghc-prim, http-types, mime-types, mkDerivation, network, network-uri, random, stdenv, streaming-commons, text, time, transformers }:
      mkDerivation {
          pname = "http-client";
          version = "0.5.7.1";
          sha256 = "de89a89866e6a823d6860666657de93cf11c84967e47a3df1d5548c99cb59ba5";
          libraryHaskellDepends = [
            array
            base
            base64-bytestring
            blaze-builder
            bytestring
            case-insensitive
            containers
            cookie
            deepseq
            exceptions
            filepath
            ghc-prim
            http-types
            mime-types
            network
            network-uri
            random
            streaming-commons
            text
            time
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/snoyberg/http-client";
          description = "An HTTP client engine";
          license = stdenv.lib.licenses.mit;
        }) {};
      http-client-tls = callPackage ({ base, bytestring, case-insensitive, connection, containers, cryptonite, data-default-class, exceptions, http-client, http-types, memory, mkDerivation, network, network-uri, stdenv, text, tls, transformers }:
      mkDerivation {
          pname = "http-client-tls";
          version = "0.3.5.1";
          sha256 = "c1fa23eb868f4b4e36304f3d03890bce1230284be79f80bd7b4fe1733e8a9558";
          libraryHaskellDepends = [
            base
            bytestring
            case-insensitive
            connection
            containers
            cryptonite
            data-default-class
            exceptions
            http-client
            http-types
            memory
            network
            network-uri
            text
            tls
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/snoyberg/http-client";
          description = "http-client backend using the connection package and tls library";
          license = stdenv.lib.licenses.mit;
        }) {};
      http-conduit = callPackage ({ aeson, base, bytestring, conduit, conduit-extra, exceptions, http-client, http-client-tls, http-types, lifted-base, mkDerivation, monad-control, mtl, resourcet, stdenv, transformers }:
      mkDerivation {
          pname = "http-conduit";
          version = "2.2.3.2";
          sha256 = "e359c3ef370731e895a5c213e805c6806394f13598647f36dce7be41d4c41eb8";
          libraryHaskellDepends = [
            aeson
            base
            bytestring
            conduit
            conduit-extra
            exceptions
            http-client
            http-client-tls
            http-types
            lifted-base
            monad-control
            mtl
            resourcet
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://www.yesodweb.com/book/http-conduit";
          description = "HTTP client package with conduit interface and HTTPS support";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      http-types = callPackage ({ array, base, blaze-builder, bytestring, case-insensitive, mkDerivation, stdenv, text }:
      mkDerivation {
          pname = "http-types";
          version = "0.9.1";
          sha256 = "7bed648cdc1c69e76bf039763dbe1074b55fd2704911dd0cb6b7dfebf1b6f550";
          libraryHaskellDepends = [
            array
            base
            blaze-builder
            bytestring
            case-insensitive
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/aristidb/http-types";
          description = "Generic HTTP types for Haskell (for both client and server code)";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      ieee754 = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "ieee754";
          version = "0.8.0";
          sha256 = "0e2dff9c37f59acf5c64f978ec320005e9830f276f9f314e4bfed3f482289ad1";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/patperry/hs-ieee754";
          description = "Utilities for dealing with IEEE floating point numbers";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      integer-logarithms = callPackage ({ array, base, ghc-prim, integer-gmp, mkDerivation, stdenv }:
      mkDerivation {
          pname = "integer-logarithms";
          version = "1.0.2";
          sha256 = "31069ccbff489baf6c4a93cb7475640aabea9366eb0b583236f10714a682b570";
          libraryHaskellDepends = [
            array
            base
            ghc-prim
            integer-gmp
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/phadej/integer-logarithms";
          description = "Integer logarithms";
          license = stdenv.lib.licenses.mit;
        }) {};
      kan-extensions = callPackage ({ adjunctions, array, base, comonad, containers, contravariant, distributive, fail, free, mkDerivation, mtl, semigroupoids, stdenv, tagged, transformers }:
      mkDerivation {
          pname = "kan-extensions";
          version = "5.0.2";
          sha256 = "1c9ede8595424209944e59fd46c1d2edb654758be9a45c1c48a4d3cedf42482e";
          libraryHaskellDepends = [
            adjunctions
            array
            base
            comonad
            containers
            contravariant
            distributive
            fail
            free
            mtl
            semigroupoids
            tagged
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/kan-extensions/";
          description = "Kan extensions, Kan lifts, various forms of the Yoneda lemma, and (co)density (co)monads";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      language-nix = callPackage ({ Cabal, QuickCheck, base, base-compat, deepseq, lens, mkDerivation, pretty, stdenv }:
      mkDerivation {
          pname = "language-nix";
          version = "2.1.0.1";
          sha256 = "f0147300724ac39ce388cd6cd717ac3ccc6ed1884ffaafebb18d0f3021e01acf";
          revision = "1";
          editedCabalFile = "1zv12p4ralrks0517zs52rzmzmsxxkcxkqz7zijfgcsvh6bsmafi";
          libraryHaskellDepends = [
            base
            base-compat
            Cabal
            deepseq
            lens
            pretty
            QuickCheck
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/peti/language-nix#readme";
          description = "Data types and useful functions to represent and manipulate the Nix language";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      lens = callPackage ({ Cabal, array, base, base-orphans, bifunctors, bytestring, cabal-doctest, call-stack, comonad, containers, contravariant, distributive, exceptions, filepath, free, ghc-prim, hashable, kan-extensions, mkDerivation, mtl, parallel, profunctors, reflection, semigroupoids, semigroups, stdenv, tagged, template-haskell, text, th-abstraction, transformers, transformers-compat, unordered-containers, vector, void }:
      mkDerivation {
          pname = "lens";
          version = "4.15.4";
          sha256 = "742e7b87d7945e3d9c1d39d3f8440094c0a31cd098f06a08f8dabefba0a57cd2";
          setupHaskellDepends = [
            base
            Cabal
            cabal-doctest
            filepath
          ];
          libraryHaskellDepends = [
            array
            base
            base-orphans
            bifunctors
            bytestring
            call-stack
            comonad
            containers
            contravariant
            distributive
            exceptions
            filepath
            free
            ghc-prim
            hashable
            kan-extensions
            mtl
            parallel
            profunctors
            reflection
            semigroupoids
            semigroups
            tagged
            template-haskell
            text
            th-abstraction
            transformers
            transformers-compat
            unordered-containers
            vector
            void
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/lens/";
          description = "Lenses, Folds and Traversals";
          license = stdenv.lib.licenses.bsd2;
        }) {};
      lifted-base = callPackage ({ base, mkDerivation, monad-control, stdenv, transformers-base }:
      mkDerivation {
          pname = "lifted-base";
          version = "0.2.3.11";
          sha256 = "8ec47a9fce7cf5913766a5c53e1b2cf254be733fa9d62e6e2f3f24e538005aab";
          libraryHaskellDepends = [
            base
            monad-control
            transformers-base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/basvandijk/lifted-base";
          description = "lifted IO operations from the base library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      logict = callPackage ({ base, mkDerivation, mtl, stdenv }:
      mkDerivation {
          pname = "logict";
          version = "0.6.0.2";
          sha256 = "1182b68e8d00279460c7fb9b8284bf129805c07754c678b2a8de5a6d768e161e";
          libraryHaskellDepends = [
            base
            mtl
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://code.haskell.org/~dolio/";
          description = "A backtracking logic-programming monad";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      math-functions = callPackage ({ base, deepseq, mkDerivation, primitive, stdenv, vector, vector-th-unbox }:
      mkDerivation {
          pname = "math-functions";
          version = "0.2.1.0";
          sha256 = "f71b5598de453546396a3f5f7f6ce877fffcc996639b7569d8628cae97da65eb";
          libraryHaskellDepends = [
            base
            deepseq
            primitive
            vector
            vector-th-unbox
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/math-functions";
          description = "Special functions and Chebyshev polynomials";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      memory = callPackage ({ base, bytestring, deepseq, foundation, ghc-prim, mkDerivation, stdenv }:
      mkDerivation {
          pname = "memory";
          version = "0.14.8";
          sha256 = "d3d79d30a9f2021ce0002d66b1c57727363195c29d73cd18070a4ee6858d7224";
          libraryHaskellDepends = [
            base
            bytestring
            deepseq
            foundation
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/vincenthz/hs-memory";
          description = "memory and related abstraction stuff";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      microlens = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "microlens";
          version = "0.4.8.1";
          sha256 = "17b8df1d3472463934edf1a519f23d8ef315693bda30d83c8c661936187e0a47";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/aelve/microlens";
          description = "A tiny lens library with no dependencies. If you're writing an app, you probably want microlens-platform, not this.";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      microlens-mtl = callPackage ({ base, microlens, mkDerivation, mtl, stdenv, transformers, transformers-compat }:
      mkDerivation {
          pname = "microlens-mtl";
          version = "0.1.11.0";
          sha256 = "4eba3fc8b776877cfcabc63418ee8307de274cc144792d70013bb3a7119b05a1";
          libraryHaskellDepends = [
            base
            microlens
            mtl
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/aelve/microlens";
          description = "microlens support for Reader/Writer/State from mtl";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      microlens-th = callPackage ({ base, containers, microlens, mkDerivation, stdenv, template-haskell }:
      mkDerivation {
          pname = "microlens-th";
          version = "0.4.1.1";
          sha256 = "5b1a400db8577805d80fb83963ef2a41cf43023b38300fdeaacb01a4fb526a7b";
          libraryHaskellDepends = [
            base
            containers
            microlens
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/aelve/microlens";
          description = "Automatic generation of record lenses for microlens";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      mime-types = callPackage ({ base, bytestring, containers, mkDerivation, stdenv, text }:
      mkDerivation {
          pname = "mime-types";
          version = "0.1.0.7";
          sha256 = "83164a24963a7ef37543349df095155b30116c208e602a159a5cd3722f66e9b9";
          libraryHaskellDepends = [
            base
            bytestring
            containers
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/yesodweb/wai";
          description = "Basic mime-type handling types and functions";
          license = stdenv.lib.licenses.mit;
        }) {};
      mintty = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "mintty";
          version = "0.1.1";
          sha256 = "c87f349f1999e8dee25f636428fc1742f50bcd2b51c9288578c60c58102e9f83";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/RyanGlScott/mintty";
          description = "A reliable way to detect the presence of a MinTTY console on Windows";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      mmorph = callPackage ({ base, mkDerivation, mtl, stdenv, transformers, transformers-compat }:
      mkDerivation {
          pname = "mmorph";
          version = "1.0.9";
          sha256 = "e1f27d3881b254e2a87ffb21f33e332404abb180361f9d29092a85e321554563";
          revision = "1";
          editedCabalFile = "1xxf78qi08qsis2q785s0ra29wjxnxw8pyns0dsqp4a6cybd3mjd";
          libraryHaskellDepends = [
            base
            mtl
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          description = "Monad morphisms";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      monad-control = callPackage ({ base, mkDerivation, stdenv, stm, transformers, transformers-base, transformers-compat }:
      mkDerivation {
          pname = "monad-control";
          version = "1.0.2.2";
          sha256 = "1e34a21d123f2ed8bb2708e7f30343fa1d9d7f36881f9871cbcca4bb07e7e433";
          libraryHaskellDepends = [
            base
            stm
            transformers
            transformers-base
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/basvandijk/monad-control";
          description = "Lift control operations, like exception catching, through monad transformers";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      monad-logger = callPackage ({ base, blaze-builder, bytestring, conduit, conduit-extra, exceptions, fast-logger, lifted-base, mkDerivation, monad-control, monad-loops, mtl, resourcet, stdenv, stm, stm-chans, template-haskell, text, transformers, transformers-base, transformers-compat }:
      mkDerivation {
          pname = "monad-logger";
          version = "0.3.25.1";
          sha256 = "40a45a482b70b1194f9490f8bf2175f5614f0348b43c21c1b0f91b53a276647b";
          libraryHaskellDepends = [
            base
            blaze-builder
            bytestring
            conduit
            conduit-extra
            exceptions
            fast-logger
            lifted-base
            monad-control
            monad-loops
            mtl
            resourcet
            stm
            stm-chans
            template-haskell
            text
            transformers
            transformers-base
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/kazu-yamamoto/logger";
          description = "A class of monads which can log messages";
          license = stdenv.lib.licenses.mit;
        }) {};
      monad-loops = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "monad-loops";
          version = "0.4.3";
          sha256 = "7eaaaf6bc43661e9e86e310ff8c56fbea16eb6bf13c31a2e28103138ac164c18";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/mokus0/monad-loops";
          description = "Monadic loops";
          license = stdenv.lib.licenses.publicDomain;
        }) {};
      monad-par = callPackage ({ abstract-deque, abstract-par, array, base, containers, deepseq, mkDerivation, monad-par-extras, mtl, mwc-random, parallel, stdenv }:
      mkDerivation {
          pname = "monad-par";
          version = "0.3.4.8";
          sha256 = "f84cdf51908a1c41c3f672be9520a8fdc028ea39d90a25ecfe5a3b223cfeb951";
          libraryHaskellDepends = [
            abstract-deque
            abstract-par
            array
            base
            containers
            deepseq
            monad-par-extras
            mtl
            mwc-random
            parallel
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/simonmar/monad-par";
          description = "A library for parallel programming based on a monad";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      monad-par-extras = callPackage ({ abstract-par, base, cereal, deepseq, mkDerivation, mtl, random, stdenv, transformers }:
      mkDerivation {
          pname = "monad-par-extras";
          version = "0.3.3";
          sha256 = "e21e33190bc248afa4ae467287ac37d24037ef3de6050c44fd85b52f4d5b842e";
          libraryHaskellDepends = [
            abstract-par
            base
            cereal
            deepseq
            mtl
            random
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/simonmar/monad-par";
          description = "Combinators and extra features for Par monads";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      mono-traversable = callPackage ({ base, bytestring, containers, hashable, mkDerivation, split, stdenv, text, transformers, unordered-containers, vector, vector-algorithms }:
      mkDerivation {
          pname = "mono-traversable";
          version = "1.0.4.0";
          sha256 = "23b83f6ff713ab464658166f6c0487a422a206ffc9912cd56f2abf229cfc9563";
          libraryHaskellDepends = [
            base
            bytestring
            containers
            hashable
            split
            text
            transformers
            unordered-containers
            vector
            vector-algorithms
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/snoyberg/mono-traversable";
          description = "Type classes for mapping, folding, and traversing monomorphic containers";
          license = stdenv.lib.licenses.mit;
        }) {};
      mtl = callPackage ({ base, mkDerivation, stdenv, transformers }:
      mkDerivation {
          pname = "mtl";
          version = "2.2.1";
          sha256 = "cae59d79f3a16f8e9f3c9adc1010c7c6cdddc73e8a97ff4305f6439d855c8dc5";
          revision = "1";
          editedCabalFile = "0fsa965g9h23mlfjzghmmhcb9dmaq8zpm374gby6iwgdx47q0njb";
          libraryHaskellDepends = [
            base
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/mtl";
          description = "Monad classes, using functional dependencies";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      mwc-random = callPackage ({ base, math-functions, mkDerivation, primitive, stdenv, time, vector }:
      mkDerivation {
          pname = "mwc-random";
          version = "0.13.6.0";
          sha256 = "065f334fc13c057eb03ef0b6aa3665ff193609d9bfcad8068bdd260801f44716";
          libraryHaskellDepends = [
            base
            math-functions
            primitive
            time
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/mwc-random";
          description = "Fast, high quality pseudo random number generation";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      nats = callPackage ({ mkDerivation, stdenv }:
      mkDerivation {
          pname = "nats";
          version = "1.1.1";
          sha256 = "131d1b4857cd1c0699ef60aeb41af923ee3e0ecd26ed1324c067d993bc17d4cd";
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/nats/";
          description = "Natural numbers";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      network = callPackage ({ base, bytestring, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "network";
          version = "2.6.3.2";
          sha256 = "354477074eaf2c0e134f4a7ae17694ffc747d484133463e95fae57ecbe48c0b6";
          revision = "1";
          editedCabalFile = "17234sy0vqic8g9wg8gmfmc0by50scjwbdk8bkcl9kjf3fvs4nyx";
          libraryHaskellDepends = [
            base
            bytestring
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/network";
          description = "Low-level networking interface";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      network-uri = callPackage ({ base, deepseq, mkDerivation, parsec, stdenv }:
      mkDerivation {
          pname = "network-uri";
          version = "2.6.1.0";
          sha256 = "423e0a2351236f3fcfd24e39cdbc38050ec2910f82245e69ca72a661f7fc47f0";
          revision = "1";
          editedCabalFile = "141nj7q0p9wkn5gr41ayc63cgaanr9m59yym47wpxqr3c334bk32";
          libraryHaskellDepends = [
            base
            deepseq
            parsec
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/network-uri";
          description = "URI manipulation";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      old-locale = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "old-locale";
          version = "1.0.0.7";
          sha256 = "dbaf8bf6b888fb98845705079296a23c3f40ee2f449df7312f7f7f1de18d7b50";
          revision = "2";
          editedCabalFile = "04b9vn007hlvsrx4ksd3r8r3kbyaj2kvwxchdrmd4370qzi8p6gs";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "locale library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      old-time = callPackage ({ base, mkDerivation, old-locale, stdenv }:
      mkDerivation {
          pname = "old-time";
          version = "1.1.0.3";
          sha256 = "1ccb158b0f7851715d36b757c523b026ca1541e2030d02239802ba39b4112bc1";
          revision = "2";
          editedCabalFile = "1j6ln1dkvhdvnwl33bp0xf9lhc4sybqk0aw42p8cq81xwwzbn7y9";
          libraryHaskellDepends = [
            base
            old-locale
          ];
          doHaddock = false;
          doCheck = false;
          description = "Time library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      open-browser = callPackage ({ base, mkDerivation, process, stdenv }:
      mkDerivation {
          pname = "open-browser";
          version = "0.2.1.0";
          sha256 = "0bed2e63800f738e78a4803ed22902accb50ac02068b96c17ce83a267244ca66";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            process
          ];
          executableHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/rightfold/open-browser";
          description = "Open a web browser from Haskell";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      optparse-applicative = callPackage ({ ansi-wl-pprint, base, mkDerivation, process, stdenv, transformers, transformers-compat }:
      mkDerivation {
          pname = "optparse-applicative";
          version = "0.13.2.0";
          sha256 = "5c83cfce7e53f4d3b1f5d53f082e7e61959bf14e6be704c698c3ab7f1b956ca2";
          libraryHaskellDepends = [
            ansi-wl-pprint
            base
            process
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/pcapriotti/optparse-applicative";
          description = "Utilities and combinators for parsing command line options";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      optparse-simple = callPackage ({ base, either, gitrev, mkDerivation, optparse-applicative, stdenv, template-haskell, transformers }:
      mkDerivation {
          pname = "optparse-simple";
          version = "0.0.4";
          sha256 = "a00f82ebc8c8976913f06d06c104e138d3037269a90b6f36ce8924f36923a2d5";
          libraryHaskellDepends = [
            base
            either
            gitrev
            optparse-applicative
            template-haskell
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          description = "Simple interface to optparse-applicative";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      parallel = callPackage ({ array, base, containers, deepseq, mkDerivation, stdenv }:
      mkDerivation {
          pname = "parallel";
          version = "3.2.1.1";
          sha256 = "323bb9bc9e36fb9bfb08e68a772411302b1599bfffbc6de20fa3437ce1473c17";
          libraryHaskellDepends = [
            array
            base
            containers
            deepseq
          ];
          doHaddock = false;
          doCheck = false;
          description = "Parallel programming library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      parsec = callPackage ({ base, bytestring, mkDerivation, mtl, stdenv, text }:
      mkDerivation {
          pname = "parsec";
          version = "3.1.11";
          sha256 = "6f87251cb1d11505e621274dec15972de924a9074f07f7430a18892064c2676e";
          libraryHaskellDepends = [
            base
            bytestring
            mtl
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/aslatter/parsec";
          description = "Monadic parser combinators";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      parsers = callPackage ({ Cabal, attoparsec, base, base-orphans, cabal-doctest, charset, containers, mkDerivation, mtl, parsec, scientific, semigroups, stdenv, text, transformers, unordered-containers }:
      mkDerivation {
          pname = "parsers";
          version = "0.12.7";
          sha256 = "65105b2fa169f6bb71dd0f8cbae15d916e8b6d9ee03e28ed5e8cf8e6017c4d0c";
          setupHaskellDepends = [
            base
            Cabal
            cabal-doctest
          ];
          libraryHaskellDepends = [
            attoparsec
            base
            base-orphans
            charset
            containers
            mtl
            parsec
            scientific
            semigroups
            text
            transformers
            unordered-containers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/parsers/";
          description = "Parsing combinators";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      path = callPackage ({ aeson, base, deepseq, exceptions, filepath, hashable, mkDerivation, stdenv, template-haskell }:
      mkDerivation {
          pname = "path";
          version = "0.6.1";
          sha256 = "4b8bd85a13395b4240c639b9cf804371854d5dac69158f661068bd3089a25e59";
          libraryHaskellDepends = [
            aeson
            base
            deepseq
            exceptions
            filepath
            hashable
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          description = "Support for well-typed paths";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      path-io = callPackage ({ base, containers, directory, dlist, exceptions, filepath, mkDerivation, path, stdenv, temporary, time, transformers, unix-compat }:
      mkDerivation {
          pname = "path-io";
          version = "1.3.3";
          sha256 = "2aec05914a7569f221cf73e25070fea5fad8125a9a93845e8d614a1c291e35bd";
          libraryHaskellDepends = [
            base
            containers
            directory
            dlist
            exceptions
            filepath
            path
            temporary
            time
            transformers
            unix-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/mrkkrp/path-io";
          description = "Interface to ‘directory’ package for users of ‘path’";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      path-pieces = callPackage ({ base, mkDerivation, stdenv, text, time }:
      mkDerivation {
          pname = "path-pieces";
          version = "0.2.1";
          sha256 = "080bd49f53e20597ca3e5962e0c279a3422345f5b088840a30a751cd76d4a36f";
          revision = "1";
          editedCabalFile = "0p7wsphh513s8l5d62lzgbhk2l1h6kj5y7bc27qqjsry9g8ah4y7";
          libraryHaskellDepends = [
            base
            text
            time
          ];
          doHaddock = false;
          doCheck = false;
          description = "Components of paths";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      pem = callPackage ({ base, base64-bytestring, bytestring, mkDerivation, mtl, stdenv }:
      mkDerivation {
          pname = "pem";
          version = "0.2.2";
          sha256 = "372808c76c6d860aedb4e30171cb4ee9f6154d9f68e3f2310f820bf174995a98";
          enableSeparateDataOutput = true;
          libraryHaskellDepends = [
            base
            base64-bytestring
            bytestring
            mtl
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-pem";
          description = "Privacy Enhanced Mail (PEM) format reader and writer";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      persistent = callPackage ({ aeson, attoparsec, base, base64-bytestring, blaze-html, blaze-markup, bytestring, conduit, containers, exceptions, fast-logger, http-api-data, lifted-base, mkDerivation, monad-control, monad-logger, mtl, old-locale, path-pieces, resource-pool, resourcet, scientific, silently, stdenv, tagged, template-haskell, text, time, transformers, transformers-base, unordered-containers, vector }:
      mkDerivation {
          pname = "persistent";
          version = "2.7.1";
          sha256 = "c2896ef228486c02c08b8594c9eccef8ca246291c4f16eff538fef9dc332391d";
          libraryHaskellDepends = [
            aeson
            attoparsec
            base
            base64-bytestring
            blaze-html
            blaze-markup
            bytestring
            conduit
            containers
            exceptions
            fast-logger
            http-api-data
            lifted-base
            monad-control
            monad-logger
            mtl
            old-locale
            path-pieces
            resource-pool
            resourcet
            scientific
            silently
            tagged
            template-haskell
            text
            time
            transformers
            transformers-base
            unordered-containers
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://www.yesodweb.com/book/persistent";
          description = "Type-safe, multi-backend data serialization";
          license = stdenv.lib.licenses.mit;
        }) {};
      persistent-sqlite = callPackage ({ aeson, base, bytestring, conduit, containers, microlens-th, mkDerivation, monad-control, monad-logger, old-locale, persistent, resource-pool, resourcet, stdenv, text, time, transformers, unordered-containers }:
      mkDerivation {
          pname = "persistent-sqlite";
          version = "2.6.3";
          sha256 = "34d97fe135a9f24234ba25ed22481cd71bbaea8395f64a273072e3c9cd46f271";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            aeson
            base
            bytestring
            conduit
            containers
            microlens-th
            monad-control
            monad-logger
            old-locale
            persistent
            resource-pool
            resourcet
            text
            time
            transformers
            unordered-containers
          ];
          executableHaskellDepends = [
            base
            monad-logger
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://www.yesodweb.com/book/persistent";
          description = "Backend for the persistent library using sqlite3";
          license = stdenv.lib.licenses.mit;
        }) {};
      persistent-template = callPackage ({ aeson, aeson-compat, base, bytestring, containers, ghc-prim, http-api-data, mkDerivation, monad-control, monad-logger, path-pieces, persistent, stdenv, tagged, template-haskell, text, transformers, unordered-containers }:
      mkDerivation {
          pname = "persistent-template";
          version = "2.5.3";
          sha256 = "9e95997d4d2e4e00ff1e77746d99064347a10b0ea418e46e7896c026684a16ad";
          libraryHaskellDepends = [
            aeson
            aeson-compat
            base
            bytestring
            containers
            ghc-prim
            http-api-data
            monad-control
            monad-logger
            path-pieces
            persistent
            tagged
            template-haskell
            text
            transformers
            unordered-containers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://www.yesodweb.com/book/persistent";
          description = "Type-safe, non-relational, multi-backend persistence";
          license = stdenv.lib.licenses.mit;
        }) {};
      pid1 = callPackage ({ base, directory, mkDerivation, process, stdenv, unix }:
      mkDerivation {
          pname = "pid1";
          version = "0.1.2.0";
          sha256 = "9e97bf9b4b6ffd6a9b706cc6d5fadd8089cd37d2b8763111bd743104db267f76";
          revision = "1";
          editedCabalFile = "11yg5pjci1d6p5ml0ic4vqn70vjx8vvhqs20rahgfqhh8palkyw9";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            directory
            process
            unix
          ];
          executableHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/fpco/pid1#readme";
          description = "Do signal handling and orphan reaping for Unix PID1 init processes";
          license = stdenv.lib.licenses.mit;
        }) {};
      prelude-extras = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "prelude-extras";
          version = "0.4.0.3";
          sha256 = "09bb087f0870a353ec1e7e1a08017b9a766d430d956afb88ca000a6a876bf877";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/prelude-extras";
          description = "Higher order versions of Prelude classes";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      primitive = callPackage ({ base, ghc-prim, mkDerivation, stdenv, transformers }:
      mkDerivation {
          pname = "primitive";
          version = "0.6.2.0";
          sha256 = "b8e8d70213e22b3fab0e0d11525c02627489618988fdc636052ca0adce282ae1";
          revision = "1";
          editedCabalFile = "0d61g8ppsdajdqykl2kc46kq00aamsf12v60ilgrf58dbji9sz56";
          libraryHaskellDepends = [
            base
            ghc-prim
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/primitive";
          description = "Primitive memory-related operations";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      profunctors = callPackage ({ base, base-orphans, bifunctors, comonad, contravariant, distributive, mkDerivation, stdenv, tagged, transformers }:
      mkDerivation {
          pname = "profunctors";
          version = "5.2.1";
          sha256 = "e7207e00dfa6f36d9f84568b1aa4b3bd2077f5fced387cd6cf75b411d0959c5d";
          libraryHaskellDepends = [
            base
            base-orphans
            bifunctors
            comonad
            contravariant
            distributive
            tagged
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/profunctors/";
          description = "Profunctors";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      project-template = callPackage ({ base, base64-bytestring, bytestring, conduit, conduit-extra, containers, directory, filepath, mkDerivation, mtl, resourcet, stdenv, text, transformers }:
      mkDerivation {
          pname = "project-template";
          version = "0.2.0";
          sha256 = "aeabd7d1785b31abaffc78f02d9dda67d57d01822755f09614bfc65e99506310";
          libraryHaskellDepends = [
            base
            base64-bytestring
            bytestring
            conduit
            conduit-extra
            containers
            directory
            filepath
            mtl
            resourcet
            text
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/fpco/haskell-ide";
          description = "Specify Haskell project templates and generate files";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      quickcheck-io = callPackage ({ HUnit, QuickCheck, base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "quickcheck-io";
          version = "0.2.0";
          sha256 = "fb779119d79fe08ff4d502fb6869a70c9a8d5fd8ae0959f605c3c937efd96422";
          libraryHaskellDepends = [
            base
            HUnit
            QuickCheck
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/hspec/quickcheck-io#readme";
          description = "Use HUnit assertions as QuickCheck properties";
          license = stdenv.lib.licenses.mit;
        }) {};
      random = callPackage ({ base, mkDerivation, stdenv, time }:
      mkDerivation {
          pname = "random";
          version = "1.1";
          sha256 = "b718a41057e25a3a71df693ab0fe2263d492e759679b3c2fea6ea33b171d3a5a";
          revision = "1";
          editedCabalFile = "1pv5d7bm2rgap7llp5vjsplrg048gvf0226y0v19gpvdsx7n4rvv";
          libraryHaskellDepends = [
            base
            time
          ];
          doHaddock = false;
          doCheck = false;
          description = "random number library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      reducers = callPackage ({ array, base, bytestring, containers, fingertree, hashable, mkDerivation, semigroupoids, semigroups, stdenv, text, transformers, unordered-containers }:
      mkDerivation {
          pname = "reducers";
          version = "3.12.2";
          sha256 = "c5d03608b7217e8690a884014dfe03dc4c882ac1a481c5e85c76af4f7a516abd";
          libraryHaskellDepends = [
            array
            base
            bytestring
            containers
            fingertree
            hashable
            semigroupoids
            semigroups
            text
            transformers
            unordered-containers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/reducers/";
          description = "Semigroups, specialized containers and a general map/reduce framework";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      reflection = callPackage ({ base, mkDerivation, stdenv, template-haskell }:
      mkDerivation {
          pname = "reflection";
          version = "2.1.2";
          sha256 = "a909882c04b24016bedb85587c09f23cf06bad71a2b1f7e781e89abaa6023c39";
          libraryHaskellDepends = [
            base
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/reflection";
          description = "Reifies arbitrary terms into types that can be reflected back into terms";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      regex-applicative = callPackage ({ base, containers, mkDerivation, stdenv, transformers }:
      mkDerivation {
          pname = "regex-applicative";
          version = "0.3.3";
          sha256 = "6659a2cc1c8137d77ef57f75027723b075d473354d935233d98b1ae1b03c3be6";
          libraryHaskellDepends = [
            base
            containers
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/feuerbach/regex-applicative";
          description = "Regex-based parsing with applicative interface";
          license = stdenv.lib.licenses.mit;
        }) {};
      regex-applicative-text = callPackage ({ base, mkDerivation, regex-applicative, stdenv, text }:
      mkDerivation {
          pname = "regex-applicative-text";
          version = "0.1.0.1";
          sha256 = "b093051f80865d257da2ded8ad1b566927b01b3d2f86d41da2ffee4a26c4e2d9";
          revision = "1";
          editedCabalFile = "1w8aqqq6j1lhwpi2d0qj9h32cia3nr9l43a0mspqawb1nsmpjyic";
          libraryHaskellDepends = [
            base
            regex-applicative
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/phadej/regex-applicative-text#readme";
          description = "regex-applicative on text";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      regex-base = callPackage ({ array, base, bytestring, containers, mkDerivation, mtl, stdenv }:
      mkDerivation {
          pname = "regex-base";
          version = "0.93.2";
          sha256 = "20dc5713a16f3d5e2e6d056b4beb9cfdc4368cd09fd56f47414c847705243278";
          libraryHaskellDepends = [
            array
            base
            bytestring
            containers
            mtl
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://sourceforge.net/projects/lazy-regex";
          description = "Replaces/Enhances Text.Regex";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      regex-pcre = callPackage ({ array, base, bytestring, containers, mkDerivation, pcre, regex-base, stdenv }:
      mkDerivation {
          pname = "regex-pcre";
          version = "0.94.4";
          sha256 = "8eaa7d4ac6c0a4ba35aa59fc3f6b8f8e252bb25a47e136791446a74752e226c0";
          libraryHaskellDepends = [
            array
            base
            bytestring
            containers
            regex-base
          ];
          librarySystemDepends = [ pcre ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://hackage.haskell.org/package/regex-pcre";
          description = "Replaces/Enhances Text.Regex";
          license = stdenv.lib.licenses.bsd3;
        }) { pcre = pkgs.pcre; };
      resource-pool = callPackage ({ base, hashable, mkDerivation, monad-control, stdenv, stm, time, transformers, transformers-base, vector }:
      mkDerivation {
          pname = "resource-pool";
          version = "0.2.3.2";
          sha256 = "8627eea2bea8824af2723646e74e2af0c73f583dd0c496c9fd242cd9d242bc12";
          libraryHaskellDepends = [
            base
            hashable
            monad-control
            stm
            time
            transformers
            transformers-base
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/bos/pool";
          description = "A high-performance striped resource pooling implementation";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      resourcet = callPackage ({ base, containers, exceptions, lifted-base, mkDerivation, mmorph, monad-control, mtl, stdenv, transformers, transformers-base, transformers-compat }:
      mkDerivation {
          pname = "resourcet";
          version = "1.1.9";
          sha256 = "5a1999d26b896603cab8121b77f36723dc50960291872b691ff4a9533e162ef5";
          libraryHaskellDepends = [
            base
            containers
            exceptions
            lifted-base
            mmorph
            monad-control
            mtl
            transformers
            transformers-base
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/snoyberg/conduit";
          description = "Deterministic allocation and freeing of scarce resources";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      retry = callPackage ({ base, data-default-class, exceptions, ghc-prim, mkDerivation, random, stdenv, transformers }:
      mkDerivation {
          pname = "retry";
          version = "0.7.4.3";
          sha256 = "208d06809b7e774e3a7c515d2bbe2edceb07898079722c1c77007c49697d8744";
          libraryHaskellDepends = [
            base
            data-default-class
            exceptions
            ghc-prim
            random
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/Soostone/retry";
          description = "Retry combinators for monadic actions that may fail";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      safe = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "safe";
          version = "0.3.15";
          sha256 = "a35e4ae609aabd568da7e7d220ab529c34040b71ae50df1ee353896445a66a2d";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/ndmitchell/safe#readme";
          description = "Library of safe (exception free) functions";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      scientific = callPackage ({ base, binary, bytestring, containers, deepseq, hashable, integer-gmp, integer-logarithms, mkDerivation, primitive, stdenv, text }:
      mkDerivation {
          pname = "scientific";
          version = "0.3.5.2";
          sha256 = "5ce479ff95482fb907267516bd0f8fff450bdeea546bbd1267fe035acf975657";
          revision = "2";
          editedCabalFile = "0wsrd213480p3pqrd6i650fr092yv7dhla7a85p8154pn5gvbr0a";
          libraryHaskellDepends = [
            base
            binary
            bytestring
            containers
            deepseq
            hashable
            integer-gmp
            integer-logarithms
            primitive
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/basvandijk/scientific";
          description = "Numbers represented using scientific notation";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      semigroupoids = callPackage ({ Cabal, base, base-orphans, bifunctors, cabal-doctest, comonad, containers, contravariant, distributive, hashable, mkDerivation, semigroups, stdenv, tagged, transformers, transformers-compat, unordered-containers }:
      mkDerivation {
          pname = "semigroupoids";
          version = "5.2.1";
          sha256 = "79e41eb7cbcb4f152343b91243feac0a120375284c1207edaa73b23d8df6d200";
          revision = "3";
          editedCabalFile = "0wzcnpz8pyjk823vqnq5s8krsb8i6cw573hcschpd9x5ynq4li70";
          setupHaskellDepends = [
            base
            Cabal
            cabal-doctest
          ];
          libraryHaskellDepends = [
            base
            base-orphans
            bifunctors
            comonad
            containers
            contravariant
            distributive
            hashable
            semigroups
            tagged
            transformers
            transformers-compat
            unordered-containers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/semigroupoids";
          description = "Semigroupoids: Category sans id";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      semigroups = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "semigroups";
          version = "0.18.3";
          sha256 = "35297c986872406e2efe29620c623727369f8c578e2f9c22998d575996e5a9ca";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/semigroups/";
          description = "Anything that associates";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      setenv = callPackage ({ base, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "setenv";
          version = "0.1.1.3";
          sha256 = "e358df39afc03d5a39e2ec650652d845c85c80cc98fe331654deafb4767ecb32";
          revision = "1";
          editedCabalFile = "0ny4g3kjys0hqg41mnwrsymy1bwhl8l169kis4y4fa58sb06m4f5";
          libraryHaskellDepends = [
            base
            unix
          ];
          doHaddock = false;
          doCheck = false;
          description = "A cross-platform library for setting environment variables";
          license = stdenv.lib.licenses.mit;
        }) {};
      silently = callPackage ({ base, deepseq, directory, mkDerivation, stdenv }:
      mkDerivation {
          pname = "silently";
          version = "1.2.5";
          sha256 = "cef625635053a46032ca53b43d311921875a437910b6568ded17027fdca83839";
          libraryHaskellDepends = [
            base
            deepseq
            directory
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/hspec/silently";
          description = "Prevent or capture writing to stdout and other handles";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      smallcheck = callPackage ({ base, ghc-prim, logict, mkDerivation, mtl, pretty, stdenv }:
      mkDerivation {
          pname = "smallcheck";
          version = "1.1.2";
          sha256 = "55f621bc489132e66db8087af1257c57d759ef0213a361384c09c741a102c990";
          libraryHaskellDepends = [
            base
            ghc-prim
            logict
            mtl
            pretty
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/feuerbach/smallcheck";
          description = "A property-based testing library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      socks = callPackage ({ base, bytestring, cereal, mkDerivation, network, stdenv }:
      mkDerivation {
          pname = "socks";
          version = "0.5.5";
          sha256 = "2647ea93e21ad1dfd77e942c022c8707e468d25e1ff672a88be82508034fc868";
          revision = "1";
          editedCabalFile = "0nz8q0xvd8y6f42bd1w3q8d8bg1qzl8ggx0a23kb3jb60g36dmvw";
          libraryHaskellDepends = [
            base
            bytestring
            cereal
            network
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-socks";
          description = "Socks proxy (version 5) implementation";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      split = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "split";
          version = "0.2.3.2";
          sha256 = "4943eaad0dd473d44b4b97b8b9731c20f05ba86abb8a1fa07f8df819f09eb63a";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "Combinator library for splitting lists";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      stack = callPackage ({ Cabal, aeson, annotated-wl-pprint, ansi-terminal, attoparsec, base, base64-bytestring, bindings-uname, blaze-builder, bytestring, clock, conduit, conduit-extra, containers, cryptonite, cryptonite-conduit, deepseq, directory, echo, exceptions, extra, fast-logger, fetchgit, file-embed, filelock, filepath, fsnotify, generic-deriving, gitrev, hackage-security, hashable, hastache, hpack, hpc, http-client, http-client-tls, http-conduit, http-types, memory, microlens, microlens-mtl, mintty, mkDerivation, monad-logger, mtl, network-uri, open-browser, optparse-applicative, optparse-simple, path, path-io, persistent, persistent-sqlite, persistent-template, pid1, pretty, primitive, process, project-template, regex-applicative-text, resourcet, retry, semigroups, split, stdenv, stm, store, store-core, streaming-commons, tar, template-haskell, text, text-metrics, time, tls, transformers, unicode-transforms, unix, unix-compat, unliftio, unordered-containers, vector, yaml, zip-archive, zlib }:
      mkDerivation {
          pname = "stack";
          version = "1.6.0.20171022";
          src = fetchgit {
            url = "https://github.com/commercialhaskell/stack.git";
            sha256 = "0k5h807y8h2y1gjslmcdhdmlippa7219mzxydxsyhfgmhkbcq8qw";
            rev = "7bddfaf7f9f8cd9ec1c710fa83e77262e494eee4";
          };
          isLibrary = true;
          isExecutable = true;
          setupHaskellDepends = [
            base
            Cabal
            filepath
          ];
          libraryHaskellDepends = [
            aeson
            annotated-wl-pprint
            ansi-terminal
            attoparsec
            base
            base64-bytestring
            bindings-uname
            blaze-builder
            bytestring
            Cabal
            clock
            conduit
            conduit-extra
            containers
            cryptonite
            cryptonite-conduit
            deepseq
            directory
            echo
            exceptions
            extra
            fast-logger
            file-embed
            filelock
            filepath
            fsnotify
            generic-deriving
            hackage-security
            hashable
            hastache
            hpack
            hpc
            http-client
            http-client-tls
            http-conduit
            http-types
            memory
            microlens
            microlens-mtl
            mintty
            monad-logger
            mtl
            network-uri
            open-browser
            optparse-applicative
            path
            path-io
            persistent
            persistent-sqlite
            persistent-template
            pid1
            pretty
            primitive
            process
            project-template
            regex-applicative-text
            resourcet
            retry
            semigroups
            split
            stm
            store
            store-core
            streaming-commons
            tar
            template-haskell
            text
            text-metrics
            time
            tls
            transformers
            unicode-transforms
            unix
            unix-compat
            unliftio
            unordered-containers
            vector
            yaml
            zip-archive
            zlib
          ];
          executableHaskellDepends = [
            base
            bytestring
            Cabal
            conduit
            containers
            directory
            filelock
            filepath
            gitrev
            hpack
            http-client
            microlens
            monad-logger
            mtl
            optparse-applicative
            optparse-simple
            path
            path-io
            split
            text
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          preCheck = "export HOME=\$TMPDIR";
          postInstall = ''
            exe=''$out/bin/stack
            mkdir -p ''$out/share/bash-completion/completions
            ''$exe --bash-completion-script ''$exe >''$out/share/bash-completion/completions/stack
          '';
          homepage = "http://haskellstack.org";
          description = "The Haskell Tool Stack";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      stack2nix = callPackage ({ Cabal, Glob, SafeSemaphore, async, base, cabal2nix, containers, data-fix, directory, distribution-nixpkgs, filepath, hnix, mkDerivation, optparse-applicative, path, process, regex-pcre, stack, stdenv, temporary, text, time }:
      mkDerivation {
          pname = "stack2nix";
          version = "0.1.3.1";
          src = ./.;
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            async
            base
            Cabal
            cabal2nix
            containers
            data-fix
            directory
            distribution-nixpkgs
            filepath
            Glob
            hnix
            optparse-applicative
            path
            process
            regex-pcre
            SafeSemaphore
            stack
            temporary
            text
            time
          ];
          executableHaskellDepends = [
            base
            Cabal
            optparse-applicative
            time
          ];
          doHaddock = false;
          doCheck = false;
          description = "Convert stack.yaml files into Nix build instructions.";
          license = stdenv.lib.licenses.mit;
        }) {};
      stm = callPackage ({ array, base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "stm";
          version = "2.4.4.1";
          sha256 = "8f999095ed8d50d2056fc6e185035ee8166c50751e1af8de02ac38d382bf3384";
          revision = "1";
          editedCabalFile = "0kzw4rw9fgmc4qyxmm1lwifdyrx5r1356150xm14vy4mp86diks9";
          libraryHaskellDepends = [
            array
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "Software Transactional Memory";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      stm-chans = callPackage ({ base, mkDerivation, stdenv, stm }:
      mkDerivation {
          pname = "stm-chans";
          version = "3.0.0.4";
          sha256 = "2344fc5bfa33d565bad7b009fc0e2c5a7a595060ba149c661f44419fc0d54738";
          libraryHaskellDepends = [
            base
            stm
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://code.haskell.org/~wren/";
          description = "Additional types of channels for STM";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      store = callPackage ({ array, async, base, base-orphans, base64-bytestring, bytestring, conduit, containers, contravariant, cryptohash, deepseq, directory, filepath, free, ghc-prim, hashable, hspec, hspec-smallcheck, integer-gmp, lifted-base, mkDerivation, monad-control, mono-traversable, network, primitive, resourcet, safe, semigroups, smallcheck, stdenv, store-core, streaming-commons, syb, template-haskell, text, th-lift, th-lift-instances, th-orphans, th-reify-many, th-utilities, time, transformers, unordered-containers, vector, void }:
      mkDerivation {
          pname = "store";
          version = "0.4.3.2";
          sha256 = "eca47c14b14ce5a6369a4b09a048b5a7fe7574d3f1b1099bc03449416c80308e";
          libraryHaskellDepends = [
            array
            async
            base
            base-orphans
            base64-bytestring
            bytestring
            conduit
            containers
            contravariant
            cryptohash
            deepseq
            directory
            filepath
            free
            ghc-prim
            hashable
            hspec
            hspec-smallcheck
            integer-gmp
            lifted-base
            monad-control
            mono-traversable
            network
            primitive
            resourcet
            safe
            semigroups
            smallcheck
            store-core
            streaming-commons
            syb
            template-haskell
            text
            th-lift
            th-lift-instances
            th-orphans
            th-reify-many
            th-utilities
            time
            transformers
            unordered-containers
            vector
            void
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/fpco/store#readme";
          description = "Fast binary serialization";
          license = stdenv.lib.licenses.mit;
        }) {};
      store-core = callPackage ({ base, bytestring, fail, ghc-prim, mkDerivation, primitive, stdenv, text, transformers }:
      mkDerivation {
          pname = "store-core";
          version = "0.4.1";
          sha256 = "145285f9f26a64e9611e01749a0d569691a70fa898f5359bedcfca9dacb064b4";
          libraryHaskellDepends = [
            base
            bytestring
            fail
            ghc-prim
            primitive
            text
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/fpco/store#readme";
          description = "Fast and lightweight binary serialization";
          license = stdenv.lib.licenses.mit;
        }) {};
      streaming-commons = callPackage ({ array, async, base, blaze-builder, bytestring, directory, mkDerivation, network, process, random, stdenv, stm, text, transformers, unix, zlib }:
      mkDerivation {
          pname = "streaming-commons";
          version = "0.1.17";
          sha256 = "e50a38cb8b626ef2f031c195e22171ffce00e20cbe63e8c768887564a7f47da9";
          libraryHaskellDepends = [
            array
            async
            base
            blaze-builder
            bytestring
            directory
            network
            process
            random
            stm
            text
            transformers
            unix
            zlib
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/fpco/streaming-commons";
          description = "Common lower-level functions needed by various streaming data libraries";
          license = stdenv.lib.licenses.mit;
        }) {};
      stringbuilder = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "stringbuilder";
          version = "0.5.0";
          sha256 = "8966882622fc06fd4e588da626a558b54daa313f2328c188d9305b0c6f2fe9aa";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "A writer monad for multi-line string literals";
          license = stdenv.lib.licenses.mit;
        }) {};
      syb = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "syb";
          version = "0.7";
          sha256 = "b8757dce5ab4045c49a0ae90407d575b87ee5523a7dd5dfa5c9d54fcceff42b5";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://www.cs.uu.nl/wiki/GenericProgramming/SYB";
          description = "Scrap Your Boilerplate";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      tagged = callPackage ({ base, deepseq, mkDerivation, stdenv, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "tagged";
          version = "0.8.5";
          sha256 = "e47c51c955ed77b0fa36897f652df990aa0a8c4eb278efaddcd604be00fc8d99";
          revision = "1";
          editedCabalFile = "15mqdimbgrq5brqljjl7dbxkyrxppap06q53cp7ml7w3l08v5mx8";
          libraryHaskellDepends = [
            base
            deepseq
            template-haskell
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/tagged";
          description = "Haskell 98 phantom types to avoid unsafely passing dummy arguments";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      tar = callPackage ({ array, base, bytestring, containers, deepseq, directory, filepath, mkDerivation, stdenv, time }:
      mkDerivation {
          pname = "tar";
          version = "0.5.0.3";
          sha256 = "d8d9ad876365f88bdccd02073049e58715cd5ba94de06eb98e21d595244918a3";
          libraryHaskellDepends = [
            array
            base
            bytestring
            containers
            deepseq
            directory
            filepath
            time
          ];
          doHaddock = false;
          doCheck = false;
          description = "Reading, writing and manipulating \".tar\" archive files.";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      temporary = callPackage ({ base, directory, exceptions, filepath, mkDerivation, stdenv, transformers, unix }:
      mkDerivation {
          pname = "temporary";
          version = "1.2.1.1";
          sha256 = "55772471e59529f4bde9555f6abb21d19a611c7d70b13befe114dc1a0ecb00f3";
          libraryHaskellDepends = [
            base
            directory
            exceptions
            filepath
            transformers
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/feuerbach/temporary";
          description = "Portable temporary file and directory support";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      text = callPackage ({ array, base, binary, bytestring, deepseq, ghc-prim, integer-gmp, mkDerivation, stdenv }:
      mkDerivation {
          pname = "text";
          version = "1.2.2.2";
          sha256 = "31465106360a7d7e214d96f1d1b4303a113ffce1bde44a4e614053a1e5072df9";
          libraryHaskellDepends = [
            array
            base
            binary
            bytestring
            deepseq
            ghc-prim
            integer-gmp
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/text";
          description = "An efficient packed Unicode text type";
          license = stdenv.lib.licenses.bsd2;
        }) {};
      text-metrics = callPackage ({ base, containers, mkDerivation, stdenv, text, vector }:
      mkDerivation {
          pname = "text-metrics";
          version = "0.3.0";
          sha256 = "3874af74060e35f01702640b353ac2180d93bb5d292a204e0ee3cadd26efbfa2";
          libraryHaskellDepends = [
            base
            containers
            text
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/mrkkrp/text-metrics";
          description = "Calculate various string metrics efficiently";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      tf-random = callPackage ({ base, mkDerivation, primitive, random, stdenv, time }:
      mkDerivation {
          pname = "tf-random";
          version = "0.5";
          sha256 = "2e30cec027b313c9e1794d326635d8fc5f79b6bf6e7580ab4b00186dadc88510";
          libraryHaskellDepends = [
            base
            primitive
            random
            time
          ];
          doHaddock = false;
          doCheck = false;
          description = "High-quality splittable pseudorandom number generator";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      th-abstraction = callPackage ({ base, containers, ghc-prim, mkDerivation, stdenv, template-haskell }:
      mkDerivation {
          pname = "th-abstraction";
          version = "0.2.6.0";
          sha256 = "e52e289a547d68f203d65f2e63ec2d87a3c613007d2fe873615c0969b981823c";
          libraryHaskellDepends = [
            base
            containers
            ghc-prim
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/glguy/th-abstraction";
          description = "Nicer interface for reified information about data types";
          license = stdenv.lib.licenses.isc;
        }) {};
      th-expand-syns = callPackage ({ base, containers, mkDerivation, stdenv, syb, template-haskell }:
      mkDerivation {
          pname = "th-expand-syns";
          version = "0.4.3.0";
          sha256 = "9fee68a387610574ed6445022fdcd0879a7415d910dcb6618f1de5d2001e679d";
          libraryHaskellDepends = [
            base
            containers
            syb
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/DanielSchuessler/th-expand-syns";
          description = "Expands type synonyms in Template Haskell ASTs";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      th-lift = callPackage ({ base, ghc-prim, mkDerivation, stdenv, template-haskell }:
      mkDerivation {
          pname = "th-lift";
          version = "0.7.7";
          sha256 = "16c6fa6fbe972fa0d850698c147cd9a30dc0e201554d9a4ee9ade62dc807cbb5";
          libraryHaskellDepends = [
            base
            ghc-prim
            template-haskell
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/mboes/th-lift";
          description = "Derive Template Haskell's Lift class for datatypes";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      th-lift-instances = callPackage ({ base, bytestring, containers, mkDerivation, stdenv, template-haskell, text, th-lift, vector }:
      mkDerivation {
          pname = "th-lift-instances";
          version = "0.1.11";
          sha256 = "1da46afabdc73c86f279a0557d5a8f9af1296f9f6043264ba354b1c9cc65a6b8";
          libraryHaskellDepends = [
            base
            bytestring
            containers
            template-haskell
            text
            th-lift
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/bennofs/th-lift-instances/";
          description = "Lift instances for template-haskell for common data types";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      th-orphans = callPackage ({ base, mkDerivation, mtl, stdenv, template-haskell, th-lift, th-lift-instances, th-reify-many }:
      mkDerivation {
          pname = "th-orphans";
          version = "0.13.4";
          sha256 = "f395d9efa0ed105659cdcc8a1b89ae9db62f4bd3a042794ab882c4e82b344b31";
          libraryHaskellDepends = [
            base
            mtl
            template-haskell
            th-lift
            th-lift-instances
            th-reify-many
          ];
          doHaddock = false;
          doCheck = false;
          description = "Orphan instances for TH datatypes";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      th-reify-many = callPackage ({ base, containers, mkDerivation, mtl, safe, stdenv, template-haskell, th-expand-syns }:
      mkDerivation {
          pname = "th-reify-many";
          version = "0.1.8";
          sha256 = "cecaae187df911de515d08929e1394d6d6f7ce129795be8189a6b10d3734fe43";
          libraryHaskellDepends = [
            base
            containers
            mtl
            safe
            template-haskell
            th-expand-syns
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/mgsloan/th-reify-many";
          description = "Recurseively reify template haskell datatype info";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      th-utilities = callPackage ({ base, bytestring, containers, directory, filepath, mkDerivation, primitive, stdenv, syb, template-haskell, text, th-orphans }:
      mkDerivation {
          pname = "th-utilities";
          version = "0.2.0.1";
          sha256 = "65c64cee69c0d9bf8d0d5d4590aaea7dcf4177f97818526cbb3fac20901671d6";
          libraryHaskellDepends = [
            base
            bytestring
            containers
            directory
            filepath
            primitive
            syb
            template-haskell
            text
            th-orphans
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/fpco/th-utilities#readme";
          description = "Collection of useful functions for use with Template Haskell";
          license = stdenv.lib.licenses.mit;
        }) {};
      time-locale-compat = callPackage ({ base, mkDerivation, old-locale, stdenv, time }:
      mkDerivation {
          pname = "time-locale-compat";
          version = "0.1.1.3";
          sha256 = "9144bf68b47791a2ac73f45aeadbc5910be2da9ad174909e1a10a70b4576aced";
          libraryHaskellDepends = [
            base
            old-locale
            time
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/khibino/haskell-time-locale-compat";
          description = "Compatibility of TimeLocale between old-locale and time-1.5";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      tls = callPackage ({ asn1-encoding, asn1-types, async, base, bytestring, cereal, cryptonite, data-default-class, memory, mkDerivation, mtl, network, stdenv, transformers, x509, x509-store, x509-validation }:
      mkDerivation {
          pname = "tls";
          version = "1.3.11";
          sha256 = "3f008eb942874f8114f9a332f9669c44d72825ba39ce0fad89f0f8dfa6fb2703";
          libraryHaskellDepends = [
            asn1-encoding
            asn1-types
            async
            base
            bytestring
            cereal
            cryptonite
            data-default-class
            memory
            mtl
            network
            transformers
            x509
            x509-store
            x509-validation
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-tls";
          description = "TLS/SSL protocol native implementation (Server and Client)";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      transformers-base = callPackage ({ base, mkDerivation, stdenv, stm, transformers, transformers-compat }:
      mkDerivation {
          pname = "transformers-base";
          version = "0.4.4";
          sha256 = "6aa3494fc70659342fbbb163035d5827ecfd8079e3c929e2372adf771fd52387";
          revision = "1";
          editedCabalFile = "196pr3a4lhgklyw6nq6rv1j9djwzmvx7xrpp58carxnb55gk06pv";
          libraryHaskellDepends = [
            base
            stm
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/mvv/transformers-base";
          description = "Lift computations from the bottom of a transformer stack";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      transformers-compat = callPackage ({ base, ghc-prim, mkDerivation, stdenv, transformers }:
      mkDerivation {
          pname = "transformers-compat";
          version = "0.5.1.4";
          sha256 = "d881ef4ec164b631591b222efe7ff555af6d5397c9d86475b309ba9402a8ca9f";
          libraryHaskellDepends = [
            base
            ghc-prim
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/transformers-compat/";
          description = "A small compatibility shim exposing the new types from transformers 0.3 and 0.4 to older Haskell platforms.";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      trifecta = callPackage ({ ansi-terminal, ansi-wl-pprint, array, base, blaze-builder, blaze-html, blaze-markup, bytestring, charset, comonad, containers, deepseq, fingertree, ghc-prim, hashable, lens, mkDerivation, mtl, parsers, profunctors, reducers, semigroups, stdenv, transformers, unordered-containers, utf8-string }:
      mkDerivation {
          pname = "trifecta";
          version = "1.6.2.1";
          sha256 = "bab3724de8ed4f5283deb99013debf2e223e9e2c3c975e7d9b9bd44a9b30fbe5";
          revision = "1";
          editedCabalFile = "0qy2nqxn2h20fp9gf5chvgimb2281pjwm075ap7ar7pk2k4n8ljr";
          libraryHaskellDepends = [
            ansi-terminal
            ansi-wl-pprint
            array
            base
            blaze-builder
            blaze-html
            blaze-markup
            bytestring
            charset
            comonad
            containers
            deepseq
            fingertree
            ghc-prim
            hashable
            lens
            mtl
            parsers
            profunctors
            reducers
            semigroups
            transformers
            unordered-containers
            utf8-string
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/trifecta/";
          description = "A modern parser combinator library with convenient diagnostics";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      unicode-transforms = callPackage ({ base, bitarray, bytestring, mkDerivation, stdenv, text }:
      mkDerivation {
          pname = "unicode-transforms";
          version = "0.3.3";
          sha256 = "59748accedb5d8eacf787781c681371ae5fae0955acc38783aa2a7af6133ea11";
          libraryHaskellDepends = [
            base
            bitarray
            bytestring
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/harendra-kumar/unicode-transforms";
          description = "Unicode normalization";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      unix-compat = callPackage ({ base, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "unix-compat";
          version = "0.4.3.1";
          sha256 = "72801d5a654a6e108c153f412ebd54c37fb445643770e0b97701a59e109f7e27";
          revision = "2";
          editedCabalFile = "0b5jicn8nm53yxxzwlvfcv4xp5rrqp98x5wwqh234wn9x44z54d2";
          libraryHaskellDepends = [
            base
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/jystic/unix-compat";
          description = "Portable POSIX-compatibility layer";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      unix-time = callPackage ({ base, binary, bytestring, mkDerivation, old-time, stdenv }:
      mkDerivation {
          pname = "unix-time";
          version = "0.3.7";
          sha256 = "1131301131dd3e73353a346daa04578ec067073e7674d447051ac1a87262b4e1";
          libraryHaskellDepends = [
            base
            binary
            bytestring
            old-time
          ];
          doHaddock = false;
          doCheck = false;
          description = "Unix time parser/formatter and utilities";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      unliftio = callPackage ({ async, base, deepseq, directory, filepath, mkDerivation, monad-logger, resourcet, stdenv, transformers, unix, unliftio-core }:
      mkDerivation {
          pname = "unliftio";
          version = "0.1.1.0";
          sha256 = "6dce1c8fb65c2cfaa3e30fd302f9cc8675d174e666628813ed0624e8766718c2";
          libraryHaskellDepends = [
            async
            base
            deepseq
            directory
            filepath
            monad-logger
            resourcet
            transformers
            unix
            unliftio-core
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/fpco/unliftio/tree/master/unliftio#readme";
          description = "The MonadUnliftIO typeclass for unlifting monads to IO (batteries included)";
          license = stdenv.lib.licenses.mit;
        }) {};
      unliftio-core = callPackage ({ base, mkDerivation, stdenv, transformers }:
      mkDerivation {
          pname = "unliftio-core";
          version = "0.1.0.0";
          sha256 = "92b9f2bdc921df134231f770fcab750cbeed08a89c9ed08b13db5d1e9236bb73";
          libraryHaskellDepends = [
            base
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/fpco/monad-unlift/tree/master/unliftio-core#readme";
          description = "The MonadUnliftIO typeclass for unlifting monads to IO";
          license = stdenv.lib.licenses.mit;
        }) {};
      unordered-containers = callPackage ({ base, deepseq, hashable, mkDerivation, stdenv }:
      mkDerivation {
          pname = "unordered-containers";
          version = "0.2.8.0";
          sha256 = "a4a188359ff28640359131061953f7dbb8258da8ecf0542db0d23f08bfa6eea8";
          libraryHaskellDepends = [
            base
            deepseq
            hashable
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/tibbe/unordered-containers";
          description = "Efficient hashing-based container types";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      uri-bytestring = callPackage ({ attoparsec, base, blaze-builder, bytestring, containers, mkDerivation, stdenv, template-haskell, th-lift-instances }:
      mkDerivation {
          pname = "uri-bytestring";
          version = "0.2.3.3";
          sha256 = "3d838bf247e95a66885d2d603c1594ef01d4dade728aa50b6c2224a65d8d0b14";
          libraryHaskellDepends = [
            attoparsec
            base
            blaze-builder
            bytestring
            containers
            template-haskell
            th-lift-instances
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/Soostone/uri-bytestring";
          description = "Haskell URI parsing as ByteStrings";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      utf8-string = callPackage ({ base, bytestring, mkDerivation, stdenv }:
      mkDerivation {
          pname = "utf8-string";
          version = "1.0.1.1";
          sha256 = "fb0b9e3acbe0605bcd1c63e51f290a7bbbe6628dfa3294ff453e4235fbaef140";
          revision = "2";
          editedCabalFile = "1b97s9picjl689hcz8scinv7c8k5iaal1livqr0l1l8yc4h0imhr";
          libraryHaskellDepends = [
            base
            bytestring
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/glguy/utf8-string/";
          description = "Support for reading and writing UTF8 Strings";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      uuid-types = callPackage ({ base, binary, bytestring, deepseq, hashable, mkDerivation, random, stdenv, text }:
      mkDerivation {
          pname = "uuid-types";
          version = "1.0.3";
          sha256 = "9276517ab24a9b06f39d6e3c33c6c2b4ace1fc2126dbc1cd9806866a6551b3fd";
          revision = "1";
          editedCabalFile = "0iwwj07gp28g357hv76k4h8pvlzamvchnw003cv3qk778pcpx201";
          libraryHaskellDepends = [
            base
            binary
            bytestring
            deepseq
            hashable
            random
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/aslatter/uuid";
          description = "Type definitions for Universally Unique Identifiers";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      vector = callPackage ({ base, deepseq, ghc-prim, mkDerivation, primitive, semigroups, stdenv }:
      mkDerivation {
          pname = "vector";
          version = "0.12.0.1";
          sha256 = "b100ee79b9da2651276278cd3e0f08a3c152505cc52982beda507515af173d7b";
          revision = "1";
          editedCabalFile = "1xjv8876kx9vh86w718vdaaai40pwnsiw8368c5h88ch8iqq10qb";
          libraryHaskellDepends = [
            base
            deepseq
            ghc-prim
            primitive
            semigroups
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/vector";
          description = "Efficient Arrays";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      vector-algorithms = callPackage ({ base, bytestring, mkDerivation, mtl, mwc-random, primitive, stdenv, vector }:
      mkDerivation {
          pname = "vector-algorithms";
          version = "0.7.0.1";
          sha256 = "ed460a41ca068f568bc2027579ab14185fbb72c7ac469b5179ae5f8a52719070";
          revision = "1";
          editedCabalFile = "1996aj239vasr4hd5c0pi9i0bd08r6clzr76nqvf3hc5kjs7vml2";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            bytestring
            primitive
            vector
          ];
          executableHaskellDepends = [
            base
            mtl
            mwc-random
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://code.haskell.org/~dolio/";
          description = "Efficient algorithms for vector arrays";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      vector-th-unbox = callPackage ({ base, mkDerivation, stdenv, template-haskell, vector }:
      mkDerivation {
          pname = "vector-th-unbox";
          version = "0.2.1.6";
          sha256 = "be87d4a6f1005ee2d0de6adf521e05c9e83c441568a8a8b60c79efe24ae90235";
          libraryHaskellDepends = [
            base
            template-haskell
            vector
          ];
          doHaddock = false;
          doCheck = false;
          description = "Deriver for Data.Vector.Unboxed using Template Haskell";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      void = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "void";
          version = "0.7.2";
          sha256 = "d3fffe66a03e4b53db1e459edf75ad8402385a817cae415d857ec0b03ce0cf2b";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/void";
          description = "A Haskell 98 logically uninhabited data type";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      x509 = callPackage ({ asn1-encoding, asn1-parse, asn1-types, base, bytestring, containers, cryptonite, hourglass, memory, mkDerivation, mtl, pem, stdenv }:
      mkDerivation {
          pname = "x509";
          version = "1.7.2";
          sha256 = "dc0315a9e2bbfb2b3b6746b83cde901c0cc6aca5a3983f129c6f1cbe0ee0ce7b";
          revision = "1";
          editedCabalFile = "07mphpmj4zk5mzhp5x50a7q6w134kgymf557dcgbp643cbkcmc66";
          libraryHaskellDepends = [
            asn1-encoding
            asn1-parse
            asn1-types
            base
            bytestring
            containers
            cryptonite
            hourglass
            memory
            mtl
            pem
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-certificate";
          description = "X509 reader and writer";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      x509-store = callPackage ({ asn1-encoding, asn1-types, base, bytestring, containers, cryptonite, directory, filepath, mkDerivation, mtl, pem, stdenv, x509 }:
      mkDerivation {
          pname = "x509-store";
          version = "1.6.5";
          sha256 = "1aaab11da87f8c27b7475c4b0789823864e5f215fd5bf7c8a455feba807fe9d1";
          libraryHaskellDepends = [
            asn1-encoding
            asn1-types
            base
            bytestring
            containers
            cryptonite
            directory
            filepath
            mtl
            pem
            x509
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-certificate";
          description = "X.509 collection accessing and storing methods";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      x509-system = callPackage ({ base, bytestring, containers, directory, filepath, mkDerivation, mtl, pem, process, stdenv, x509, x509-store }:
      mkDerivation {
          pname = "x509-system";
          version = "1.6.6";
          sha256 = "40dcdaae3ec67f38c08d96d4365b901eb8ac0c590bd7972eb429d37d58aa4419";
          libraryHaskellDepends = [
            base
            bytestring
            containers
            directory
            filepath
            mtl
            pem
            process
            x509
            x509-store
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-certificate";
          description = "Handle per-operating-system X.509 accessors and storage";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      x509-validation = callPackage ({ asn1-encoding, asn1-types, base, byteable, bytestring, containers, cryptonite, data-default-class, hourglass, memory, mkDerivation, mtl, pem, stdenv, x509, x509-store }:
      mkDerivation {
          pname = "x509-validation";
          version = "1.6.9";
          sha256 = "8470cead7cf0c8cd93137f1edeb1603805d54f50647b15331d9d952fbb2cb500";
          revision = "1";
          editedCabalFile = "02n9s0wizi4wivs6is4cyapqjjnbrx3zdk34q0cnlfsvbbvyhjax";
          libraryHaskellDepends = [
            asn1-encoding
            asn1-types
            base
            byteable
            bytestring
            containers
            cryptonite
            data-default-class
            hourglass
            memory
            mtl
            pem
            x509
            x509-store
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/vincenthz/hs-certificate";
          description = "X.509 Certificate and CRL validation";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      yaml = callPackage ({ aeson, attoparsec, base, bytestring, conduit, containers, directory, filepath, mkDerivation, resourcet, scientific, semigroups, stdenv, template-haskell, text, transformers, unordered-containers, vector }:
      mkDerivation {
          pname = "yaml";
          version = "0.8.25";
          sha256 = "d7afe6b26630f52535b816d116502d10a5fa478008d2d9b849a71422e73e7d99";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            aeson
            attoparsec
            base
            bytestring
            conduit
            containers
            directory
            filepath
            resourcet
            scientific
            semigroups
            template-haskell
            text
            transformers
            unordered-containers
            vector
          ];
          executableHaskellDepends = [
            aeson
            base
            bytestring
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/snoyberg/yaml/";
          description = "Support for parsing and rendering YAML documents";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      zip-archive = callPackage ({ array, base, binary, bytestring, containers, digest, directory, filepath, mkDerivation, mtl, old-time, pretty, stdenv, text, time, unix, zlib }:
      mkDerivation {
          pname = "zip-archive";
          version = "0.3.1.1";
          sha256 = "9e868e649e6fd06cf50c2f0f1e480ce36640494449e415abf2509f9347f08325";
          revision = "1";
          editedCabalFile = "0n8f1075gz5q2k9mqzadca6is0fi1bgi91sfw1yq2kqakkbrbkqy";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            array
            base
            binary
            bytestring
            containers
            digest
            directory
            filepath
            mtl
            old-time
            pretty
            text
            time
            unix
            zlib
          ];
          executableHaskellDepends = [
            base
            bytestring
            directory
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/jgm/zip-archive";
          description = "Library for creating and modifying zip archives";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      zlib = callPackage ({ base, bytestring, mkDerivation, stdenv, zlib }:
      mkDerivation {
          pname = "zlib";
          version = "0.6.1.2";
          sha256 = "e4eb4e636caf07a16a9730ce469a00b65d5748f259f43edd904dd457b198a2bb";
          libraryHaskellDepends = [
            base
            bytestring
          ];
          librarySystemDepends = [ zlib ];
          doHaddock = false;
          doCheck = false;
          description = "Compression and decompression in the gzip and zlib formats";
          license = stdenv.lib.licenses.bsd3;
        }) { zlib = pkgs.zlib; };
    };
in
compiler.override {
  initialPackages = stackPackages;
  configurationCommon = { ... }: self: super: {};
}


{ pkgs ? (import <nixpkgs> {})
, compiler ? pkgs.haskell.packages.ghc802
, ghc ? pkgs.haskell.compiler.ghc802
}:

with (import <nixpkgs/pkgs/development/haskell-modules/lib.nix> { inherit pkgs; });

let
  hackagePackages = import <nixpkgs/pkgs/development/haskell-modules/hackage-packages.nix>;
  stackPackages = { callPackage, pkgs, stdenv }:
self: {
      Glob = callPackage ({ HUnit, QuickCheck, base, containers, directory, dlist, filepath, mkDerivation, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2, transformers, transformers-compat }:
      mkDerivation {
          pname = "Glob";
          version = "0.7.14";
          sha256 = "0aw43izg8vlvjl40ms6k92w7gxg7n3l6smdvzla47fp82s4vhdr8";
          libraryHaskellDepends = [
            base
            containers
            directory
            dlist
            filepath
            transformers
            transformers-compat
          ];
          testHaskellDepends = [
            base
            containers
            directory
            dlist
            filepath
            HUnit
            QuickCheck
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://iki.fi/matti.niemenmaa/glob/";
          description = "Globbing library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      SafeSemaphore = callPackage ({ HUnit, base, containers, mkDerivation, stdenv, stm }:
      mkDerivation {
          pname = "SafeSemaphore";
          version = "0.10.1";
          sha256 = "0rpg9j6fy70i0b9dkrip9d6wim0nac0snp7qzbhykjkqlcvvgr91";
          revision = "1";
          editedCabalFile = "1b168ec8de4b3958df15b33ba9ab60d8a651d9dd4ea36891d4c31ae81e7ec1cc";
          libraryHaskellDepends = [
            base
            containers
            stm
          ];
          testHaskellDepends = [
            base
            HUnit
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
          sha256 = "1dzz9l0haswgag9x56q7n57kw18v7nhmzkjyr61nz9y9npn8vmks";
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
      adjunctions = callPackage ({ array, base, comonad, containers, contravariant, distributive, free, mkDerivation, mtl, profunctors, semigroupoids, semigroups, stdenv, tagged, transformers, transformers-compat, void }:
      mkDerivation {
          pname = "adjunctions";
          version = "4.3";
          sha256 = "1k1ykisf96i4g2zm47c45md7p42c4vsp9r73392pz1g8mx7s2j5r";
          revision = "1";
          editedCabalFile = "f88c4f5440736d64ad6a478e9feccc116727b5dc616fc6535cfe64ff75a2e980";
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
      aeson = callPackage ({ HUnit, QuickCheck, attoparsec, base, base-compat, base-orphans, base16-bytestring, bytestring, containers, deepseq, dlist, generic-deriving, ghc-prim, hashable, hashable-time, mkDerivation, quickcheck-instances, scientific, stdenv, tagged, template-haskell, test-framework, test-framework-hunit, test-framework-quickcheck2, text, time, time-locale-compat, unordered-containers, vector }:
      mkDerivation {
          pname = "aeson";
          version = "1.0.2.1";
          sha256 = "0rlhr225vb6apxw1m0jpnjpbcwb2ij30n6r41qyhd5lr1ax6z9p0";
          revision = "1";
          editedCabalFile = "cf848d5d07a3e6962d7a274d452c772bc1c413a0f9f2d5f112fdde4556a7d7f1";
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
            vector
          ];
          testHaskellDepends = [
            attoparsec
            base
            base-compat
            base-orphans
            base16-bytestring
            bytestring
            containers
            dlist
            generic-deriving
            ghc-prim
            hashable
            hashable-time
            HUnit
            QuickCheck
            quickcheck-instances
            scientific
            tagged
            template-haskell
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
            text
            time
            time-locale-compat
            unordered-containers
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/aeson";
          description = "Fast JSON parsing and encoding";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      ansi-terminal = callPackage ({ base, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "ansi-terminal";
          version = "0.6.2.3";
          sha256 = "0hpfw0k025y681m9ml1c712skrb1p4vh7z5x1f0ci9ww7ssjrh2d";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            base
            unix
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
          sha256 = "025pyphsjf0dnbrmj5nscbi6gzyigwgp3ifxb3psn7kji6mfr29p";
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            ansi-terminal
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/ansi-wl-pprint";
          description = "The Wadler/Leijen Pretty Printer for colored ANSI terminal output";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      array = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "array";
          version = "0.5.1.1";
          sha256 = "08r2rq4blvc737mrg3xhlwiw13jmsz5dlf2fd0ghb9cdaxc6kjc9";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "Mutable and immutable arrays";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      async = callPackage ({ HUnit, base, mkDerivation, stdenv, stm, test-framework, test-framework-hunit }:
      mkDerivation {
          pname = "async";
          version = "2.1.1.1";
          sha256 = "1qj4fp1ynwg0l453gmm27vgkzb5k5m2hzdlg5rdqi9kf8rqy90yd";
          libraryHaskellDepends = [
            base
            stm
          ];
          testHaskellDepends = [
            base
            HUnit
            test-framework
            test-framework-hunit
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/simonmar/async";
          description = "Run IO operations asynchronously and wait for their results";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      attoparsec = callPackage ({ QuickCheck, array, base, bytestring, case-insensitive, containers, criterion, deepseq, directory, filepath, ghc-prim, http-types, mkDerivation, parsec, quickcheck-unicode, scientific, stdenv, tasty, tasty-quickcheck, text, transformers, unordered-containers, vector }:
      mkDerivation {
          pname = "attoparsec";
          version = "0.13.1.0";
          sha256 = "0r1zrrkbqv8w4pb459fj5izd1h85p9nrsp3gyzj7qiayjpa79p2j";
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
          testHaskellDepends = [
            array
            base
            bytestring
            deepseq
            QuickCheck
            quickcheck-unicode
            scientific
            tasty
            tasty-quickcheck
            text
            transformers
            vector
          ];
          benchmarkHaskellDepends = [
            array
            base
            bytestring
            case-insensitive
            containers
            criterion
            deepseq
            directory
            filepath
            ghc-prim
            http-types
            parsec
            scientific
            text
            transformers
            unordered-containers
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/attoparsec";
          description = "Fast combinator parsing for bytestrings and text";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      base = callPackage ({ ghc-prim, integer-gmp, mkDerivation, rts, stdenv }:
      mkDerivation {
          pname = "base";
          version = "4.9.1.0";
          sha256 = "0zpvf4yq52dkl9f30w6x4fv1lqcc175i57prhv56ky06by08anvs";
          libraryHaskellDepends = [
            ghc-prim
            integer-gmp
            rts
          ];
          doHaddock = false;
          doCheck = false;
          description = "Basic libraries";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      base-compat = callPackage ({ QuickCheck, base, hspec, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "base-compat";
          version = "0.9.3";
          sha256 = "0452l6zf6fjhy4kxqwv6i6hhg6yfx4wcg450k3axpyj30l7jnq3x";
          libraryHaskellDepends = [
            base
            unix
          ];
          testHaskellDepends = [
            base
            hspec
            QuickCheck
          ];
          doHaddock = false;
          doCheck = false;
          description = "A compatibility layer for base";
          license = stdenv.lib.licenses.mit;
        }) {};
      base-orphans = callPackage ({ QuickCheck, base, ghc-prim, hspec, mkDerivation, stdenv }:
      mkDerivation {
          pname = "base-orphans";
          version = "0.5.4";
          sha256 = "0qv20n4yabg7sc3rs2dd46a53c7idnd88by7n3s36dkbc21m41q4";
          libraryHaskellDepends = [
            base
            ghc-prim
          ];
          testHaskellDepends = [
            base
            hspec
            QuickCheck
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell-compat/base-orphans#readme";
          description = "Backwards-compatible orphan instances for base";
          license = stdenv.lib.licenses.mit;
        }) {};
      bifunctors = callPackage ({ QuickCheck, base, base-orphans, comonad, containers, hspec, mkDerivation, semigroups, stdenv, tagged, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "bifunctors";
          version = "5.4.2";
          sha256 = "13fwvw1102ik96pgi85i34kisz1h237vgw88ywsgifsah9kh4qiq";
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
          testHaskellDepends = [
            base
            hspec
            QuickCheck
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
      binary = callPackage ({ Cabal, HUnit, QuickCheck, array, attoparsec, base, bytestring, cereal, containers, criterion, deepseq, directory, filepath, mkDerivation, mtl, random, stdenv, tar, test-framework, test-framework-quickcheck2, unordered-containers, zlib }:
      mkDerivation {
          pname = "binary";
          version = "0.8.3.0";
          sha256 = "08d85qzna6zdkpgqwaw1d87biviv1b76zvk5qs3gg4kxwzfqa4r2";
          revision = "2";
          editedCabalFile = "d108ea136495c17b9fd3d22a66fd2152c25e0ae812aadc8814c7cb806fdae35b";
          libraryHaskellDepends = [
            array
            base
            bytestring
            containers
          ];
          testHaskellDepends = [
            array
            base
            bytestring
            Cabal
            containers
            directory
            filepath
            HUnit
            QuickCheck
            random
            test-framework
            test-framework-quickcheck2
          ];
          benchmarkHaskellDepends = [
            array
            attoparsec
            base
            bytestring
            Cabal
            cereal
            containers
            criterion
            deepseq
            directory
            filepath
            mtl
            tar
            unordered-containers
            zlib
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/kolmodin/binary";
          description = "Binary serialisation for Haskell values using lazy ByteStrings";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      blaze-builder = callPackage ({ HUnit, QuickCheck, base, bytestring, deepseq, mkDerivation, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2, text, utf8-string }:
      mkDerivation {
          pname = "blaze-builder";
          version = "0.4.0.2";
          sha256 = "1m33y6p5xldni8p4fzg8fmsyqvkfmnimdamr1xjnsmgm3dkf9lws";
          libraryHaskellDepends = [
            base
            bytestring
            deepseq
            text
          ];
          testHaskellDepends = [
            base
            bytestring
            HUnit
            QuickCheck
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
            text
            utf8-string
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/lpsmith/blaze-builder";
          description = "Efficient buffered output";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      blaze-html = callPackage ({ HUnit, QuickCheck, base, blaze-builder, blaze-markup, bytestring, containers, mkDerivation, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2, text }:
      mkDerivation {
          pname = "blaze-html";
          version = "0.8.1.3";
          sha256 = "0dyn6cj5av4apmc3wav6asfap53gxy4hzdb7rph83yakscbyf5lc";
          libraryHaskellDepends = [
            base
            blaze-builder
            blaze-markup
            bytestring
            text
          ];
          testHaskellDepends = [
            base
            blaze-builder
            blaze-markup
            bytestring
            containers
            HUnit
            QuickCheck
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://jaspervdj.be/blaze";
          description = "A blazingly fast HTML combinator library for Haskell";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      blaze-markup = callPackage ({ HUnit, QuickCheck, base, blaze-builder, bytestring, containers, mkDerivation, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2, text }:
      mkDerivation {
          pname = "blaze-markup";
          version = "0.7.1.1";
          sha256 = "00s3qlkbq9gxgy6l5skbhnl5h81mjgzqcrw3yn3wqnyd9scab3b3";
          libraryHaskellDepends = [
            base
            blaze-builder
            bytestring
            text
          ];
          testHaskellDepends = [
            base
            blaze-builder
            bytestring
            containers
            HUnit
            QuickCheck
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://jaspervdj.be/blaze";
          description = "A blazingly fast markup combinator library for Haskell";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      bytestring = callPackage ({ HUnit, QuickCheck, base, byteorder, deepseq, directory, dlist, ghc-prim, integer-gmp, mkDerivation, mtl, random, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2 }:
      mkDerivation {
          pname = "bytestring";
          version = "0.10.8.1";
          sha256 = "16zwb1p83z7vc5wlhvknpy80b5a2jxc5awx67rk52qnp9idmyq9d";
          libraryHaskellDepends = [
            base
            deepseq
            ghc-prim
            integer-gmp
          ];
          testHaskellDepends = [
            base
            byteorder
            deepseq
            directory
            dlist
            ghc-prim
            HUnit
            mtl
            QuickCheck
            random
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/bytestring";
          description = "Fast, compact, strict and lazy byte strings with a list interface";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      cabal2nix = callPackage ({ mkDerivation, aeson, ansi-wl-pprint, base, bytestring, Cabal, containers, deepseq, directory, distribution-nixpkgs, doctest, fetchgit, filepath, hackage-db, hopenssl, language-nix, lens, monad-par, monad-par-extras, mtl, optparse-applicative, pretty, process, SHA, split, stdenv, text, time, transformers, utf8-string, yaml }:
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
            aeson ansi-wl-pprint base bytestring Cabal containers deepseq directory distribution-nixpkgs filepath hackage-db hopenssl language-nix lens optparse-applicative pretty process split SHA text transformers yaml
          ];
          executableHaskellDepends = [
            aeson ansi-wl-pprint base bytestring Cabal containers deepseq directory distribution-nixpkgs filepath hackage-db hopenssl language-nix lens monad-par monad-par-extras mtl optparse-applicative pretty process split text time transformers utf8-string yaml
          ];
          testHaskellDepends = [
            aeson ansi-wl-pprint base bytestring Cabal containers deepseq directory distribution-nixpkgs doctest filepath hackage-db hopenssl language-nix lens optparse-applicative pretty process split text transformers yaml
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/nixos/cabal2nix#readme";
          description = "Convert Cabal files into Nix build instructions";
          license = stdenv.lib.licenses.bsd3;
      }) {};
      charset = callPackage ({ array, base, bytestring, containers, mkDerivation, semigroups, stdenv, unordered-containers }:
      mkDerivation {
          pname = "charset";
          version = "0.3.7.1";
          sha256 = "1gn0m96qpjww8hpp2g1as5yy0wcwy4iq73h3kz6g0yxxhcl5sh9x";
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
      comonad = callPackage ({ Cabal, base, cabal-doctest, containers, contravariant, distributive, doctest, mkDerivation, semigroups, stdenv, tagged, transformers, transformers-compat }:
      mkDerivation {
          pname = "comonad";
          version = "5.0.1";
          sha256 = "0ga67ynh1j4ylbn3awjh7iga09fypbh4fsa21mylcf4xgmlzs7sn";
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
          testHaskellDepends = [
            base
            doctest
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/comonad/";
          description = "Comonads";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      conduit = callPackage ({ QuickCheck, base, containers, criterion, deepseq, exceptions, hspec, kan-extensions, lifted-base, mkDerivation, mmorph, monad-control, mtl, mwc-random, primitive, resourcet, safe, split, stdenv, transformers, transformers-base, vector }:
      mkDerivation {
          pname = "conduit";
          version = "1.2.10";
          sha256 = "1paqps8sc5ilx2nj98svvv5y9p26cl02d2a16qk9m16slzg7l5ni";
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
          ];
          testHaskellDepends = [
            base
            containers
            exceptions
            hspec
            mtl
            QuickCheck
            resourcet
            safe
            split
            transformers
          ];
          benchmarkHaskellDepends = [
            base
            containers
            criterion
            deepseq
            hspec
            kan-extensions
            mwc-random
            transformers
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/snoyberg/conduit";
          description = "Streaming data processing library";
          license = stdenv.lib.licenses.mit;
        }) {};
      containers = callPackage ({ ChasingBottoms, HUnit, QuickCheck, array, base, deepseq, ghc-prim, mkDerivation, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2 }:
      mkDerivation {
          pname = "containers";
          version = "0.5.7.1";
          sha256 = "0y8g81p2lx3c2ks2xa798iv0xf6zvks9lc3l6k1jdsp20wrnr1bk";
          libraryHaskellDepends = [
            array
            base
            deepseq
            ghc-prim
          ];
          testHaskellDepends = [
            array
            base
            ChasingBottoms
            deepseq
            ghc-prim
            HUnit
            QuickCheck
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
          ];
          doHaddock = false;
          doCheck = false;
          description = "Assorted concrete container types";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      contravariant = callPackage ({ StateVar, base, mkDerivation, semigroups, stdenv, transformers, transformers-compat, void }:
      mkDerivation {
          pname = "contravariant";
          version = "1.4";
          sha256 = "117fff8kkrvlmr8cb2jpj71z7lf2pdiyks6ilyx89mry6zqnsrp1";
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
      data-fix = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "data-fix";
          version = "0.0.4";
          sha256 = "1446gvgq5xfsixcm63fyi4qv15kqxdfw2b2bzwm3q303n0xd5ql5";
          revision = "1";
          editedCabalFile = "e784f9bb1f2b758fbd41f5ff535ba911081182f89a81c19e36735f0e5e8d59f8";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/anton-k/data-fix";
          description = "Fixpoint data types";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      deepseq = callPackage ({ HUnit, array, base, mkDerivation, stdenv, test-framework, test-framework-hunit }:
      mkDerivation {
          pname = "deepseq";
          version = "1.4.2.0";
          sha256 = "0la9x4hvf1rbmxv8h9dk1qln21il3wydz6wbdviryh4h2wls22ny";
          libraryHaskellDepends = [
            array
            base
          ];
          testHaskellDepends = [
            array
            base
            HUnit
            test-framework
            test-framework-hunit
          ];
          doHaddock = false;
          doCheck = false;
          description = "Deep evaluation of data structures";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      deriving-compat = callPackage ({ QuickCheck, base, base-compat, base-orphans, containers, ghc-boot-th, ghc-prim, hspec, mkDerivation, stdenv, tagged, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "deriving-compat";
          version = "0.3.6";
          sha256 = "0v9m76hjrlrcbyawdp04y1vv0p867h3jhy00xjxgmqq5cm0sn7qc";
          libraryHaskellDepends = [
            base
            containers
            ghc-boot-th
            ghc-prim
            template-haskell
            transformers
            transformers-compat
          ];
          testHaskellDepends = [
            base
            base-compat
            base-orphans
            hspec
            QuickCheck
            tagged
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
      directory = callPackage ({ base, filepath, mkDerivation, stdenv, time, unix }:
      mkDerivation {
          pname = "directory";
          version = "1.3.0.0";
          sha256 = "11ykplzx1kljcj0vsj8ly9m2hj3nmsj487xdly7b8rq15chxi71n";
          libraryHaskellDepends = [
            base
            filepath
            time
            unix
          ];
          testHaskellDepends = [
            base
            filepath
            time
            unix
          ];
          doHaddock = false;
          doCheck = false;
          description = "Platform-agnostic library for filesystem operations";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      distributive = callPackage ({ Cabal, base, base-orphans, cabal-doctest, doctest, generic-deriving, hspec, mkDerivation, stdenv, tagged, transformers, transformers-compat }:
      mkDerivation {
          pname = "distributive";
          version = "0.5.2";
          sha256 = "1nbcyysnrkliy7xwx6f39p80kkp0vlvq14wdj6r0m5c1brmbxqmd";
          revision = "2";
          editedCabalFile = "29cf1ac04b774831a231c83cd13c4356c65dc657000f1a79ef3e42ad21e6e2f2";
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
          testHaskellDepends = [
            base
            doctest
            generic-deriving
            hspec
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/distributive/";
          description = "Distributive functors -- Dual to Traversable";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      dlist = callPackage ({ Cabal, QuickCheck, base, deepseq, mkDerivation, stdenv }:
      mkDerivation {
          pname = "dlist";
          version = "0.8.0.2";
          sha256 = "1ca1hvl5kd4api4gjyhwwavdx8snq6gf1jr6ab0zmjx7p77pwfbp";
          libraryHaskellDepends = [
            base
            deepseq
          ];
          testHaskellDepends = [
            base
            Cabal
            QuickCheck
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/spl/dlist";
          description = "Difference lists";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      exceptions = callPackage ({ QuickCheck, base, mkDerivation, mtl, stdenv, stm, template-haskell, test-framework, test-framework-quickcheck2, transformers, transformers-compat }:
      mkDerivation {
          pname = "exceptions";
          version = "0.8.3";
          sha256 = "1gl7xzffsqmigam6zg0jsglncgzxqafld2p6kb7ccp9xirzdjsjd";
          revision = "2";
          editedCabalFile = "dc2b4ed2a3de646d8ff599ff972e25b3a1a5165ead3a46ff84a3d443814c85ee";
          libraryHaskellDepends = [
            base
            mtl
            stm
            template-haskell
            transformers
            transformers-compat
          ];
          testHaskellDepends = [
            base
            mtl
            QuickCheck
            stm
            template-haskell
            test-framework
            test-framework-quickcheck2
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/exceptions/";
          description = "Extensible optionally-pure exceptions";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      fail = callPackage ({ mkDerivation, stdenv }:
      mkDerivation {
          pname = "fail";
          version = "4.9.0.0";
          sha256 = "18nlj6xvnggy61gwbyrpmvbdkq928wv0wx2zcsljb52kbhddnp3d";
          doHaddock = false;
          doCheck = false;
          homepage = "https://prime.haskell.org/wiki/Libraries/Proposals/MonadFail";
          description = "Forward-compatible MonadFail class";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      filepath = callPackage ({ QuickCheck, base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "filepath";
          version = "1.4.1.1";
          sha256 = "1d0jkzlhcvkikllnxz6ij8zsq6r4sx5ii3abahhdji1spkivvzaj";
          libraryHaskellDepends = [
            base
          ];
          testHaskellDepends = [
            base
            QuickCheck
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/filepath#readme";
          description = "Library for manipulating FilePaths in a cross platform way";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      fingertree = callPackage ({ HUnit, QuickCheck, base, mkDerivation, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2 }:
      mkDerivation {
          pname = "fingertree";
          version = "0.1.1.0";
          sha256 = "1w6x3kp3by5yjmam6wlrf9vap5l5rrqaip0djbrdp0fpf2imn30n";
          libraryHaskellDepends = [
            base
          ];
          testHaskellDepends = [
            base
            HUnit
            QuickCheck
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
          ];
          doHaddock = false;
          doCheck = false;
          description = "Generic finger-tree structure, with example instances";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      free = callPackage ({ base, bifunctors, comonad, containers, distributive, exceptions, mkDerivation, mtl, prelude-extras, profunctors, semigroupoids, semigroups, stdenv, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "free";
          version = "4.12.4";
          sha256 = "1147s393442xf4gkpbq0rd1p286vmykgx85mxhk5d1c7wfm4bzn9";
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
      ghc-boot-th = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "ghc-boot-th";
          version = "8.0.2";
          sha256 = "1w7qkgwpbp5h0hm8p2b5bbysyvnjrqbkqkfzd4ngz0yxy9qy402x";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "Shared functionality between GHC and the @template-haskell@ library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      ghc-prim = callPackage ({ mkDerivation, rts, stdenv }:
      mkDerivation {
          pname = "ghc-prim";
          version = "0.5.0.0";
          sha256 = "1cnn5gcwnc711ngx5hac3x2s4f6dkdl7li5pc3c02lcghpqf9fs4";
          libraryHaskellDepends = [ rts ];
          doHaddock = false;
          doCheck = false;
          description = "GHC primitives";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hashable = callPackage ({ HUnit, QuickCheck, base, bytestring, criterion, deepseq, ghc-prim, integer-gmp, mkDerivation, random, siphash, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2, text, unix }:
      mkDerivation {
          pname = "hashable";
          version = "1.2.6.0";
          sha256 = "0lhadvg4l18iff2hg4d5akn5f3lrg9pfwxpkn1j2zxbsh8y6d6s2";
          revision = "1";
          editedCabalFile = "8f8a4f7b788fb1ea04636634c7e1c9cd0a4a6cfe66cdb808dc24f56c187451df";
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
          testHaskellDepends = [
            base
            bytestring
            ghc-prim
            HUnit
            QuickCheck
            random
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
            text
            unix
          ];
          benchmarkHaskellDepends = [
            base
            bytestring
            criterion
            ghc-prim
            integer-gmp
            siphash
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/tibbe/hashable";
          description = "A class for types that can be converted to a hash value";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hnix = callPackage ({ ansi-wl-pprint, base, containers, criterion, data-fix, deepseq, deriving-compat, mkDerivation, parsers, semigroups, stdenv, tasty, tasty-hunit, tasty-th, text, transformers, trifecta, unordered-containers }:
      mkDerivation {
          pname = "hnix";
          version = "0.3.4";
          sha256 = "1wnvbal093c207vr68i0zyrxvmb3yyxdr8p7lbw2yy4ari2hi2gc";
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
          testHaskellDepends = [
            base
            containers
            data-fix
            tasty
            tasty-hunit
            tasty-th
            text
          ];
          benchmarkHaskellDepends = [
            base
            containers
            criterion
            text
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/jwiegley/hnix";
          description = "Haskell implementation of the Nix language";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      integer-gmp = callPackage ({ ghc-prim, mkDerivation, stdenv }:
      mkDerivation {
          pname = "integer-gmp";
          version = "1.0.0.1";
          sha256 = "08f1qcp57aj5mjy26dl3bi3lcg0p8ylm0qw4c6zbc1vhgnmxl4gg";
          revision = "1";
          editedCabalFile = "616d1775344a82a0ae1db1791fba719f4682a1ace908582ac4026db14231d4d5";
          libraryHaskellDepends = [
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          description = "Integer library based on GMP";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      integer-logarithms = callPackage ({ QuickCheck, array, base, ghc-prim, integer-gmp, mkDerivation, smallcheck, stdenv, tasty, tasty-hunit, tasty-quickcheck, tasty-smallcheck }:
      mkDerivation {
          pname = "integer-logarithms";
          version = "1.0.1";
          sha256 = "0k3q79yjwln3fk0m1mwsxc3rypysx6ayl13xqgm254dip273yi8g";
          revision = "1";
          editedCabalFile = "3e6c78b7d38f5767da86e1948a1816e0ede7f123f93a9594e7bb5a8c902369ce";
          libraryHaskellDepends = [
            array
            base
            ghc-prim
            integer-gmp
          ];
          testHaskellDepends = [
            base
            QuickCheck
            smallcheck
            tasty
            tasty-hunit
            tasty-quickcheck
            tasty-smallcheck
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
          sha256 = "0bj88bgwxlx490f5r979idsm9dpdsb0ldzar9sa0jhj2jn2xx7hw";
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
      lens = callPackage ({ HUnit, QuickCheck, array, base, base-orphans, bifunctors, bytestring, comonad, containers, contravariant, criterion, deepseq, directory, distributive, doctest, exceptions, filepath, free, generic-deriving, ghc-prim, hashable, hlint, kan-extensions, mkDerivation, mtl, nats, parallel, profunctors, reflection, semigroupoids, semigroups, simple-reflect, stdenv, tagged, template-haskell, test-framework, test-framework-hunit, test-framework-quickcheck2, test-framework-th, text, transformers, transformers-compat, unordered-containers, vector, void }:
      mkDerivation {
          pname = "lens";
          version = "4.15.1";
          sha256 = "19myn50qwr1f8g3cx4fvzajln428qb8iwyi4qa9p2y5rn56adyjw";
          revision = "4";
          editedCabalFile = "e055de1a2d30bf9122947afbc5e342b06a0f4a512fece45f5b9132f7beb11539";
          libraryHaskellDepends = [
            array
            base
            base-orphans
            bifunctors
            bytestring
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
            transformers
            transformers-compat
            unordered-containers
            vector
            void
          ];
          testHaskellDepends = [
            base
            bytestring
            containers
            deepseq
            directory
            doctest
            filepath
            generic-deriving
            hlint
            HUnit
            mtl
            nats
            parallel
            QuickCheck
            semigroups
            simple-reflect
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
            test-framework-th
            text
            transformers
            unordered-containers
            vector
          ];
          benchmarkHaskellDepends = [
            base
            bytestring
            comonad
            containers
            criterion
            deepseq
            generic-deriving
            transformers
            unordered-containers
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/lens/";
          description = "Lenses, Folds and Traversals";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      lifted-base = callPackage ({ HUnit, base, criterion, mkDerivation, monad-control, monad-peel, stdenv, test-framework, test-framework-hunit, transformers, transformers-base, transformers-compat }:
      mkDerivation {
          pname = "lifted-base";
          version = "0.2.3.10";
          sha256 = "1z149mwf839yc0l3islm485n6yfwxbdjfbwd8yi0vi3nn5hfaxz6";
          libraryHaskellDepends = [
            base
            monad-control
            transformers-base
          ];
          testHaskellDepends = [
            base
            HUnit
            monad-control
            test-framework
            test-framework-hunit
            transformers
            transformers-base
            transformers-compat
          ];
          benchmarkHaskellDepends = [
            base
            criterion
            monad-control
            monad-peel
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/basvandijk/lifted-base";
          description = "lifted IO operations from the base library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      mmorph = callPackage ({ base, mkDerivation, mtl, stdenv, transformers, transformers-compat }:
      mkDerivation {
          pname = "mmorph";
          version = "1.0.9";
          sha256 = "0qs5alhy719a14lrs7rnh2qsn1146czg68gvgylf4m5jh4w7vwp1";
          revision = "1";
          editedCabalFile = "4dd6d1966746918b7503dafa8b78b75df2245406baa083858e1a2310313aaef7";
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
          version = "1.0.1.0";
          sha256 = "1x018gi5irznx5rgzmkr2nrgh26r8cvqwkcfc6n6y05pdjf21c6l";
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
      monad-parallel = callPackage ({ base, mkDerivation, parallel, stdenv, transformers, transformers-compat }:
      mkDerivation {
          pname = "monad-parallel";
          version = "0.7.2.2";
          sha256 = "1czg23k9qpggj58fksi4zqyig2flqqi1fznq17iw276fivnimgb0";
          libraryHaskellDepends = [
            base
            parallel
            transformers
            transformers-compat
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://trac.haskell.org/SCC/wiki/monad-parallel";
          description = "Parallel execution of monadic computations";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      mtl = callPackage ({ base, mkDerivation, stdenv, transformers }:
      mkDerivation {
          pname = "mtl";
          version = "2.2.1";
          sha256 = "1icdbj2rshzn0m1zz5wa7v3xvkf6qw811p4s7jgqwvx1ydwrvrfa";
          revision = "1";
          editedCabalFile = "4b5a800fe9edf168fc7ae48c7a3fc2aab6b418ac15be2f1dad43c0f48a494a3b";
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
      optparse-applicative = callPackage ({ QuickCheck, ansi-wl-pprint, base, mkDerivation, process, stdenv, transformers, transformers-compat }:
      mkDerivation {
          pname = "optparse-applicative";
          version = "0.13.2.0";
          sha256 = "18kcjldpzay3k3309rvb9vqrp5b1gqp0hgymynqx7x2kgv7cz0sw";
          libraryHaskellDepends = [
            ansi-wl-pprint
            base
            process
            transformers
            transformers-compat
          ];
          testHaskellDepends = [
            base
            QuickCheck
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/pcapriotti/optparse-applicative";
          description = "Utilities and combinators for parsing command line options";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      parallel = callPackage ({ array, base, containers, deepseq, mkDerivation, stdenv }:
      mkDerivation {
          pname = "parallel";
          version = "3.2.1.1";
          sha256 = "05rw8zhpqhx31zi6vg7zpyciaarh24j7g2p613xrpyrnksybjfrj";
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
      parsec = callPackage ({ HUnit, base, bytestring, mkDerivation, mtl, stdenv, test-framework, test-framework-hunit, text }:
      mkDerivation {
          pname = "parsec";
          version = "3.1.11";
          sha256 = "0vk7q9j2128q191zf1sg0ylj9s9djwayqk9747k0a5fin4f2b1vg";
          libraryHaskellDepends = [
            base
            bytestring
            mtl
            text
          ];
          testHaskellDepends = [
            base
            HUnit
            test-framework
            test-framework-hunit
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/aslatter/parsec";
          description = "Monadic parser combinators";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      parsers = callPackage ({ QuickCheck, attoparsec, base, base-orphans, bytestring, charset, containers, directory, doctest, filepath, mkDerivation, parsec, quickcheck-instances, scientific, stdenv, text, transformers, unordered-containers }:
      mkDerivation {
          pname = "parsers";
          version = "0.12.4";
          sha256 = "07najh7f9y3ahh42z96sw4hnd0kc4x3wm0xlf739y0gh81ys5097";
          revision = "1";
          editedCabalFile = "b1094791062f6d334ccd61466173bee4f906a6a41c30658cec5a96b59a97c3f8";
          libraryHaskellDepends = [
            attoparsec
            base
            base-orphans
            charset
            containers
            parsec
            scientific
            text
            transformers
            unordered-containers
          ];
          testHaskellDepends = [
            attoparsec
            base
            bytestring
            containers
            directory
            doctest
            filepath
            parsec
            QuickCheck
            quickcheck-instances
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/parsers/";
          description = "Parsing combinators";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      prelude-extras = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "prelude-extras";
          version = "0.4.0.3";
          sha256 = "0xzqdf3nl2h0ra4gnslm1m1nsxlsgc0hh6ky3vn578vh11zhifq9";
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
          version = "0.6.1.0";
          sha256 = "1j1q7l21rdm8kfs93vibr3xwkkhqis181w2k6klfhx5g5skiywwk";
          revision = "1";
          editedCabalFile = "6ec7c2455c437aba71f856b797e7db440c83719509aa63a9a3d1b4652ca3683d";
          libraryHaskellDepends = [
            base
            ghc-prim
            transformers
          ];
          testHaskellDepends = [
            base
            ghc-prim
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/primitive";
          description = "Primitive memory-related operations";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      process = callPackage ({ base, bytestring, deepseq, directory, filepath, mkDerivation, stdenv, unix }:
      mkDerivation {
          pname = "process";
          version = "1.4.3.0";
          sha256 = "1szhlzsjfmn5sd7r68scawqxa6l2xh0lszffi92bmhqr1b9g8wsl";
          libraryHaskellDepends = [
            base
            deepseq
            directory
            filepath
            unix
          ];
          testHaskellDepends = [
            base
            bytestring
            directory
          ];
          doHaddock = false;
          doCheck = false;
          description = "Process libraries";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      profunctors = callPackage ({ base, base-orphans, bifunctors, comonad, contravariant, distributive, mkDerivation, stdenv, tagged, transformers }:
      mkDerivation {
          pname = "profunctors";
          version = "5.2";
          sha256 = "1905xv9y2sx1iya0zlrx7nxhlwap5vn144nxg7s8zsj58xff59w7";
          revision = "1";
          editedCabalFile = "530cbe1328db594389d931c3d5dac1e6e923447d2046901d3065e1098cda1fe0";
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
      reducers = callPackage ({ array, base, bytestring, containers, fingertree, hashable, mkDerivation, semigroupoids, semigroups, stdenv, text, transformers, unordered-containers }:
      mkDerivation {
          pname = "reducers";
          version = "3.12.1";
          sha256 = "0pkddg0s3cn759miq0nfrq7lnp3imk5sx784ihsilsbjh9kvffz4";
          revision = "1";
          editedCabalFile = "c6ab48d549368fdf26d133be187a1ca00831307271b1a710ec950d50b2d1c2be";
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
          sha256 = "0f9w0akbm6p8h7kzgcd2f6nnpw1wy84pqn45vfz1ch5j0hn8h2d9";
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
      resourcet = callPackage ({ base, containers, exceptions, hspec, lifted-base, mkDerivation, mmorph, monad-control, mtl, stdenv, transformers, transformers-base, transformers-compat }:
      mkDerivation {
          pname = "resourcet";
          version = "1.1.9";
          sha256 = "1x9f2qz57agl3xljp1wi0ab51p13czrpf6qjp3506rl9dg99j6as";
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
          testHaskellDepends = [
            base
            hspec
            lifted-base
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/snoyberg/conduit";
          description = "Deterministic allocation and freeing of scarce resources";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      scientific = callPackage ({ QuickCheck, base, binary, bytestring, containers, criterion, deepseq, ghc-prim, hashable, integer-gmp, integer-logarithms, mkDerivation, smallcheck, stdenv, tasty, tasty-ant-xml, tasty-hunit, tasty-quickcheck, tasty-smallcheck, text, vector }:
      mkDerivation {
          pname = "scientific";
          version = "0.3.4.12";
          sha256 = "0pcm5s918sbyahbr7hinfkjcnv8fqp9xddkg6mmniyw2f1sqzyi6";
          libraryHaskellDepends = [
            base
            binary
            bytestring
            containers
            deepseq
            ghc-prim
            hashable
            integer-gmp
            integer-logarithms
            text
            vector
          ];
          testHaskellDepends = [
            base
            binary
            bytestring
            QuickCheck
            smallcheck
            tasty
            tasty-ant-xml
            tasty-hunit
            tasty-quickcheck
            tasty-smallcheck
            text
          ];
          benchmarkHaskellDepends = [
            base
            criterion
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/basvandijk/scientific";
          description = "Numbers represented using scientific notation";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      semigroupoids = callPackage ({ base, base-orphans, bifunctors, comonad, containers, contravariant, directory, distributive, doctest, filepath, mkDerivation, semigroups, stdenv, tagged, transformers, transformers-compat }:
      mkDerivation {
          pname = "semigroupoids";
          version = "5.1";
          sha256 = "0dgqc59p4xx5cl8qkpm6sn4wd3n59rq7l6din76hf10bnklqrb0n";
          libraryHaskellDepends = [
            base
            base-orphans
            bifunctors
            comonad
            containers
            contravariant
            distributive
            semigroups
            tagged
            transformers
            transformers-compat
          ];
          testHaskellDepends = [
            base
            directory
            doctest
            filepath
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
          version = "0.18.2";
          sha256 = "1r6hsn3am3dpf4rprrj4m04d9318v9iq02bin0pl29dg4a3gzjax";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/semigroups/";
          description = "Anything that associates";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      stack2nix = callPackage ({ Glob, SafeSemaphore, async, base, bytestring, containers, data-fix, directory, filepath, hnix, mkDerivation, monad-parallel, optparse-applicative, process, stdenv, temporary, text, yaml }:
      mkDerivation {
          pname = "stack2nix";
          version = "0.1.0.0";
          src = ./.;
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            async
            base
            bytestring
            containers
            data-fix
            directory
            filepath
            Glob
            hnix
            monad-parallel
            process
            SafeSemaphore
            temporary
            text
            yaml
          ];
          executableHaskellDepends = [
            base
            optparse-applicative
          ];
          doHaddock = false;
          doCheck = false;
          description = "Convert stack.yaml files into Nix build instructions.";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      stm = callPackage ({ array, base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "stm";
          version = "2.4.4.1";
          sha256 = "111kpy1d6f5c0bggh6hyfm86q5p8bq1qbqf6dw2x4l4dxnar16cg";
          revision = "1";
          editedCabalFile = "49cfd80cba95f84d42eda0045346c8a567df5ce434d4da3d26ac3e977826fc4f";
          libraryHaskellDepends = [
            array
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "Software Transactional Memory";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      tagged = callPackage ({ base, deepseq, mkDerivation, stdenv, template-haskell, transformers, transformers-compat }:
      mkDerivation {
          pname = "tagged";
          version = "0.8.5";
          sha256 = "16cdzh0bw16nvjnyyy5j9s60malhz4nnazw96vxb0xzdap4m2z74";
          revision = "1";
          editedCabalFile = "a8d7b211a0831f5acf65a36003aebab7673ffb6a874a49715e05e7b76a6cb896";
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
      template-haskell = callPackage ({ base, ghc-boot-th, mkDerivation, pretty, stdenv }:
      mkDerivation {
          pname = "template-haskell";
          version = "2.11.1.0";
          sha256 = "171ngdd93i9prp9d5a4ix0alp30ahw2dvdk7i8in9mzscnv41csz";
          libraryHaskellDepends = [
            base
            ghc-boot-th
            pretty
          ];
          doHaddock = false;
          doCheck = false;
          description = "Support library for Template Haskell";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      temporary = callPackage ({ base, directory, exceptions, filepath, mkDerivation, stdenv, transformers, unix }:
      mkDerivation {
          pname = "temporary";
          version = "1.2.0.4";
          sha256 = "0qk741yqnpd69sksgks2vb7zi50rglp9m498lzw4sh268a017rsi";
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
          homepage = "http://www.github.com/feuerbach/temporary";
          description = "Portable temporary file and directory support for Windows and Unix, based on code from Cabal";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      text = callPackage ({ HUnit, QuickCheck, array, base, binary, bytestring, deepseq, directory, ghc-prim, integer-gmp, mkDerivation, quickcheck-unicode, random, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2 }:
      mkDerivation {
          pname = "text";
          version = "1.2.2.1";
          sha256 = "0nrrzx0ws7pv4dx9jbc6jm2734al1cr0m6iwcnbck4v2yfyv3p8s";
          libraryHaskellDepends = [
            array
            base
            binary
            bytestring
            deepseq
            ghc-prim
            integer-gmp
          ];
          testHaskellDepends = [
            array
            base
            binary
            bytestring
            deepseq
            directory
            ghc-prim
            HUnit
            integer-gmp
            QuickCheck
            quickcheck-unicode
            random
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/bos/text";
          description = "An efficient packed Unicode text type";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      time = callPackage ({ QuickCheck, base, deepseq, mkDerivation, stdenv, test-framework, test-framework-quickcheck2, unix }:
      mkDerivation {
          pname = "time";
          version = "1.6.0.1";
          sha256 = "1jvzgifkalfypbm479fzxb7yi8d5z00b4y6hf6qjdlpl71pv8sgz";
          libraryHaskellDepends = [
            base
            deepseq
          ];
          testHaskellDepends = [
            base
            deepseq
            QuickCheck
            test-framework
            test-framework-quickcheck2
            unix
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/time";
          description = "A time library";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      time-locale-compat = callPackage ({ base, mkDerivation, old-locale, stdenv, time }:
      mkDerivation {
          pname = "time-locale-compat";
          version = "0.1.1.3";
          sha256 = "1vdcfr2hp9qh3ag90x6ikbdf42wiqpdylnplffna54bpnilbyi4i";
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
      transformers = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "transformers";
          version = "0.5.2.0";
          sha256 = "1qkhi8ssf8c4jnmrw9dzym3igqbzq7h48iisaykdfzdsm09qfh3c";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "Concrete functor and monad transformers";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      transformers-base = callPackage ({ base, mkDerivation, stdenv, stm, transformers, transformers-compat }:
      mkDerivation {
          pname = "transformers-base";
          version = "0.4.4";
          sha256 = "11r3slgpgpra6zi2kjg3g60gvv17b1fh6qxipcpk8n86qx7lk8va";
          revision = "1";
          editedCabalFile = "fb1a305f29cbf6ac182af7e67efaae9fcb9664d8d9606bb8a7f3414ad4c8d7a4";
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
          sha256 = "17yam0199fh9ndsn9n69jx9nvbsmymzzwbi23dck3dk4q57fz0fq";
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
      trifecta = callPackage ({ QuickCheck, ansi-terminal, ansi-wl-pprint, array, base, blaze-builder, blaze-html, blaze-markup, bytestring, charset, comonad, containers, deepseq, directory, doctest, filepath, fingertree, ghc-prim, hashable, lens, mkDerivation, mtl, parsers, profunctors, reducers, semigroups, stdenv, transformers, unordered-containers, utf8-string }:
      mkDerivation {
          pname = "trifecta";
          version = "1.6.2.1";
          sha256 = "1rgv62dlmm4vkdymx5rw5jg3w8ifpzg1745rvs1m4kzdx16p5cxs";
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
          testHaskellDepends = [
            base
            directory
            doctest
            filepath
            parsers
            QuickCheck
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/trifecta/";
          description = "A modern parser combinator library with convenient diagnostics";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      unix = callPackage ({ base, bytestring, mkDerivation, stdenv, time }:
      mkDerivation {
          pname = "unix";
          version = "2.7.2.1";
          sha256 = "1709ip8k1vahy00zi7v7qccw6rr22qrf3vk54h97jxrnjiakc1gw";
          revision = "1";
          editedCabalFile = "3db1b6e8de36a36fc4f979e1045e82554f16c736961fa0392e42b7b3f4decfd4";
          libraryHaskellDepends = [
            base
            bytestring
            time
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/unix";
          description = "POSIX functionality";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      unordered-containers = callPackage ({ ChasingBottoms, HUnit, QuickCheck, base, bytestring, containers, criterion, deepseq, deepseq-generics, hashable, hashmap, mkDerivation, mtl, random, stdenv, test-framework, test-framework-hunit, test-framework-quickcheck2 }:
      mkDerivation {
          pname = "unordered-containers";
          version = "0.2.8.0";
          sha256 = "1a7flszhhgyjn0nm9w7cm26jbf6vyx9ij1iij4sl11pjkwsqi8d4";
          libraryHaskellDepends = [
            base
            deepseq
            hashable
          ];
          testHaskellDepends = [
            base
            ChasingBottoms
            containers
            hashable
            HUnit
            QuickCheck
            test-framework
            test-framework-hunit
            test-framework-quickcheck2
          ];
          benchmarkHaskellDepends = [
            base
            bytestring
            containers
            criterion
            deepseq
            deepseq-generics
            hashable
            hashmap
            mtl
            random
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/tibbe/unordered-containers";
          description = "Efficient hashing-based container types";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      utf8-string = callPackage ({ base, bytestring, mkDerivation, stdenv }:
      mkDerivation {
          pname = "utf8-string";
          version = "1.0.1.1";
          sha256 = "0h7imvxkahiy8pzr8cpsimifdfvv18lizrb33k6mnq70rcx9w2zv";
          revision = "2";
          editedCabalFile = "19d60820611ed14041c63bd240958a652276b68d4ca3cf6042864a166fd227ad";
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
      vector = callPackage ({ QuickCheck, base, deepseq, ghc-prim, mkDerivation, primitive, random, stdenv, template-haskell, test-framework, test-framework-quickcheck2, transformers }:
      mkDerivation {
          pname = "vector";
          version = "0.11.0.0";
          sha256 = "1r1jlksy7b0kb0fy00g64isk6nyd9wzzdq31gx5v1wn38knj0lqa";
          revision = "2";
          editedCabalFile = "2bfafd758ab4d80fa7a16b0a650aff60fb1be109728bed6ede144baf1f744ace";
          libraryHaskellDepends = [
            base
            deepseq
            ghc-prim
            primitive
          ];
          testHaskellDepends = [
            base
            QuickCheck
            random
            template-haskell
            test-framework
            test-framework-quickcheck2
            transformers
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "https://github.com/haskell/vector";
          description = "Efficient Arrays";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      void = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "void";
          version = "0.7.2";
          sha256 = "0aygw0yb1h3yhmfl3bkwh5d3h0l4mmsxz7j53vdm6jryl1kgxzyk";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/ekmett/void";
          description = "A Haskell 98 logically uninhabited data type";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      yaml = callPackage ({ HUnit, aeson, aeson-qq, attoparsec, base, base-compat, bytestring, conduit, containers, directory, filepath, hspec, mkDerivation, mockery, resourcet, scientific, semigroups, stdenv, template-haskell, temporary, text, transformers, unordered-containers, vector }:
      mkDerivation {
          pname = "yaml";
          version = "0.8.22.1";
          sha256 = "0svvh0dg9xmvrdmfzsh18zdw5jmr3dn7l5cvzp8zprs1lvjhlv6x";
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
          testHaskellDepends = [
            aeson
            aeson-qq
            base
            base-compat
            bytestring
            conduit
            directory
            hspec
            HUnit
            mockery
            resourcet
            temporary
            text
            transformers
            unordered-containers
            vector
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://github.com/snoyberg/yaml/";
          description = "Support for parsing and rendering YAML documents";
          license = stdenv.lib.licenses.bsd3;
        }) {};
    };
in
compiler.override {
  initialPackages = (args: self: (hackagePackages args self) // (stackPackages args self));
}


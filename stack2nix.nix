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
          sha256 = "0chhl2113jbahd5gychx9rdqj1aw22h7dyj6z44871hzqxngx6bc";
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
          sha256 = "15p8nbi19mhl3iisngbawmdpvk8paaqq4248fqgan63q1sz13w1q";
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
          sha256 = "186ykl7vxlfgkd2k8k1rq7yzcryzjpqwmn4ci1nn9h6irqbivib5";
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
          sha256 = "11qdfghizww810vdj9ac1f5qr5kdmrk40l6w6qh311bjh290ygwy";
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
          sha256 = "119np67qvx8hyp9vkg4gr2wv3lj3j6ay2vl4hxspkg43ymb1cp0m";
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
          sha256 = "0rpg9j6fy70i0b9dkrip9d6wim0nac0snp7qzbhykjkqlcvvgr91";
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
      abstract-deque = callPackage ({ array, base, containers, mkDerivation, random, stdenv, time }:
      mkDerivation {
          pname = "abstract-deque";
          version = "0.3";
          sha256 = "18jwswjxwzc9bjiy4ds6hw2a74ki797jmfcifxd2ga4kh7ri1ah9";
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
          sha256 = "0q6qsniw4wks2pw6wzncb1p1j3k6al5njnvm2v5n494hplwqg2i4";
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
          sha256 = "1k1ykisf96i4g2zm47c45md7p42c4vsp9r73392pz1g8mx7s2j5r";
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
          sha256 = "1zy5z8pzvh53qkjm0nm3f4rwqfqg3867ck8ncd6mrxpcyvxqqj1p";
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
          sha256 = "0hnifh46g218ih666gha3r0hp8bahcl9aj1rr4jqyw2gykcnb8vs";
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
          sha256 = "061xfz6qany3wf95csl8dcik2pz22cn8iv1qchhm16isw5zjs9hc";
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
          sha256 = "15c0c0vb66y3mr11kcvgjf4h0f7dqg7k1xq7zzq9fy11r7h9i3s5";
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
          sha256 = "025pyphsjf0dnbrmj5nscbi6gzyigwgp3ifxb3psn7kji6mfr29p";
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
          sha256 = "0adgbamyq0mj1l1hdq4zyyllay714bac1wl0rih3fv1z6vykp1hy";
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
          sha256 = "025prsihk5g6rdv9xlfmj0zpa0wa3qjzj5i4ilzvg7f6f3sji8y6";
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
          sha256 = "05vjchyqiy9n275cygffhn0ma7fz7jx52j0dcdm9qm8h9bziymqc";
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
          sha256 = "1qj4fp1ynwg0l453gmm27vgkzb5k5m2hzdlg5rdqi9kf8rqy90yd";
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
          sha256 = "12l55b76bhya9q89mfmqmy6sl5v39b6gzrw5rf3f70vkb23nsv5a";
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
          sha256 = "09dlh2alsx2mw5kvj931yhbj0aw7jmly2cm9xbscm2sf098w35jy";
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
          sha256 = "0452l6zf6fjhy4kxqwv6i6hhg6yfx4wcg450k3axpyj30l7jnq3x";
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
          sha256 = "03mdww5j0gwai7aqlx3m71ldmjcr99jzpkcclzjfclk6a6kjla67";
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
          sha256 = "0jf40m3yijqw6wd1rwwvviww46fasphaay9m9rgqyhf5aahnbzjs";
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
          sha256 = "0l1v4ddjdsgi9nqzyzcxxj76rwar3lzx8gmwf2r54bqan3san9db";
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
          version = "0.0.3";
          sha256 = "06jwanjdd3dw2n6i1c77513abin113f90nsj9vals8krgvq8jnr7";
          revision = "1";
          editedCabalFile = "1abv3p6y527vfg69y8fxvmgfi0mrrcvr1gvi9f0hvnq7vc2zs6jw";
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
          sha256 = "1lsw4dh5vgmfvrx62ns5kmngzlmjzbxkx43x5i2k5qlmzp1pa3hk";
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
          sha256 = "00nqd62cbh42qqqvcl6iv1i9kbv0f0mkiygv4j70wfh5cl86yzxj";
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
          sha256 = "1m33y6p5xldni8p4fzg8fmsyqvkfmnimdamr1xjnsmgm3dkf9lws";
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
          sha256 = "0r0acv47nh75bmf7kjyfvhcwz8f02rn9x0a1l80pzgyczfrsmkmf";
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
          sha256 = "03sl7xs6vk4zxbjszgyjpsppi1cknswg7z7rswz2f0rq62wwpq8r";
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
          sha256 = "1qizg0kxxjqnd3cbrjhhidk5pbbciz0pb3z5kzikjjxnnnhk8fr4";
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
          version = "1.0.2";
          sha256 = "0h3wsjf2mg8kw1zvxc0f9nzchj5kzvza9z0arcyixkd9rkgqq6sa";
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
      cabal2nix = callPackage ({ Cabal, aeson, ansi-wl-pprint, base, bytestring, cabal-doctest, containers, deepseq, directory, distribution-nixpkgs, filepath, hackage-db, hopenssl, hpack, language-nix, lens, mkDerivation, monad-par, monad-par-extras, mtl, optparse-applicative, pretty, process, split, stdenv, text, time, transformers, utf8-string, yaml }:
      mkDerivation {
          pname = "cabal2nix";
          version = "2.7";
          sha256 = "1ypzldvifqm4nv9bwzvm5pfsxxn4mp19z50fpkxk84fhb5pb6nbd";
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
          sha256 = "1qmihf5jafmc79sk52l6gpx75f5bnla2lp62kh3p34x3j84mwpzj";
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
          sha256 = "0v1hclvv0516fnlj5j2izd9xmakl7dshi9cb32iz6dgvzx01qck6";
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
          sha256 = "1rzyr8r9pjlgas5pc8n776r22i0ficanq05ypqrs477jxxd6rjns";
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
      clock = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "clock";
          version = "0.7.2";
          sha256 = "07v91s20halsqjmziqb1sqjp2sjpckl9by7y28aaklwqi2bh2rl8";
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
          sha256 = "115pai560rllsmym76bj787kwz5xx19y8bl6262005nddqwzxc0v";
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
          sha256 = "0zl6gflh7y36y2vypjhqx13nhkk5y3h12c1zj7kjfclrmwnvnwh0";
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
          sha256 = "01haq94kf4jsqrhs6j2kkvxrw4iqhvhnd9rcrqpkdbp1dil493kn";
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
          sha256 = "1swkb9w5vx9ph7x55y51dc0srj2z27nd9ibgn8c0qcl6hx7g9cbh";
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
      cookie = callPackage ({ base, blaze-builder, bytestring, data-default-class, deepseq, mkDerivation, old-locale, stdenv, text, time }:
      mkDerivation {
          pname = "cookie";
          version = "0.4.2.1";
          sha256 = "1r2j518lfcswn76qm6p2h1rl98gfsxad7p7z9qaww84fj28k0h86";
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
          sha256 = "1yr2iyb779znj79j3fq4ky8l1y8a600a2x1fx9p5pmpwq5zq93y2";
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
          version = "0.11.100.1";
          sha256 = "1mpmq8rqlqp3w9r78d4i175l6ibl9kfj5d48awrkk1k4x4w27c2p";
          revision = "1";
          editedCabalFile = "0ywdlxf2y46pi2p502zkqwf6zpiamxg5s2l178xkpjy1r02d9lhg";
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
          sha256 = "1680dxgmnjgj083jhsw3rlljwaw0zqi5099m59x6kwqkxhn1qjpf";
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
      cryptonite-conduit = callPackage ({ base, bytestring, conduit, conduit-extra, cryptonite, memory, mkDerivation, resourcet, stdenv, transformers }:
      mkDerivation {
          pname = "cryptonite-conduit";
          version = "0.2.0";
          sha256 = "0a3nasx5fix5g3vjaq26lg9j4frj27ksifqpz3d0naynkacaxv8m";
          libraryHaskellDepends = [
            base
            bytestring
            conduit
            conduit-extra
            cryptonite
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
          sha256 = "0miyjz8d4jyvqf2vp60lyfbnflx6cj2k8apmm9ly1hq0y0iv80ag";
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
          sha256 = "04k9cmb197majyw6xna8zfkhgfyxfdiz2sgb0jy5jyfpiz3cr60h";
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
          sha256 = "04gy2zp8yzvv7j9bdfvmfzcz3sqyqa6rwslqcn4vyair2vmif5v4";
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
          sha256 = "15m881mrhpqg1xjdjz65ym8pajp1nijrcvb6dx3vv55430cjw1qx";
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
          sha256 = "0y566r97sfyvhsmd4yxiz4ns2mqgwf5bdbp56wgxl6wlkidq0wwi";
          revision = "1";
          editedCabalFile = "0hsq03i0qa0jvw7kaaqic40zvfkzhkd25dgvbdg6hjzylf1k1gax";
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
          sha256 = "0brgai4vs7xz29p06kd6gzg5bpa8iy3k7yzgcc44izspd74q4rw7";
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
          sha256 = "0v75081bx4qzlqy29hh639nzlr7dncwza3qxbzm9njc4jarf31pz";
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
          sha256 = "1vw5ykpwhr39wc0hhcgq3r8dh59zq6ib4zxbz1qd2wl21wqhfkvh";
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
          sha256 = "0v8msqvgzimhs7p5ri25hrb1ni2wvisl5rmdxy89fc59py79b9fq";
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
          sha256 = "1lrlwqqnm6ibfcydlv5qvvssw7bm0c6yypy0rayjzv1znq7wp1xh";
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
          sha256 = "1gl7xzffsqmigam6zg0jsglncgzxqafld2p6kb7ccp9xirzdjsjd";
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
          sha256 = "0w4csmpzj88vkgyngyw4i91f9hfali50xqrqyycr4jh0qyq5sjx4";
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
          sha256 = "18nlj6xvnggy61gwbyrpmvbdkq928wv0wx2zcsljb52kbhddnp3d";
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
          sha256 = "13b7rrv8dw574k6lbl96nar67fx81058gvilsc42v0lgm38sbi6y";
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
          sha256 = "04gpylngm2aalqcgdk7gy7jiw291dala1354spxa8wspxif94lgp";
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
          sha256 = "0g90wgm4bcfr5j44sc5s2jlcd7ggk092lph3jqjgf6f67sqxrw8g";
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
          sha256 = "03vchlbhx9ipjx1w8y4pfc4awb1gjjgr5f95h977lknzb5ad9fx5";
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
          version = "0.0.16";
          sha256 = "1kyczi9lfiwbib9irgz4dzy1h60hv6irxyqba6x48bp6vzylfscr";
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
      fsnotify = callPackage ({ async, base, containers, directory, filepath, hinotify, mkDerivation, stdenv, text, time, unix-compat }:
      mkDerivation {
          pname = "fsnotify";
          version = "0.2.1.1";
          sha256 = "146wsblhfwnbclzffxk6m43bqap3sgw332gs67030z6h5ab7anhp";
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
          sha256 = "1y92q4dmbyc24hjjvq02474s9grwabxffn16y31gzaqhm0m0z5i9";
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
          sha256 = "0cl3lfm6k1h8fxp2vxa6ihfp4v8igkz9h35iwyq2frzm4kdn96d8";
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
          sha256 = "09xza82g45nv3gxmryqd2mns4bm8hr6d7hzr7nqdi6zq46s0lfgq";
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
          sha256 = "0h9wag599x9ysdrgwa643phmpb1xiiwhyh2dix67fji6a5w86yjh";
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
          sha256 = "0ymv2mcrrgbdc2w39rib171fwnhg7fgp0sy4h8amrh1vw64qgjll";
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
      haskell-lexer = callPackage ({ base, mkDerivation, stdenv }:
      mkDerivation {
          pname = "haskell-lexer";
          version = "1.0.1";
          sha256 = "0rj3r1pk88hh3sk3mj61whp8czz5kpxhbc78xlr04bxwqjrjmm6p";
          libraryHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          description = "A fully compliant Haskell 98 lexer";
          license = stdenv.lib.licenses.bsd3;
        }) {};
      hastache = callPackage ({ base, blaze-builder, bytestring, containers, directory, filepath, ieee754, mkDerivation, mtl, process, stdenv, syb, text, transformers }:
      mkDerivation {
          pname = "hastache";
          version = "0.6.1";
          sha256 = "0r5l8k157pgvz1ck4lfid5x05f2s0nlmwf33f4fj09b1kmk8k3wc";
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
          sha256 = "16fzql0s34my9k1ib4rdjf9fhhijkmmbrvi148f865m51160wj7j";
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
          sha256 = "1wnvbal093c207vr68i0zyrxvmb3yyxdr8p7lbw2yy4ari2hi2gc";
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
          sha256 = "1pxbs1k8sizvvz1nn1zv2i5grn0w11s9g09z07w5f80kbz0slcbh";
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
          sha256 = "104d1yd84hclprg740nkz60vx589mnm094zriw6zczbgg8nkclym";
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
          sha256 = "1ssawa6187m0xzn7i5hn154qajq46jlpbvz1s28qk4bigpv38m7k";
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
          version = "1.24.2";
          sha256 = "08ng635m1qylng1khm9nqvfw2wdhljy1q2wi4ly63nfaznx8dysm";
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
          sha256 = "08fg8w38xbhidw3pfn13ag3mnpp3rb1lzp7xpq47cncwv92k46mh";
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
          sha256 = "1pxzr3l8b9640mh904n51nwlr2338wak23781s48a9kzvwf347b0";
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
          sha256 = "0isx9nc59nw8pkh4r6ynd55dghqnzgrzn9pvrq6ail1y5z3knhkn";
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
          sha256 = "1vxl9zazbaapijr6zmcj72j9wf7ka1pirrjbwddwwddg3zm0g5l1";
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
          sha256 = "1lsy71ri0lfvs6w1drwa4p69bcy0nrpb62dah3bg4vqwxfrd82ds";
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
          sha256 = "1zbmf0kkfsw7pfznisi205gh7jd284gfarxsyiavd2iw26akwqwc";
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
          version = "0.5.7.0";
          sha256 = "18zza3smv5fn5clgq2nij0wqnakh950xif9lwlfqbkam5k1flhg2";
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
          sha256 = "0n4mi8z77qaggfyq17z79cl304nf1f4h6gag60v4wjwghvmj7yn1";
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
          sha256 = "1f0yqka43gp7vhv7yr4q6pqr8qw0qq2yh4y2lnayhc876zpw6ng3";
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
          sha256 = "0l7mnvqyppxpnq6ds4a9f395zdbl22z3sxiry1myfs8wvj669vbv";
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
          sha256 = "1lcs521g9lzy9d7337vg4w7q7s8500rfqy7rcifcz6pm6yfgyb8f";
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
          sha256 = "0w5mhak181zi6qr5h2zbcs9ymaqacisp9jwk99naz6s8zz5rq1ii";
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
      language-nix = callPackage ({ Cabal, QuickCheck, base, base-compat, deepseq, lens, mkDerivation, pretty, stdenv }:
      mkDerivation {
          pname = "language-nix";
          version = "2.1.0.1";
          sha256 = "1kqsw0hk03wdn7mszyjgi38nxk1wmhbxfv6di3irrhsaf807657h";
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
          sha256 = "1lkwlnhgpgnsz046mw4qs0fa7h4l012gilrr3nf3spllsy3pnbkl";
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
          sha256 = "1ass00wfa91z5xp2xmm97xrvwm7j5hdkxid5cqvr3xbwrsgpmi4f";
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
          sha256 = "07hnirv6snnym2r7iijlfz00b60jpy2856zvqxh989q0in7bd0hi";
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
          sha256 = "1sv5vabsx332v1lpb6v3jv4zrzvpx1n7yprzd8wlcda5vsc5a6zp";
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
          sha256 = "093jin2yckha0wccswwxqaak2di7fz2v2rid03h1q0pjm4q9vmyk";
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
          sha256 = "0iqagqc3c6b6ihydhc6s7dlibwwf7pr1k9gixls3jikj6hfxzf0p";
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
          sha256 = "1885kc8sgcrv05q2sya4q562gph7hgp1hd66mgy7r1vnnz43zfjf";
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
          sha256 = "0yvaabxs80fbmbg0yc1q7c147ks15bpn6fdq1zc0ay2pp06l06jv";
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
          sha256 = "1fg9cqpp5lswk8ajlq4f41n12c2v2naz179l8dsz6zisjqj4l5l3";
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
          sha256 = "10wz5q85h366g22jijai5g6hpxa22zy2hr33bzidxs4r36gk8zy8";
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
          sha256 = "0qs5alhy719a14lrs7rnh2qsn1146czg68gvgylf4m5jh4w7vwp1";
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
          sha256 = "0cz4ww3vp96crdqrh7w86rzrs7gs8c1z7rq84yxxhbiz28fs4d0y";
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
          sha256 = "0yv4fsi566zrn30j2g5l901lyqgmflhvzy4hji7ikcbh5d45m920";
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
          sha256 = "062c2sn3hc8h50p1mhqkpyv6x8dydz2zh3ridvlfjq9nqimszaky";
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
          sha256 = "0ldrzqy24fsszvn2a2nr77m2ih7xm0h9bgkjyv1l274aj18xyk7q";
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
          sha256 = "0bl4bd6jzdc5zm20q1g67ppkfh6j6yn8fwj6msjayj621cck67p2";
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
      mono-traversable = callPackage ({ base, bytestring, containers, hashable, mkDerivation, split, stdenv, text, transformers, unordered-containers, vector, vector-algorithms }:
      mkDerivation {
          pname = "mono-traversable";
          version = "1.0.2.1";
          sha256 = "0smirpwika7d5a98h20jr9jqg41n7vqfy7k31crmn449qfig9ljf";
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
          sha256 = "1icdbj2rshzn0m1zz5wa7v3xvkf6qw811p4s7jgqwvx1ydwrvrfa";
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
          sha256 = "05j7yh0hh9nxic3dijmzv44kc6gzclvamdph7sq7w19wq57k6pq6";
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
          sha256 = "1kfl2yy97nb7q0j17v96rl73xvi3z4db9bk0xychc76dax41n78k";
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
          sha256 = "1dn092zfqmxfbzln6d0khka4gizzjivf2yja9w9hwb5g9q3pfi1m";
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
          sha256 = "1w27zkvn39kjr9lmw9421y8w43h572ycsfafsb7kyvr3a4ihlgj2";
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
          sha256 = "0l3viphiszvz5wqzg7a45zp40grwlab941q5ay29iyw8p3v8pbyv";
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
          sha256 = "1h9b26s3kfh2k0ih4383w90ibji6n0iwamxp6rfp2lbq1y5ibjqw";
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
          sha256 = "0rna8ir2cfp8gk0rd2q60an51jxc08lx4gl0liw8wwqgh1ijxv8b";
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
          sha256 = "18kcjldpzay3k3309rvb9vqrp5b1gqp0hgymynqx7x2kgv7cz0sw";
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
          version = "0.0.3";
          sha256 = "0zlcvxhx98k1akbv5fzsvwcrmb1rxsmmyaiwkhfrp5dxq6kg0is5";
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
      parsec = callPackage ({ base, bytestring, mkDerivation, mtl, stdenv, text }:
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
          sha256 = "032dgh0ydy4cbvnjhgp0krnqnvlibphvm30gvmqvpxk9l4pmn435";
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
          version = "0.5.13";
          sha256 = "0lbx7swpav3fv2820mfy8p5lis4iivkasq67qf89hj9j2qz30s0r";
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
      path-io = callPackage ({ base, containers, directory, exceptions, filepath, mkDerivation, path, stdenv, temporary, time, transformers, unix-compat }:
      mkDerivation {
          pname = "path-io";
          version = "1.2.2";
          sha256 = "0ipy07jb1d34jisy8khwx1j2p2s4lm2z8dy5siywi1a206fmy9bj";
          revision = "1";
          editedCabalFile = "1r73clpws32ql3wnh6gp9dn4knzxgcgl6j7ihdkmq6ai21bznw6m";
          libraryHaskellDepends = [
            base
            containers
            directory
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
          sha256 = "0vx3sivcsld76058925hym2j6hm3g71f0qjr7v59f1g2afgx82q8";
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
          sha256 = "162sk5sg22w21wqz5qv8kx6ibxp99v5p20g3nknhm1kddk3hha1p";
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
          sha256 = "079r6b1rvvwgagznxwf4j5i29jpqrvnck545ig004v2853r6x2f2";
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
          sha256 = "0wgj8v6wkqvj60klmxlmhgmbl6yp3i425v95p8s45wm96phpzn9l";
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
          sha256 = "1b8n99l2dh4ng1pf86541q5s2is30scnsx3p3vzh0kif9myrk5cy";
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
          sha256 = "0xkz4vdh8cblpl8k2xmqs8vwv2c0vpxdbikcf2dnmzbg9fdvz5wy";
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
      pretty-show = callPackage ({ array, base, filepath, ghc-prim, happy, haskell-lexer, mkDerivation, pretty, stdenv }:
      mkDerivation {
          pname = "pretty-show";
          version = "1.6.13";
          sha256 = "1kbx72ybrpw0kh5zsd2kdw143qykbmd9lgmsvj57659y0k5l7fjm";
          isLibrary = true;
          isExecutable = true;
          enableSeparateDataOutput = true;
          libraryHaskellDepends = [
            array
            base
            filepath
            ghc-prim
            haskell-lexer
            pretty
          ];
          libraryToolDepends = [ happy ];
          executableHaskellDepends = [
            base
          ];
          doHaddock = false;
          doCheck = false;
          homepage = "http://wiki.github.com/yav/pretty-show";
          description = "Tools for working with derived `Show` instances and generic inspection of values";
          license = stdenv.lib.licenses.mit;
        }) {};
      primitive = callPackage ({ base, ghc-prim, mkDerivation, stdenv, transformers }:
      mkDerivation {
          pname = "primitive";
          version = "0.6.2.0";
          sha256 = "1q9a537av81c0lvcdzc8i5hqjx3209f5448d1smkyaz22c1dgs5q";
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
          sha256 = "0pcwjp813d3mrzb7qf7dzkspf85xnfj1m2snhjgnvwx6vw07w877";
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
          sha256 = "0433a2cmximz2jbg0m97h80pvmb7vafjvw3qzjpsncavg38xgaxf";
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
          sha256 = "08k4v7pkgjf30pv5j2dfv1gqv6hclxlniyq2sps8zq4zswcr2xzv";
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
          sha256 = "0nis3lbkp8vfx8pkr6v7b7kr5m334bzb0fk9vxqklnp2aw8a865p";
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
          sha256 = "1gbaa5x4zbvnbklcb0d4q4m8hk6w0gz4s0c4m288czi1nw43dl65";
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
      regex-applicative = callPackage ({ base, containers, mkDerivation, stdenv, transformers }:
      mkDerivation {
          pname = "regex-applicative";
          version = "0.3.3";
          sha256 = "1riv7jqf26lbv4rm54sd6mrx8xdh4dvh4xbzymzdfdw13k6a4nb6";
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
          sha256 = "1ng2qhk4mvpzl8fx91ig7ldv09v9aqdsvn6yl9yjapc6h0ghb4xh";
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
          sha256 = "0y1j4h2pg12c853nzmczs263di7xkkmlnsq5dlp5wgbgl49mgp10";
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
          sha256 = "1h16w994g9s62iwkdqa7bar2n9cfixmkzz2rm8svm960qr57valf";
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
          sha256 = "04mw8b9djb14zp4rdi6h7mc3zizh597ffiinfbr4m0m8psifw9w6";
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
          sha256 = "0i47gmlljz00fwf2qwkrh24hgsyw5sz2npaighx4wxvykf00d390";
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
          sha256 = "0bbalr2n92akwcgdyl5ff45h8d4waamj1lp7ly6mdgda17k4lpm3";
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
          sha256 = "0msnjz7ml0zycw9bssslxbg0nigziw7vs5km4q3vjbs8jpzpkr2w";
          revision = "1";
          editedCabalFile = "1gnz52yrd9bnq4qvd4v9kd00clx0sfbh64phafdq5g2hbk9yrg0v";
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
          sha256 = "006jys6kvckkmbnhf4jc51sh64hamkz464mr8ciiakybrfvixr3r";
          revision = "2";
          editedCabalFile = "049j2jl6f5mxqnavi1aadx37j4bk5xksvkxsl43hp4rg7n53p11z";
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
          sha256 = "1jm9wnb5jmwdk4i9qbwfay69ydi76xi0qqi9zqp6wh3jd2c7qa9m";
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
          sha256 = "0cnbgrvb9byyahb37zlqrj05rj25v190crgcw8wmlgf0mwwxyn73";
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
          sha256 = "0f9qm3f7y0hpxn6mddhhg51mm1r134qkvd2kr8r6192ka1ijbxnf";
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
          sha256 = "14690ahl3iq99hw638qk0bpmkmspghjz2yh8p1nyccli92y23xjm";
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
          sha256 = "0s689w1hh9g8ifl75xhzbv96ir07hwn04b4lgvbxzl8swa9ylir6";
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
          sha256 = "0fmnkvq1ky4dgyh1z2mvdal5pw103irvkf4p9d5x8wyl1nnylhs9";
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
          version = "1.5.1";
          src = fetchgit {
            url = "https://github.com/commercialhaskell/stack.git";
            sha256 = "1plpdxlmfk3i0s89nwi24mbn9wnmaxwjcyrria4l2r1cnz656rz5";
            rev = "aa5003a153504f54051e42a844a0c1c3d7f82163";
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
      stack2nix = callPackage ({ Cabal, Glob, SafeSemaphore, ansi-wl-pprint, async, base, bytestring, cabal2nix, containers, data-fix, directory, distribution-nixpkgs, filepath, hnix, mkDerivation, monad-parallel, optparse-applicative, path, pretty-show, process, regex-pcre, stack, stdenv, temporary, text, time, yaml }:
      mkDerivation {
          pname = "stack2nix";
          version = "0.1.3.1";
          src = ./.;
          isLibrary = true;
          isExecutable = true;
          libraryHaskellDepends = [
            ansi-wl-pprint
            async
            base
            bytestring
            Cabal
            cabal2nix
            containers
            data-fix
            directory
            distribution-nixpkgs
            filepath
            Glob
            hnix
            monad-parallel
            optparse-applicative
            path
            pretty-show
            process
            regex-pcre
            SafeSemaphore
            stack
            temporary
            text
            time
            yaml
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
          sha256 = "111kpy1d6f5c0bggh6hyfm86q5p8bq1qbqf6dw2x4l4dxnar16cg";
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
          sha256 = "0f27sp09yha43xk9q55sc185jyjs5h7gq2dhsyx6bm9kz9dzqi13";
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
          sha256 = "13ihh1n42j9lq2dhkcgisds7bzm7nm4a02abk8vadracn4a7r97c";
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
          sha256 = "1d34n2n9vjngxndkbxcqm07sg4cnaq6rlx013rhyjr3aybwqalhl";
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
          sha256 = "1abxyjkn8xc8d33yhqxy1ki01kpzf4hy55f167qg4vk2ig5kh2p5";
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
          sha256 = "1ap95xphqnrhv64c2a137wqslkdmb2jjd9ldb17gs1pw48k8hrl9";
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
          sha256 = "1da2zz7gqm4xbkx5vpd74dayx1svaxyl145fl14mq15lbb77sxdq";
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
          sha256 = "16cdzh0bw16nvjnyyy5j9s60malhz4nnazw96vxb0xzdap4m2z74";
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
          sha256 = "18qq94j9bm91iswnxq2dm5dws5c7wm4k01q2rpf8py35cf3svnfq";
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
          sha256 = "1wq0rc71mp0lw7pkpcbhglf636ni46xnlpsmx6yz8acmwmqj8xsm";
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
          sha256 = "1y9d0zjs2ls0c574mr5xw7y3y49s62sd3wcn9lhpwz8a6q352iii";
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
          sha256 = "18mzxwkdvjp31r720ai9bnxr638qq8x3a2v408bz0d8f0rsayx1q";
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
          sha256 = "0445r2nns6009fmq0xbfpyv7jpzwv0snccjdg7hwj4xk4z0cwc1f";
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
          sha256 = "0g42h6wnj2awc5ryhbvx009wd8w75pn66bjzsq1z4s3xajd2hbp5";
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
          sha256 = "17b73q0d5r8xixhvdp0hv4ap96l7s3f2y0j5cknp81b1hyinivlz";
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
          sha256 = "1dfb0z42vrmdx579lkam07ic03d3v5y19339a3ca0bwpprpzmihn";
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
          sha256 = "1f56cp6ckcalld5jchv0kxpjkwcsixd7smd0g7r8cg67ppx6m90x";
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
          sha256 = "0cab6hmyii42p157jhm0sd5jzdlxms4ip2ncrmcmc47dl3pxk5gk";
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
          sha256 = "0hzy6hvhvcd6i60vx5cp2b7ggmnnjh9rx4h8bm8xw4grglcaxjnf";
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
          sha256 = "1mki2s821b1zpdn5463qz5vl3kvxxam90iax1n6vznf0d7p4rik5";
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
      tls = callPackage ({ asn1-encoding, asn1-types, async, base, bytestring, cereal, cryptonite, data-default-class, memory, mkDerivation, mtl, network, stdenv, transformers, x509, x509-store, x509-validation }:
      mkDerivation {
          pname = "tls";
          version = "1.3.11";
          sha256 = "00r7zfkdzy7hi6nhzkirp8jjims4kikgjcm3z4a82kw78awqw01z";
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
          sha256 = "11r3slgpgpra6zi2kjg3g60gvv17b1fh6qxipcpk8n86qx7lk8va";
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
      trifecta = callPackage ({ ansi-terminal, ansi-wl-pprint, array, base, blaze-builder, blaze-html, blaze-markup, bytestring, charset, comonad, containers, deepseq, fingertree, ghc-prim, hashable, lens, mkDerivation, mtl, parsers, profunctors, reducers, semigroups, stdenv, transformers, unordered-containers, utf8-string }:
      mkDerivation {
          pname = "trifecta";
          version = "1.6.2.1";
          sha256 = "1rgv62dlmm4vkdymx5rw5jg3w8ifpzg1745rvs1m4kzdx16p5cxs";
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
          sha256 = "04ga6dhsz9x279w3ik2sjphgmr8s6y0wd0bpg37ymn5mxp68lx2r";
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
          sha256 = "09vykw89x981fywy0w1pci2v8zy3ajyjwh9z2n610vjacmd1v03j";
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
          sha256 = "1qdlc9raih8s0m3x8x3n7q3ngh4faw2alv9l78sp6gnx648k0c8i";
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
          sha256 = "1hhqcxvfh906xl9qhqk6wrsd2xc6rkwh5lqgwfizlb2wns7irkkd";
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
          sha256 = "0wxv6s91wpfv2f5x17lwm04fvghcfnmzqw7p65117pr1r6yz5fcj";
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
          sha256 = "1a7flszhhgyjn0nm9w7cm26jbf6vyx9ij1iij4sl11pjkwsqi8d4";
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
          sha256 = "050bimfsc912dh5sb2kjvvdd80ggjhakqq1dbn46cnp98zr8p0rx";
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
          sha256 = "0h7imvxkahiy8pzr8cpsimifdfvv18lizrb33k6mnq70rcx9w2zv";
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
          sha256 = "1zdka5jnm1h6k36w3nr647yf3b5lqb336g3fkprhd6san9x52xlj";
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
          sha256 = "0yrx2ypiaxahvaz84af5bi855hd3107kxkbqc8km29nsp5wyw05i";
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
          sha256 = "0w4hf598lpxfg58rnimcqxrbnpqq2jmpjx82qa5md3q6r90hlipd";
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
          sha256 = "0d82x55f5vvr1jvaia382m23rs690lg55pvavv8f4ph0y6kd91xy";
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
      x509 = callPackage ({ asn1-encoding, asn1-parse, asn1-types, base, bytestring, containers, cryptonite, hourglass, memory, mkDerivation, mtl, pem, stdenv }:
      mkDerivation {
          pname = "x509";
          version = "1.7.2";
          sha256 = "0yyfw07bw73gkh93z653lnncc30wj3g3rf26cwxjpyxvwalia0yw";
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
          sha256 = "1lg9gy0bmzjmlk4gfnzx2prfar1qha4hfjsw8yvjg33zm0fv3ahs";
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
          sha256 = "06a4m9c7vlr9nhp9gmqbb46arf0yj1dkdm4nip03hzy67spdmp20";
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
          sha256 = "005m5jxjz5cx3lriayv4a17xa19qc2qxw7kz2f9wvj7hgjnwww44";
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
          version = "0.8.23.3";
          sha256 = "0hvmxl8krh8m3804d1nrvgmbirvw11a8iy80ciq4rg0csmz5r1fc";
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
          sha256 = "09c3y13r77shyamibr298i4l0rp31i41w3rg1ksnrl3gkrj8x1ly";
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
          sha256 = "1fx2k2qmgm2dj3fkxx2ry945fpdn02d4dkihjxma21xgdiilxsz4";
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


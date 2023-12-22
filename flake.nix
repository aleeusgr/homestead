{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      mako = (with pkgs; stdenv.mkDerivation {
          pname = "mako";
          version = "3.3.1";
          src = fetchgit {
            url = "https://github.com/nzinfo/MakoServer";
            rev = "v3.3.1";
            sha256 = "pBrsey0RpxxvlwSKrOJEBQp7Hd9Yzr5w5OdUuyFpgF8=";
            fetchSubmodules = true;
          };
          nativeBuildInputs = [
            clang
            cmake
          ];
          buildPhase = "make -j $NIX_BUILD_CORES";
          installPhase = ''
            mkdir -p $out/bin
            mv $TMP/LightGBM/lightgbm $out/bin
          '';
        }
      );

    in rec {
      defaultApp = flake-utils.lib.mkApp {
        drv = defaultPackage;
      };
      hello = pkgs.writeShellScriptBin "hello" ''
        DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
        ${pkgs.cowsay}/bin/cowsay Today is $DATE. You are standing west of house. There is a note at the wall.
      '';

      defaultPackage = hello;
      # devShell = pkgs.mkShell {
      #   buildInputs = [
      #     mako
      #   ];
      # };
    }
  );
}

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
          version = "3158b48586e7dcdfe29777181c5274328d96921a";
          src = fetchgit {
            url = "https://github.com/nzinfo/MakoServer";
            rev = "3158b48586e7dcdfe29777181c5274328d96921a";
            sha256 = "SuRn81V4rEHTe/FZzoMfylrEiqgRkbIaYrohWMNR+3Q=";
            fetchSubmodules = false;
            leaveDotGit = false;
            deepClone = false;
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

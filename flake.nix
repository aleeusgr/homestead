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
      #     lightgbm-cli
      #   ];
      # };
    }
  );
}

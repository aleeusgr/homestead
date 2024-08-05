{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

    packages.x86_64-linux.view_note =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "view_note" ''
        ${pkgs.cowsay}/bin/cowsay Note says: help, who, what, where.
      '';

    packages.x86_64-linux.hello =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "hello" ''
        DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
        ${pkgs.cowsay}/bin/cowsay Today is $DATE. You are standing west of house. There is a note at the wall.
      '';

    # The package is a web shell.

    # #5 and #7, lets go to the moon and get it running on an embedded device.  
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [ ({ pkgs, ... }: {
            boot.isContainer = true;

            # Let 'nixos-version --json' know about the Git revision
            # of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

            # Network configuration.
            networking.useDHCP = false;
            networking.firewall.allowedTCPPorts = [ 80 ];

            # Enable a web server.
            services.httpd = {
              enable = true;
              adminAddr = "alexeusgr@gmail.com";
            };
          })
        ];
    };

  };
}

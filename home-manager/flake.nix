{

  description = "gooberlogic's home-manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      user = "nixpad";
      realUser = "goob";
      home = "/home/${realUser}";
    in {
      homeConfigurations."${realUser}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/${user}/home.nix
        ];
        extraSpecialArgs = {
          inherit user;
          inherit realUser;
          inherit home;
        };
      };
    };

}

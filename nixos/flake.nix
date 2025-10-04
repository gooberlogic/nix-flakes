{

  description = "gooberlogic's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    host = "nixpad";
  in
  {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit host;
        };
        modules = [
          ./hosts/${host}/config.nix
        ];
      };
    };
  };

}

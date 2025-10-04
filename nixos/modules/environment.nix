{ config, pkgs, lib, host, ... }:

{

  environment.sessionVariables = rec {
    NO = "$HOME/nix-flakes/nixos/hosts/${host}";
    NOM = "$HOME/nix-flakes/nixos/modules";
  };

}

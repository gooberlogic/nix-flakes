{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    dive
  ];

  virtualisation.docker.enable = true;

}

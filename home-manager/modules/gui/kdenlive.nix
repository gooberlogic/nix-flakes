{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    kdePackages.kdenlive
    kdePackages.mlt
  ];

}

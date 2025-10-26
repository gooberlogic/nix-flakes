{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    #wineWowPackages.stable
    #(wine.override { wineBuild = "wine64"; })
    wineWowPackages.waylandFull
    protontricks
    winetricks
  ];

}

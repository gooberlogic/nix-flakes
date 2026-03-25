{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    #wineWowPackages.stable
    #(wine.override { wineBuild = "wine64"; })
    #wineWow64Packages.stable
    wine
    protontricks
    winetricks
    wineasio
  ];

}

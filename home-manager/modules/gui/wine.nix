{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    wineWow64Packages.waylandFull
    protontricks
    winetricks
    wineasio
  ];

}

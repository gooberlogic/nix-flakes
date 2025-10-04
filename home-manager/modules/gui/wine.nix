{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    #wine64Packages.waylandFull
    wine
    protontricks
    winetricks
    #winePackages.unstableFull
  ];

}

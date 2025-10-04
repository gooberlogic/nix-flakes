{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    plex-desktop 
    plex-mpv-shim
  ];

}

{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    syncthing
  ];

  xdg.desktopEntries.syncthing-nobrowser = {
    name = "Syncthing (No Browser)";
    icon = "syncthing";
    exec = "${pkgs.syncthing}/bin/syncthing --no-browser";
  };

}

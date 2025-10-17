{ config, pkgs, lib, ... }:

{

  services.xserver.desktopManager.mate = {
    enable = true;
    enableWaylandSession = true;
  };

}

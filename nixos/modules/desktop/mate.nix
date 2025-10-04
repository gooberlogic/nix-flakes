{ config, pkgs, lib, ... }:

{

  services.xserver = {
    desktopManager.mate.enable = true;
    desktopManager.mate.enableWaylandSession = true;
  };

}

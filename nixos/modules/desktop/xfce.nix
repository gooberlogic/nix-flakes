{ config, pkgs, lib, ... }:

{

  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    xfce.xfce4-whiskermenu-plugin
    xfce.thunar-archive-plugin
    xarchiver
  ];

}

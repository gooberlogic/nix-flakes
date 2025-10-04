{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-themes-extra
    adwaita-icon-theme
    morewaita-icon-theme
    dconf-editor
    baobab

    simp1e-cursors
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-disk-utility
    gnome-connections
    gnome-software
    gnome-weather
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-tour
    gnome-user-docs
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    baobab
    epiphany
    simple-scan
    snapshot
    totem
    yelp
    orca
    evince
    decibels
    geary

    # file-roller
    # seahorse
    # sushi
    # sysprof
    # gnome-shell-extensions
    # adwaita-icon-theme
    # nixos-background-info
    # gnome-backgrounds
    # gnome-bluetooth
    # gnome-color-manager
    # gnome-control-center
    # gnome-shell-extensions
    # glib # for gsettings program
    # gnome-menus
    # gtk3.out # for gtk-launch program
    # xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
    # xdg-user-dirs-gtk # Used to create the default bookmarks
    # gnome-clocks
    # gnome-console
    # gnome-system-monitor
    # loupe
    # nautilus
  ];

  services.desktopManager = {
    gnome.enable = true;
  };

}

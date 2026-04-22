{ config, pkgs, lib, realUser, home, ... }:

let 
  inherit (import ./vars.nix) specialPkgs;

  extraPkgs = with pkgs; [
    # CLI
    ffmpeg pulsemixer yt-dlp

    # DEV
    nodejs_24

    # GAMES

    # GUI
    feishin joplin-desktop
  ];

  moduleImports = [

    "alias"
    "environment"

    "dev/nvchad"

    "gui/jellyfin"
    "gui/mpv"
    "gui/ungoogled-chromium"
    "gui/wine"

    "settings/disable-recent"
    "settings/gnome"
    
  ];

  modulesDir = ../../modules;
  moduleImportsMap = map (m: modulesDir + "/${m}.nix") moduleImports;

  specialPkgsFix = map (pkg: pkgs.${pkg}) specialPkgs;
in
{

  imports = [] ++ moduleImportsMap;

  programs.home-manager.enable = true;

  # WARNING!
  #nixpkgs.config.permittedInsecurePackages = [
  #  "qtwebengine-5.15.19"
  #];

  # Variables
  home.username = realUser;
  home.homeDirectory = home;

  # Nix Configuration
  nixpkgs.config.allowUnfree = true;
  nix.assumeXdg = true;

  # Packages
  home.packages = with pkgs; [
    waypipe
    wl-clipboard
    dconf
    eza
    git
    git-crypt
  ] ++ extraPkgs ++ specialPkgsFix;

  # Do not change!
  home.stateVersion = "24.11";

}

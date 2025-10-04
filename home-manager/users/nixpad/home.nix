{ config, pkgs, lib, realUser, home, ... }:
let
  inherit (import ./vars.nix) specialPkgs;
in

let 

  extraPkgs = with pkgs; [
    # CLI
    ffmpeg pulsemixer

    # DEV
    nodejs_24

    # GAMES
    heroic

    # GUI
    feishin joplin-desktop
    libreoffice-fresh
  ];

  moduleImports = [

    "alias"
    "environment"

    "dev/nvchad"
    "dev/tmux"

    "gui/brave"
    "gui/jellyfin"
    "gui/mpv"
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
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  # Variables
  home.username = realUser;
  home.homeDirectory = home;

  # Nix Configuration
  nixpkgs.config.allowUnfree = true;

  # Packages
  home.packages = with pkgs; [
    waypipe
    wl-clipboard
    dconf
    eza
  ] ++ extraPkgs ++ specialPkgsFix;

  # Do not change!
  home.stateVersion = "24.11";

}

{ config, pkgs, lib, realUser, home, ... }:

let 
  inherit (import ./vars.nix) specialPkgs;

  extraPkgs = with pkgs; [
    # CLI
    ffmpeg pulsemixer yt-dlp

    # DEV
    godot_4 nodejs_24 insomnia typst

    # GAMES
    gzdoom quake3e qjoypad retroarch-full
    heroic eduke32

    # GUI
    gimp freerdp feishin joplin-desktop
    libreoffice-fresh solfege lingot
  ];

  moduleImports = [

    "alias"
    "environment"

    "cli/vpn-scripts.secret"

    "dev/nvchad"
    "dev/rust"
    "dev/tmux"

    "gui/brave"
    "gui/jellyfin"
    "gui/kdenlive"
    "gui/looking-glass"
    "gui/mpv"
    "gui/obs"
    "gui/syncthing"
    "gui/wine"

    "settings/disable-recent"
    "settings/gnome"
    "settings/kvm"
    "settings/user-dirs.secret"
    
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
    git
    git-crypt
  ] ++ extraPkgs ++ specialPkgsFix;

  # Do not change!
  home.stateVersion = "24.11";

}

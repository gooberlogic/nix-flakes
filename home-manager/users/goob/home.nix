{ config, pkgs, lib, realUser, home, ... }:

let 
  inherit (import ./vars.nix) specialPkgs;

  extraPkgs = with pkgs; [
    # CLI
    ffmpeg pulsemixer yt-dlp rusty-psn
    yq

    # DEV
    godot_4 nodejs_24 insomnia

    # GAMES
    gzdoom quake3e qjoypad eduke32
    rpcs3 dolphin-emu

    # GUI
    gimp feishin joplin-desktop
  ];

  moduleImports = [

    "alias"
    "environment"

    "dev/nvchad"
    "dev/rust"
    "dev/claude"
    #"dev/tmux"

    #"games/heroic"
    "games/retroarch"

    "gui/jellyfin"
    "gui/kdenlive"
    "gui/looking-glass"
    "gui/mpv"
    "gui/obs"
    "gui/syncthing"
    "gui/ungoogled-chromium"
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

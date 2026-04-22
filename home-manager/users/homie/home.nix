{ config, pkgs, lib, realUser, home, ... }:

let 
  inherit (import ./vars.nix) specialPkgs;

  extraPkgs = with pkgs; [
    # CLI

    # DEV

    # GAMES

    # GUI
  ];

  moduleImports = [

    "alias"
    "environment"

    "dev/nvchad"
    
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

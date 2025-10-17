{ config, pkgs, lib, ... }:

let
  kdePkgs = with pkgs.kdePackages; [

    kdeconnect-kde

    kpat
    kmines
    kmahjongg
    ksudoku

    knights
    kblocks
    kshisen
    kigo
    kbreakout
    palapeli
    kapman
    knetwalk
    kreversi
    kolf
    bovo
    ksquares
    knavalbattle
    kdiamond
    kbounce
    katomic
    granatier
    kubrick
    klickety
    kjumpingcube
    konquest
    kollision
    blinken
    ksnakeduel
    kblackbox
    picmi
    kfourinline
    kgoldrunner
    kspaceduel
    kiriki
    lskat
    ksirk
    bomber
    killbots
    khangman
    kanagram
    ktuberling
    skladnik

  ];
in
{

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
    kwallet
    kate
    okular
    khelpcenter
    kwalletmanager
  ];

  environment.systemPackages = with pkgs; [
    vlc
    kde-gruvbox
    gruvbox-plus-icons
    capitaine-cursors-themed
    stockfish
    gnuchess
  ] ++ kdePkgs;

}

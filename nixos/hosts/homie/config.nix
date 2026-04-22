{ config, lib, pkgs, ... }:

let
  inherit (import ./vars.nix) grubDevice grubEfi timezone hostname lang kbLayout kbVariant kbOptions autoOptimize textEditor secret_groups; 

  moduleImports = [

    "alias"
    "environment"

    "networking/network"

    "system/docker"

    "server/cloudflared"
    "server/cron"
    "server/mc-manual"
    "server/samba.secret"
    "server/sysusergen"
    "server/usergen"
    "server/zfs"

  ];

  modulesDir = ../../modules;
  moduleImportsMap = map (m: modulesDir + "/${m}.nix") moduleImports;
in
{

  imports = [ ./hardware.secret.nix ] ++ moduleImportsMap;
  
  # Users and User Groups
  users.groups = {
    goob.gid = 4000;
    # dummy.gid = 4001;
  };

  users.users = {
    goob = {
      home = "/home/goob";
      uid = 4000;
      group = "goob";
      isNormalUser = true;
      shell = pkgs.bash;
      extraGroups = [ "docker" "wheel" ] ++ secret_groups;
    };
    #dummy = {
    #  home = "/home/dummy";
    #  uid = 4001;
    #  group = dummy;
    #  isNormalUser = true;
    #  shell = pkgs.zsh;
    #  extraGroups = [ "users" "wheel" ];
    #};
  };

  # GRUB Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = grubDevice;
  boot.loader.grub.useOSProber = true; 
  boot.loader.grub.efiSupport = grubEfi;
  boot.loader.efi.canTouchEfiVariables = true;

  # NetworkManager
  networking.networkmanager.enable = true;

  # User Settings
  networking.hostName = hostname;
  time.timeZone = timezone;
  i18n.defaultLocale = lang;
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = kbLayout;
    variant = kbVariant;
    options = kbOptions;
  };

  # GNUPG
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Nix Configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = autoOptimize;
  nix.settings.use-xdg-base-directories = true;

  # Hardware
  hardware.enableAllFirmware  = true;

  # AppImages
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fuse.out
  ];

  # Packages  
  environment.systemPackages = with pkgs; [
    neovim
    appimage-run
    wget
    usbutils
    fuse
    htop
    dig 
    jq
    gnupg
    pciutils
    git
    git-crypt
    fastfetch
    openssl
    cifs-utils
    lm_sensors
    ncdu
    killall
    unzip
    xxd
    tree
    p7zip-rar 
    pwgen
    testdisk
    eza
  ];

  # Past overlay for reference
#  nixpkgs.overlays = [ (final: prev:
#    {
#      dmraid = prev.dmraid.overrideAttrs (oA: {
#        patches = oA.patches ++ [
#          (prev.fetchpatch2 {
#            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/f298cd74e67a841289fd0f10ef4ee85cfbbc4133/pkgs/os-specific/linux/dmraid/fix-dmevent_tool.patch";
#            hash = "sha256-MmAzpdM3UNRdOk66CnBxVGgbJTzJK43E8EVBfuCFppc=";
#          })
#        ];
#      });
#    }
#  )];

  # Firewall
  networking.firewall.enable = false; 
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Do not change!
  system.stateVersion = "24.11";

}


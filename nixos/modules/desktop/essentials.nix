{ config, pkgs, lib, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix) mod_essentials_printing mod_essentials_bluetooth;
in
{

  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;

  services.libinput.enable = true;

  services.printing.enable = mod_essentials_printing;
  hardware.bluetooth.enable = mod_essentials_bluetooth;
  hardware.bluetooth.powerOnBoot = mod_essentials_bluetooth;

  services.xserver.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    audio.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    vulkan-tools
    xclip
  ];

}

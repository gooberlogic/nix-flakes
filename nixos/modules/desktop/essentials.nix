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

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 256;
      };
    };

    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "256/48000";
            pulse.default.req = "256/48000";
            pulse.max.req = "256/48000";
            pulse.min.quantum = "256/48000";
            pulse.max.quantum = "256/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "256/48000";
        resample.quality = 1;
      };
    };

  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    vulkan-tools
    xclip
  ];

  fonts.packages = with pkgs; [noto-fonts noto-fonts-cjk-sans noto-fonts-cjk-serif];

}

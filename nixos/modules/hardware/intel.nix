{ config, pkgs, lib, ... }:

{

  # my attempt to get some desktop working on intel computer

  nixpkgs.config = {
    permittedInsecurePackages = [
      "intel-media-sdk-23.2.2"
    ];
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      #vpl-gpu-rt
      vaapiIntel
      #intel-media-sdk
      #onevpl-intel-gpu
      intel-media-driver
      libvdpau-va-gl
      #mesa
      libva
      libva-utils
    ];
  };

}

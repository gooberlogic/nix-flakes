{ config, pkgs, lib, ... }:

{

  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with pkgs.linuxPackages; [
      v4l2loopback
    ];
  };

  environment.systemPackages = with pkgs; [
    v4l-utils
    android-tools
    adb-sync
    droidcam
  ];

}

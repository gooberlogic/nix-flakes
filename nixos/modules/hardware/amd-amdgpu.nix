{ config, pkgs, lib, ... }:

{

  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.blacklistedKernelModules = ["nouveau" "radeon"];
  boot.kernelParams = [
    "radeon.si_support=0"
    "amdgpu.si_support=1"
    "radeon.cik_support=0"
    "amdgpu.cik_support=1"

    # multimonitor and display audio needs these
    "amdgpu.audio=1"
    "amdgpu.dc=1"
    "amdgpu.dpm=1"
  ];
  
  #hardware.graphics.extraPackages32 = with pkgs; [
  #  driversi686Linux.amdvlk
  #];

  hardware.graphics.enable32Bit = true;

  hardware.graphics = {
    enable = true;
  };

}

{ config, pkgs, lib, ... }:

{

  hardware.nvidia-container-toolkit.enable = true;
  
  hardware.nvidia.open = true;

  nixpkgs.config.nvidia.acceptLicense = true;

  services.xserver.videoDrivers = ["nvidia"];

}

{ config, pkgs, lib, ... }:

{

  hardware.nvidia-container-toolkit.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia.open = true;

}

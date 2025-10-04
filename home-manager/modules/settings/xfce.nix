{ config, pkgs, lib, ... }:

{
  
  services.xserver = {
    libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
        };
    };
  };

}

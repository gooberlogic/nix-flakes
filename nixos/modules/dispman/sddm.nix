{ config, pkgs, lib, ... }:

{

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    #theme = "sddm-astronaut-theme";
    extraPackages = [ pkgs.kdePackages.qtmultimedia ];
  };

}

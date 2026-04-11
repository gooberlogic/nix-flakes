{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
     (python314Packages.callPackage ./ds4drv/default.nix {})
     #python314Packages.ds4drv
  ];

  systemd.services.ds4drv = {
    enable = true;
    description = "ds4drv with dualsense pr";
    #wantedBy = [ "bluetooth.target" ];
    wantedBy = lib.mkForce [ ];
    #serviceConfig.DynamicUser = "yes";
    serviceConfig.User = "goob"; # I'm lazy 
    serviceConfig.Group = "goob";
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash -c '${(pkgs.python314Packages.callPackage ./ds4drv/default.nix {})}/bin/ds4drv --hidraw --emulate-xboxdrv'";
  };

}

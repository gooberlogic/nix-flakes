{ config, pkgs, lib, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix) paths;
in
{

  systemd.services.mc = {
    enable = true;
    description = "start minecraft server";
    wantedBy = lib.mkForce [ ];
    serviceConfig.User = "minecraft";
    serviceConfig.Group = "minecraft";
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash -c 'cd ${paths.mc}; ${paths.mc}/java/jdk-23/bin/java -jar ${paths.mc}/fabric-jar.jar'";
  };

}

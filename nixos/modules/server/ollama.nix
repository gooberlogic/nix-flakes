{ config, pkgs, lib, ... }:

{

  # old service I made for some virtual machine gpu setup
  systemd.services.docker-ollama = {
    description = "start ollama";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash -c 'cd /docker/; sleep 10; ${pkgs.docker}/bin/docker compose up -d --force-recreate'";
    # restartPolicy = "on-failure";
  };

}

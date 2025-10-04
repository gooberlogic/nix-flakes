{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    cloudflared
  ];

  #systemd.services."cloudflared".wantedBy = lib.mkForce [ ];
  systemd.services.cloudflared = {
    enable = true;
    description = "Cloudflare Tunnel service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.User = "cloudflared";
    serviceConfig.Group = "cloudflared";
    serviceConfig.ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --config /.cloudflared/config.yml run";
    serviceConfig.WorkingDirectory = "/.cloudflared/";
    serviceConfig.Environment = "PATH=${pkgs.bash}/bin:/usr/bin:/bin";
  };

}

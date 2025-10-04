{ config, pkgs, lib, host, ... }:

{
  
  # just for torsocks
  services.tor = {
    enable = true;
    openFirewall = true;
    relay = {
      enable = true;
      role = "relay";
    };
    settings = {
      ContactInfo = "toradmin@example.org";
      Nickname = "toradmin";
      ORPort = 9001;
      ControlPort = 9051;
      BandWidthRate = "1 MBytes";
      Address = "127.0.0.1";
    };
    client = {
      enable = true;
      dns.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    torsocks
  ];

}

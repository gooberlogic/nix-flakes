{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    strongswan
  ];

  networking.networkmanager = {
    plugins = with pkgs; [
      networkmanager-fortisslvpn
      networkmanager-iodine
      networkmanager-l2tp
      networkmanager-openconnect
      networkmanager-openvpn
      networkmanager-sstp
      networkmanager_strongswan
      networkmanager-vpnc
    ];
  };

  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };

  environment.etc = {
    "strongswan.conf".text = '''';
    "ipsec.secrets".text = ''include /etc/ipsec.d/*.secrets'';
  };

}

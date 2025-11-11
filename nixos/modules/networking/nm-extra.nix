{ config, pkgs, lib, ... }:

{

  # Use nm-applet in case your DE's VPN connection fails with 
  # something like "could not find source connection"

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking.networkmanager = {
    plugins = with pkgs; [
      networkmanager-fortisslvpn
      networkmanager-iodine
      networkmanager-l2tp
      networkmanager-openconnect
      networkmanager-openvpn
      networkmanager-sstp
      networkmanager-strongswan
      networkmanager-vpnc
    ];
  };

  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };

  # services.xl2tpd.enable = true;

  environment.etc = {
    "strongswan.conf".text = '''';
    "ipsec.secrets".text = ''include /etc/ipsec.d/*.secrets'';
  };

}

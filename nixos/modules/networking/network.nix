{ config, pkgs, lib, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix) mod_network_ipv6 mod_network_ssh mod_network_sshPort mod_network_dns;
in
{

  services.openssh.enable = mod_network_ssh;
  services.openssh = {
    ports = [ mod_network_sshPort ];
    settings = {
      PermitRootLogin = "no";
    };
  };

  networking.enableIPv6 = mod_network_ipv6;
  networking.nameservers = [ ] ++ mod_network_dns;

}

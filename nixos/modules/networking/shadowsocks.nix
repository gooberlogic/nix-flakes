{ config, pkgs, lib, host, ... }:

{

  environment.systemPackages = with pkgs; [
    shadowsocks-rust
    badvpn
  ];

}

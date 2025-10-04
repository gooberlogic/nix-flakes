{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    ninja
    cairo 
    cairo.dev
    cmake
    pkg-config
    pkgconf
  ];

}

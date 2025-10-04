{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    android-studio
    cmake
    ninja
    clang
    pkg-configUpstream
  ];

}

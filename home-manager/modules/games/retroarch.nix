{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    (retroarch.withCores (cores: with cores; [
      dolphin
      pcsx2
      mupen64plus
    ]))
  ];

}

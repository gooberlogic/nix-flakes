{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    claude-code
  ];

}

{ config, pkgs, lib, ... }:

{

  programs.bash.bashrcExtra = ''
    np() {
      nix shell "nixpkgs#$1"
    }
  '';

}

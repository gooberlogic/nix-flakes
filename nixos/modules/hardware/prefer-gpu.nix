{ config, pkgs, lib, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix) mod_preferGpu_cardId;
in
{

  services.udev.extraRules = ''
    ENV{DEVNAME}=="/dev/dri/card${mod_preferGpu_cardId}", TAG+="mutter-device-preferred-primary"
  '';

}

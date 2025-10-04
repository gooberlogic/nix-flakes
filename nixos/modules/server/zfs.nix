{ config, pkgs, lib, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix) mod_zfs_extraPools mod_zfs_hostId;
in
{

  environment.systemPackages = with pkgs; [
    zfs
  ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = mod_zfs_extraPools;

  networking.hostId = (builtins.substring 0 8 "${mod_zfs_hostId}");

}

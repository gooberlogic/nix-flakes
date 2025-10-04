{ config, pkgs, lib, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix) mod_kvmGpu_gpu;
in
{

  boot.extraModprobeConfig = "options vfio-pci ids=${mod_kvmGpu_gpu}";

}

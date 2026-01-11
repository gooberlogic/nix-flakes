{ config, pkgs, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix ) mod_kvm_interface mod_kvm_cpu;
in
{

  environment.systemPackages = with pkgs; [
    gnutls.out
    evtest
  ];

  networking = {
    interfaces.br0.useDHCP = true;
    bridges = {
      "br0".interfaces = [ mod_kvm_interface ];
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  boot = {
    kernelParams = [ "${mod_kvm_cpu}_iommu=on" ];
    kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
  };

}

let
  inherit (import ./vars.secret.nix) secret_groups secret_grubDevice secret_dns secret_sshPort secret_gpu secret_hostId secret_extraPools secret_jobs secret_paths secret_users secret_interface;
in
{

  # format: variableScope_moduleName_variableName 


  # NOTICE: for efi only (and no "BIOS boot" partition) set grubDevice to "nodev"
  grubDevice = secret_grubDevice;
  grubEfi = false;
  hostname = "homie";
  autoOptimize = true;
  textEditor = "nvim"; 
  paths = secret_paths;

  timezone = "America/New_York";
  lang = "en_US.UTF-8";
  kbLayout = "us";
  kbVariant = ""; # colemak_dh
  kbOptions = ""; # caps:swapescape


  # user 
  mod_user_name = "goob";
  mod_user_id = 4000;
  mod_user_groups = [ "docker" ] ++ secret_groups;
  
  # desktop/essentials 
  mod_essentials_printing = true;
  mod_essentials_bluetooth = true;
  
  # gaming/kvm-gpu 
  mod_kvmGpu_gpu = secret_gpu;

  # hardware/nvidia
  mod_nvidia_open = false;
  mod_nvidia_stable = false;

  # hardware/prefer-gpu
  mod_preferGpu_cardId = "1"; # ls -lA /dev/dri/by-path/*
  
  # networking/network 
  mod_network_ipv6 = false; 
  mod_network_ssh = true;
  mod_network_sshPort = secret_sshPort;
  mod_network_dns = secret_dns;

  # server/cron
  mod_cron_jobs = secret_jobs;

  # server/sysusergen
  # Rearranging may require manually fixing /etc/passwd & /etc/group
  mod_sysUserGen_users = secret_users.sysUserGen;
  mod_sysUserGen_startId = 4500;
  
  # server/usergen
  # Rearranging may require manually fixing /etc/passwd & /etc/group
  mod_userGen_users = secret_users.userGen;
  mod_userGen_startId = 5000;

  # server/zfs
  mod_zfs_hostId = secret_hostId; # cat /etc/machine-id
  mod_zfs_extraPools = secret_extraPools;

  # system/kvm
  mod_kvm_interface = secret_interface;
  mod_kvm_cpu = "amd";

}

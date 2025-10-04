{ config, pkgs, lib, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix) mod_cron_jobs;
  updatedJobs = map (job:
    builtins.replaceStrings ["__BASH_PATH__"] [ "${pkgs.bash}" ] job 
  ) mod_cron_jobs;
in
{

  services.cron = {
    enable = true;
    systemCronJobs = updatedJobs;
  };

}

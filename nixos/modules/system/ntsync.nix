{ config, pkgs, lib, ... }:

{

  boot = {
    kernelModules = [
      "ntsync"
    ];
  };

}

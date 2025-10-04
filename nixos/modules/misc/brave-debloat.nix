{ config, pkgs, lib, ... }:

{

  environment.etc = {
    # https://github.com/MulesGaming/brave-debloatinator
    "brave/policies/managed/debloat.json".text = builtins.readFile(builtins.fetchurl {
      url = "https://raw.githubusercontent.com/MulesGaming/brave-debloatinator/refs/heads/main/policies.json"
    });
  };

}

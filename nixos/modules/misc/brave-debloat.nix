{ config, pkgs, lib, ... }:

{

  environment.etc = {
    "brave/policies/managed/debloat.json".text = builtins.readFile(builtins.fetchurl {
      url = "https://raw.githubusercontent.com/MulesGaming/brave-debloatinator/refs/heads/main/policies.json";
      sha256 = "15vfdly7zm0mpn7sb7yiykka1aici5cbm9hnsf7gbw3j744r0bbi";
    });
  };

}

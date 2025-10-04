{ config, pkgs, lib, host, ... }:

let
  inherit (import ../hosts/${host}/vars.nix) mod_user_name mod_user_id mod_user_groups;
in
{

  users.groups.${mod_user_name}.gid = mod_user_id;
  users.users.${mod_user_name} = {
    home = "/home/${mod_user_name}";
    uid = mod_user_id;
    group = mod_user_name;
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = [ "users" "wheel" ] ++ mod_user_groups;
  };

}

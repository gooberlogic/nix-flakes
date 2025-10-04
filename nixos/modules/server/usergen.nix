{ pkgs, lib, host, ... }:

let
  inherit (import ../../hosts/${host}/vars.nix) mod_userGen_users mod_userGen_startId;
in
{

  users.users = builtins.listToAttrs (map (user: lib.nameValuePair user {
    isSystemUser = true;
    uid = (mod_userGen_startId + (lib.lists.findFirstIndex (x: x == user) null mod_userGen_users));
    shell = pkgs.bash;
    group = user;
    extraGroups = [];
  }) mod_userGen_users);
  users.groups = builtins.listToAttrs (map (user: lib.nameValuePair user {
    gid = (mod_userGen_startId + (lib.lists.findFirstIndex (x: x == user) null mod_userGen_users));
  }) mod_userGen_users);

}

#users.groups.${name}.gid = id;
#users.users.${name} = {
#   uid = id;
#   group = name;
#   isSystemUser = true;
#   shell = pkgs.bash;
#   extraGroups = [];
#};

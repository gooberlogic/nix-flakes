{ config, pkgs, lib, home, ... }:

let
  files = [
    "recently-used.xbel"
    "user-places.xbel"
    "user-places.xbel.bak"
    "user-places.xbel.tbcache"
  ];

  attr = file: {
    name = "${home}/.local/share/${file}";
    value.text = '''';
    value.force = true;
  };
in
{

  home.file = builtins.listToAttrs (builtins.map attr files);

}

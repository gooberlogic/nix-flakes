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
  };
in
{

  home.file = builtins.listToAttrs (builtins.map attr files);

}

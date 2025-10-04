{ config, pkgs, lib, home, ... }:

{

  # could probably use a for loop or something, oh well...
  
  home.file."${home}/.local/share/recently-used.xbel" = {
    text = '''';
  };

  home.file."${home}/.local/share/user-places.xbel" = {
    text = '''';
  };

  home.file."${home}/.local/share/user-places.xbel.bak" = {
    text = '''';
  };

  home.file."${home}/.local/share/user-places.xbel.tbcache" = {
    text = '''';
  };

}

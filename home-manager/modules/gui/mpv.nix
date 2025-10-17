{ config, pkgs, lib, home, ... }:

{

  home.packages = with pkgs; [
    mpv
  ];

  home.file."${home}/.config/mpv/mpv.conf".text = ''
    vo=gpu
    #hwdec=auto
    profile=gpu-hq
    keep-open=always
    volume=50
    autofit-larger=1600x900
  '';

  home.file."${home}/.config/mpv/scripts/autoload.lua".text = builtins.readFile(builtins.fetchurl {
    url = "https://raw.githubusercontent.com/mpv-player/mpv/refs/heads/master/TOOLS/lua/autoload.lua";
    sha256 = "0m441dvhkqw18jh1q71ygmh09a3h7jcp33m4nbxfp26cmkr286dv";
  });

  xdg.mimeApps.defaultApplications = {
    "video/*" = ["mpv.desktop"];
    "audio/*" = ["mpv.desktop"];
  };

}

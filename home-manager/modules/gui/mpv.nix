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
    "video/mp4" = ["mpv.desktop"];
    "video/webm" = ["mpv.desktop"];
    "video/ogg" = ["mpv.desktop"];
    "video/x-matroska" = ["mpv.desktop"];
    "video/avi" = ["mpv.desktop"];
    "video/mpeg" = ["mpv.desktop"];
    "video/quicktime" = ["mpv.desktop"];
    "video/x-flv" = ["mpv.desktop"];
  
    "audio/*" = ["mpv.desktop"];
    "audio/mpeg" = ["mpv.desktop"];
    "audio/x-wav" = ["mpv.desktop"];
    "audio/ogg" = ["mpv.desktop"];
    "audio/flac" = ["mpv.desktop"];
    "audio/x-flac" = ["mpv.desktop"];
    "audio/mp3" = ["mpv.desktop"];
    "audio/aac" = ["mpv.desktop"];
    "audio/x-aac" = ["mpv.desktop"];
    "audio/pcm" = ["mpv.desktop"];
    "audio/x-ogg" = ["mpv.desktop"];
  };

}

{ config, pkgs, lib, home, ... }:

{

  home.packages = with pkgs; [
    looking-glass-client
  ];

  home.file."${home}/.config/looking-glass/client.ini".text = ''
    [spice]
    enable=yes
    audio=yes
    input=yes
    clipboard=no
    scaleCursor=no
    showCursorDot=no

    [input]
    escapeKey=88

    [audio]
    syncVolume=no
    
    [win]
    fullScreen=yes
    maximize=yes
    showFPS=yes
    size=1920x1080
    
    [app]
    renderer=EGL
  '';

  home.shellAliases.looking-glass-perm = "sudo chmod 755 /dev/shm/looking-glass; sudo chown $USER:root /dev/shm/looking-glass";

}

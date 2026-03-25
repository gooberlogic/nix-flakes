{ config, pkgs, lib, home, ... }:

{

  home.file."${home}/.local/bin/bottles-setup_link" = {
    onChange = ''
      cat ~/.local/bin/bottles-setup_link > ~/.local/bin/bottles-setup
      rm ~/.local/bin/bottles-setup_link
      chmod +x ~/.local/bin/bottles-setup
    '';
    force = true;
    text = ''
      #!/usr/bin/env bash
      
      STEAM_PREFIX_PATH="$HOME/.local/share/Steam/steamapps/compatdata/0/pfx/drive_c/windows"
      
      if ! command -v yq &> /dev/null; then echo "yq is not installed, please install it."; exit 1; fi
      
      echo "copying libvdk dll's from steam..."
      cp -v $STEAM_PREFIX_PATH/system32/libvkd3d* ./windows/system32/
      cp -v $STEAM_PREFIX_PATH/syswow64/libvkd3d* ./windows/syswow64/
      
      # uncomment if 32 bit prefix
      #cp -v $STEAM_PREFIX_PATH/syswow64/libvkd3d* ./windows/system32/
      
      echo "setting yaml..."
      
      yq -y -i '
      .Parameters.sync = "fsync" |
      .Parameters.wayland = true |
      .Parameters.sandbox = true |
      .Sandbox.share_net = false |
      .Sandbox.share_sound = true |
      .Environment_Variables.WINENTSYNC = "1" |
      .Environment_Variables.DXVK_HUD = "fps" |
      .Environment_Variables.PROTON_DISABLE_LSTEAMCLIENT= "1"
      ' ../bottle.yml
      
      echo "Complete! Please relaunch bottles to see config changes."
    '';
  };

}

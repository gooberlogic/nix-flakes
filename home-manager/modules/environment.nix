{ config, pkgs, lib, user, home, ... }:

let
  inherit (import ../users/${user}/vars.nix ) minimalText mod_environment_ps1Color mod_environment_textEditor mod_environment_openWebUiKey;
  shellPs = if minimalText then "$ " else "\\[\\e[${mod_environment_ps1Color}m\\]\\u@\\h:\\w\\[\\e[m\\] ";
in
{

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      PS1='${shellPs}'
    '';
    historyFile = "${home}/.local/share/bash_history";
    historyFileSize = 25;
  };

  home.sessionVariables = rec {

    EDITOR = "${mod_environment_textEditor}";
    PATH = "${home}/.local/share/cargo/bin:${home}/.local/bin:${home}/.nix-profile/bin:${home}/.local/state/nix/profile/bin:$PATH";
    HM = "${home}/nix-flakes/home-manager/users/${user}";
    HMM = "${home}/nix-flakes/home-manager/modules";
    OPENWEBUI_API_KEY = "${mod_environment_openWebUiKey}";

    # Cleanups https://wiki.archlinux.org/title/XDG_Base_Directory#Supported
    XDG_CONFIG_HOME = "${home}/.config";
    GTK2_RC_FILES = "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    XMONAD_CONFIG_DIR = "${XDG_CONFIG_HOME}/xmonad";
    DOCKER_CONFIG = "${XDG_CONFIG_HOME}/docker";
    WGETRC = "${XDG_CONFIG_HOME}/wgetrc";

    XDG_DATA_HOME = "${home}/.local/share";
    GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
    PASSWORD_STORE_DIR = "${XDG_DATA_HOME}/pass";
    WINEPREFIX = "${XDG_DATA_HOME}/wineprefixes/default";
    CARGO_HOME = "${XDG_DATA_HOME}/cargo";
    RUSTUP_HOME = "${XDG_DATA_HOME}/rustup";
    MINETEST_USER_PATH = "${XDG_DATA_HOME}/luanti";
    NODE_REPL_HISTORY = "${XDG_DATA_HOME}/node_repl_history";

    XDG_STATE_HOME = "${home}/.local/state";

    XDG_CACHE_HOME = "${home}/.cache";
    CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";

  };

}

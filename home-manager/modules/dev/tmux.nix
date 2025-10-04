{ config, pkgs, lib, ... }:

{

  programs.tmux = {
    enable = true;
    clock24 = false;
    # https://github.com/SylvanFranklin/.config/blob/main/tmux/tmux.conf
    # https://unix.stackexchange.com/a/118381
    # https://askubuntu.com/a/978994
    extraConfig = ''
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      set -a terminal-features "tmux-256color:RGB"
      set -g renumber-windows on   
      set -g mode-keys vi
      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-style "bg=default"
      set -g window-status-current-style "fg=blue bold"
      
      set -g status-interval 5
      set -g status-right '#{?client_prefix, _ ,}#(timew | awk "/^ *Total/ {print \$NF}") #[bg=green,fg=black,bold]#(timew | awk "/^ *Tracking/ {print \" \" \$NF \" \"}")#[bg=default]'
      set -g status-left "#S"
      
      bind r source-file "~/.config/tmux/tmux.conf"

      set -g lock-command vlock
      set -g lock-after-time 0 # Seconds; 0 = never
      bind L lock-session

      set -g mouse off
      set -g base-index 1
      setw -g pane-base-index 1
    '';
    plugins = with pkgs.tmuxPlugins; [
      resurrect
    ];
  };

  home.packages = with pkgs; [
    vlock
  ];

}

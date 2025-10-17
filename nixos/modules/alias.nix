{ config, pkgs, lib, ... }:

{

  programs.bash.shellAliases = {
    ls = "ls --group-directories-first --color=auto -lhA --time-style=\"+%m/%d/%y %I:%M %p\"";
    lsblk = "lsblk -o NAME,FSTYPE,PARTLABEL,LABEL,MOUNTPOINT,TYPE,TRAN,SIZE,MODEL,VENDOR";

    no-rebuild = "sudo nixos-rebuild switch --flake ~/nix-flakes/nixos/";
    no-rebuild-boot = "sudo nixos-rebuild boot --flake ~/nix-flakes/nixos/";
    no-clean = "sudo nix-collect-garbage -d; nix-store --optimise";
    no-sync = "d=\$(pwd); cd ~/nix-flakes/nixos; git branch; read -p \"Specify branch [des-nixos]: \" branch; branch=\${branch:-des-nixos}; echo; git fetch origin; git restore --source=origin/\$branch --staged --worktree modules; cd \"\$d\"";

    nix-locate="nix run github:nix-community/nix-index-database";

    sudoes = "sudo -E bash";
    sudoe = "sudo -E";
  };

}

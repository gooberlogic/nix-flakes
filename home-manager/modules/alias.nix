{ config, pkgs, lib, user, ... }:

let
  inherit (import ../users/${user}/vars.nix ) minimalText paths mod_alias_sshHosts mod_alias_rdpHosts;
  lsCommand = if minimalText then "ls -Ah --group-directories-first --color=auto" else "exa -lga --group-directories-first --time-style=relative --time=modified";
in
{
  
  imports = [
    ./functions/mount-cifs.nix
    ./functions/mount-game.nix
  ];

  home.shellAliases = {
    ls = lsCommand; 

    # git
    git-me = "read -p 'Username: ' gmuser; read -p 'Email: ' gmemail; git config user.email \"$gmemail\"; git config user.name \"$gmuser\"";
    git-cred-store = "git config --global credential.helper store";
    git-cred-unset = "git config --global --unset credential.helper";

    # home-manager
    hm-clean = "nix-collect-garbage -d; nix-store --optimise";
    hm-rebuild = "home-manager switch --flake ~/nix-flakes/home-manager/";
    hm-sync = "d=\$(pwd); cd ~/nix-flakes/home-manager; git branch; read -p \"Specify branch [des-nixos]: \" branch; branch=\${branch:-des-nixos}; echo; git fetch origin; git restore --source=origin/\$branch --staged --worktree modules; cd \"\$d\"";

    # ssh
    ssh1 = "waypipe -n ssh ${mod_alias_sshHosts.server}";
    ssh1-env = "ssh ${mod_alias_sshHosts.server} 'cat ${paths.docker}/*/.env | grep PASS'";
    ssh-key = "ssh-keygen -t ed25519";

    # quick cd
    cd1 = "cd ${paths.docker}/";

    # docker
    d-up= "docker compose up -d --force-recreate";
    d-logs = "docker compose logs";
    d-down = "docker compose down";
    j-logs = "sudo journalctl -u";
    d-exec = "docker exec -it";
    d-pull = "docker compose pull --ignore-pull-failures --ignore-buildable";

    # rdp
    rdp1 = "xfreerdp /v:${mod_alias_rdpHosts.vm0} /dynamic-resolution /sound";
    rdp2 = "xfreerdp /v:${mod_alias_rdpHosts.vm1} /dynamic-resolution /sound";

    # misc
    lsblk = "lsblk -o NAME,FSTYPE,PARTLABEL,LABEL,MOUNTPOINT,TYPE,TRAN,SIZE,MODEL,VENDOR";
    density = "find -type f -exec dirname {} \\; | sort | uniq -c | sort -n";
    venv = "source ./.venv/bin/activate";
    pass-here = "export PASSWORD_STORE_DIR=$PWD";
    wine-here = "export WINEPREFIX=$PWD";
    yt-dlp = "yt-dlp -S 'vcodec:avc,res,acodec:aac'";
    yt-dlp-archive = "yt-dlp -f '[height<=1080][fps<=30]' -S 'vcodec:avc,res,acodec:acc' -o '%(upload_date)s - %(title)s.%(ext)s' --download-archive ./archive.txt --write-description --write-info-json --write-sub --write-auto-sub --write-thumbnail";
    sensors-watch = "bash -c 'while true; do clear; sensors; sleep \$0; done'";
  };

}

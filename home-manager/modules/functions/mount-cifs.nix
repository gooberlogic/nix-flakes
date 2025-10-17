{ config, pkgs, lib, ... }:

{

  programs.bash.bashrcExtra = ''
    mount_cifs() {
      if [ "$#" -ne 2 ]; then
          echo "Usage: mount_cifs <smb_share> <mount_dir>"
          return 1
      fi

      smb_share=$1
      mount_dir=$2

      mkdir -p "$mount_dir"

      sudo mount -t cifs "$smb_share" "$mount_dir" -o username="$USER",vers=3.0,uid=$(id -u),gid=$(id -g)
    }
  '';

}

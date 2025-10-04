{ config, pkgs, lib, ... }:

{

  programs.bash = {
    bashrcExtra = ''
      mount_game() {
        if [ "$#" -ne 3 ]; then
            echo "Usage: mount_game <smb_share> <mount_dir> <game_name>"
            return 1
        fi

        smb_share="$1"
        mount_dir="$2"
        game_name="$3"

        full_share_url="$smb_share/$game_name"

        echo "Unmounting anything at $mount_dir..."
        eval "sudo umount -lf $mount_dir"

        echo "Mounting game share $full_share_url..."
        mount_command="sudo mount -t cifs -o username=root,file_mode=0777,dir_mode=0777 '$full_share_url' '$mount_dir'"
        echo $mount_command
        eval $mount_command
      }
    '';
  };

}

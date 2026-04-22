{ config, pkgs, lib, ... }:

{

  programs.bash.bashrcExtra = ''
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

      SUDO_USER=$(whoami | awk '{print $1}')

      echo "Mounting game share $full_share_url..."
      mount_command="sudo mount -t cifs -o username=$SUDO_USER,file_mode=0777,dir_mode=0777 '$full_share_url' '$mount_dir'"
      echo -e "\n$mount_command\n"
      eval $mount_command
    }
  '';

}

{ config, pkgs, lib, home, ... }:

{

  home.file."${home}/.local/bin/bottles-move_link" = {
    onChange = ''
      cat ~/.local/bin/bottles-move_link > ~/.local/bin/bottles-move
      rm ~/.local/bin/bottles-move_link
      chmod +x ~/.local/bin/bottles-move
    '';
    force = true;
    text = ''
      #!/usr/bin/env bash
      
      if ! command -v yq &> /dev/null; then echo "yq is not installed, please install it."; exit 1; fi

      if ! [[ -f ./bottle.yml ]]; then echo "bottle.yml not found, please run this script in a bottle."; exit 1; fi
      
      prompt() {
        read -rp "All files in this bottle will be moved to the above directory, continue? (y/N): " answer && [[ "$answer" == [yY] ]] || exit 1
      }

      bottles_dir="$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles"
      bottle="$(basename "$PWD")"
      
      echo "NOTICE: please close bottles application before continuing!"
      
      echo "Specify directory to move bottle to (example: /mnt/hdd/bottles)"
      read -p ":" dir
      
      if [[ "$dir" != "" ]]; then
        echo "Using specified directory..."
        dir="$dir/$bottle"
        echo -e "\n$dir\n"
        prompt
      
        # scary stuff
        mkdir -p "$dir" && \
          yq -i -Y '.Custom_Path = true' bottle.yml && \
          sed -i "s#$PWD#$dir#g" bottle.yml && \
          yq -i -Y '''.Path' = "'$dir'"' bottle.yml && \
          shopt -s dotglob && \
          mv -v * $dir && \
          shopt -u dotglob && \
          echo "Path: $dir" > "$bottles_dir/$bottle/placeholder.yml" && \
          echo "Created $bottles_dir/$bottle/placeholder.yml"
      
        echo -e "\nDone, make sure bottles can access the directory you moved it to!"
      
      else
        echo "Assuming default bottles directory..."
        dir="$bottles_dir/$bottle"
        if ! [[ -f "$dir/placeholder.yml" ]]; then echo 'No placeholder.yml in default directory, something is wrong here.'; exit 1; fi
        echo -e "\n$dir\n"
        prompt
      
        # scary stuff
        yq -i -Y '.Custom_Path = false' bottle.yml && \
          sed -i "s#$PWD#$dir#g" bottle.yml && \
          yq -i -Y '''.Path' = "'$bottle'"' bottle.yml && \
          shopt -s dotglob && \
          mv -v * $dir && \
          shopt -u dotglob && \
          rm -v $dir/placeholder.yml
      
        echo -e "\nDone, moved back to default directory."
      
      fi
    '';
  };

}

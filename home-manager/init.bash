#!/usr/bin/env bash
cd "$(dirname "$0")"

func () {

  read -p "What config username you want? (no spaces or special chars) " userName
  
  if [ -d "./users/$userName" ]; then
    echo "Directory already exists in ./users, stopping script."
    exit 1
  fi
  
  echo "Changing user variable in flake.nix to \"$userName\"..."
  sed -i "s/user = \"[^\"]*\";/user = \"$userName\";/" ./flake.nix 
  
  echo "Changing realUser variable in flake.nix to \"$USER\"..."
  sed -i "s/realUser = \"[^\"]*\";/realUser = \"$USER\";/" ./flake.nix 
  
  echo -e "Copying default user directory to your username...\n"
  cp -r ./users/goob ./users/"$userName"
  
  echo "Generated ./users/$userName"
  echo "Please edit your new configuration and switch to it when finished:"
  echo -e "\nhome-manager --flake . switch"
  
  git add .

}

mkdir -p ./log

func |& tee ./log/init.log

echo -e "\nLog saved to ./log/init.log"

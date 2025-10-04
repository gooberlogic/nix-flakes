#!/usr/bin/env bash
cd "$(dirname "$0")"

func () {

  read -p "What system hostname you want? (no spaces or special chars) " hostname
  
  if [ -d "./hosts/$hostname" ]; then
    echo "Directory already exists in ./hosts, stopping script."
    exit 1
  fi
  
  echo "Changing host variable in flake.nix to \"$hostname\"..."
  sed -i "s/host = \"[^\"]*\";/host = \"$hostname\";/" ./flake.nix 
  
  echo "Copying default hosts directory to your hostname..."
  cp -r ./hosts/nixos ./hosts/"$hostname"
  
  echo "Changing hostname variable in ./hosts/$hostname/vars.nix to \"$hostname\"..."
  sed -i "s/hostname = .*/hostname = \"$hostname\";/" ./hosts/"$hostname"/vars.nix
  
  echo -e "Generating hardware.secret.nix from current nix hardware config...\n"
  nixos-generate-config --show-hardware-config > ./hosts/"$hostname"/hardware.secret.nix
  
  echo "Generated ./hosts/$hostname"
  echo "Please edit your new configuration and switch to it when finished:"
  echo -e "\nsudo nixos-rebuild --flake .#$hostname boot --show-trace"
  
  echo -e "\n(also, check that hardware.secret.nix looks right, it might differ from hardware-configuration.nix)"
  
  git add .

}

mkdir -p ./log

func |& tee ./log/init.log

echo -e "\nLog saved to ./log/init.log"

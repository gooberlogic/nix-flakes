#!/usr/bin/env bash
cd "$(dirname "$0")"

func () {
  git branch; read -p "Specify branch [des-nixos]: " branch; branch=${branch:-des-nixos}; echo

  for dir in ./users/*/; do
    if [[ -d "$dir" && "$dir" == *.old/ ]]; then
      echo "Please remove any directories in ./users that end with .old"
      exit 1
    fi
  done
  
  echo "This script will do the following:"
  echo " - Add a \".old\" extension to directories in ./users"
  echo " - Discard all local changes outside ./users"
  echo -e " - Update to the latest commit on selected branch\n"
  
  read -p "Type \"YES PLEASE\" to continue: " input
  
  if [ "$input" != "YES PLEASE" ]; then
    exit 1
  fi
  
  echo -e "\nRenaming directories..."
  for dir in ./users/*/; do
  
    if [[ "$(basename "$dir")" == "goob" ]]; then
      continue
    fi
  
    new_dir="${dir%/}.old"
    mv "$dir" "$new_dir"
    echo "Renamed $dir to $new_dir"
    git rm -r --cached "$dir"
  done
  
  echo -e "\nReverting any local changes..."
  
  git fetch origin
  git restore --source=origin/$branch --staged --worktree .
  
  echo -e "\nUpdate completed!"
  echo "Run ./init.bash and copy changes from .old to the new user"

}

mkdir -p ./log

func |& tee ./log/update.log

echo -e "\nLog saved to ./log/update.log"

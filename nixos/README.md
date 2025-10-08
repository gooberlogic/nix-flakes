## NixOS flake 

#### Flake Install

`git clone` if you haven't already:

```bash
cd ~ # keep repo in home folder
git clone https://github.com/gooberlogic/nix-flakes.git
```

Install the base configuration:

```bash
cd ./nix-flakes/nixos
git-crypt unlock
sudo nixos-rebuild --flake .#nixos boot --show-trace
```

Reboot your system.

### Branch Creation

Start with `origin/des-nixos`, then create a new git branch with example naming scheme: 
```bash
git checkout --orphan des-gaming
# or
git checkout --orphan lap-thinkpad
# or
git checkout --orphan srv-pihole
```

Execute `init.bash` and do as it says on screen:

```bash
bash ./init.bash
```

### Syncing Branch

Use this alias to sync the modules directory to a specified branch:

```bash
no-sync
```

Use this to wipe changes back to a specified branch, while preserving host configs:

```bash
bash ./update.bash
```

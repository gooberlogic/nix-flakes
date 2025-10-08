## home-manager flake

#### install home-manager standalone

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Using standalone so I can deploy this in user-only environments (like WSL)

### Flake Install

`git clone` if you haven't already:

```bash
cd ~ # keep repo in home folder
git clone https://github.com/gooberlogic/nix-flakes.git
```

Install the base configuration:

```bash
cd ./nix-flakes/home-manager
git-crypt unlock
home-manager --flake .#goob switch
```

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
hm-sync
```

Use this to wipe changes back to a specified branch, while preserving user configs:

```bash
bash ./update.bash
```

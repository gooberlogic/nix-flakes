# nix-flakes

The source code of my entire computer. (NixOS and home-manager)

Currently using GNOME and NvChad, a very "just works" setup. Nix also [works very well with dconf](./home-manager/modules/settings/gnome.nix).

Different configurations for other computers are stored in different branches.

### Encryption

For both privacy and security reasons, files with the `.secret` extension are encrypted with `git-crypt`

Because of this, I only really recommend using this repo as a reference rather than a template.

### Requirements

Must either be on NixOS or have the Nix package manager installed: https://nixos.org/download/

Must also have `bash`, `git`, `git-crypt` and `gnupg` installed.

Navigate to either directory for their provided `README.md` and installation instructions.

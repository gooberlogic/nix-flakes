{ config, pkgs, lib, ... }:

{

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    rust-analyzer
    typescript-language-server
    nerd-fonts.victor-mono
    gcc
    #nodePackages.npm
    unzip
    ripgrep
    gnumake
    python3
    python313Packages.pip
  ];

  programs.neovim.enable = true;

  home.shellAliases.nvchad-link = "ln -s $HOME/nix-flakes/home-manager/modules/dev/nvchad $HOME/.config/nvim";

  xdg.mimeApps.defaultApplications = {
    "text/*" = ["nvim.desktop"];
    "application/json" = ["nvim.desktop"];
    "application/xml" = ["nvim.desktop"];
    "application/x-yaml" = ["nvim.desktop"];
    "application/x-sh" = ["nvim.desktop"];
  };

}

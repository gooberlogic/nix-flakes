{ config, pkgs, lib, ... }:

{

  home.sessionVariables = rec {
    CARGO_MOMMYS_LITTLE = "boy"; # ...
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  home.packages = with pkgs; [
    clippy
    cargo-mommy # I'm genuinely sorry
    cargo
    rustc
    gcc
  ];

  home.shellAliases.cargo = "cargo mommy";

}

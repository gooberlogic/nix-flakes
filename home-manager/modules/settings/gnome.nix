{ config, pkgs, lib, user, ... }:

let
  inherit (import ../../users/${user}/vars.nix) mod_gnome_accentColor mod_gnome_kbOptions mod_gnome_sources;

  sourcesFix = map (layout: (lib.hm.gvariant.mkTuple ["xkb" "${layout}"])) mod_gnome_sources;
in
{

  dconf = {

    enable = true;

    # to help find dconf values, use: dconf watch /

    settings."org/gnome/desktop/peripherals/touchpad".natural-scroll = false;

    settings."org/gnome/desktop/wm/preferences".num-workspaces = 4;

    settings."org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      natural-scroll = false;
    };

    settings."org/gnome/mutter" = {
      dynamic-workspaces = false;
      edge-tiling = true;
      workspaces-only-on-primary = false;
    };

    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "${mod_gnome_accentColor}";
      clock-format = "12h";
      icon-theme = "MoreWaita";
      gtk-theme = "Adwaita-dark";
      gtk-enable-primary-paste = false;
      cursor-theme = "Simp1e-Breeze";
      cursor-size = 32;
    };

    settings."org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 0;

    settings."org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      power-button-action = "interactive";
    };

    settings."org/gnome/shell/app-switcher".current-workspace-only = true;

    settings."org/gnome/Terminal/Legacy/Settings".confirm-close = false;

    settings."org/gnome/desktop/wm/keybindings".show-desktop = ["<Super>d"];
    settings."org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Shift><Control>Escape";
      command = "gnome-system-monitor";
      name = "Resource Monitor";
    };

    settings."org/gnome/desktop/peripherals/keyboard" = {
      delay = lib.hm.gvariant.mkUint32 225;
      repeat-interval = lib.hm.gvariant.mkUint32 15;
    };

    settings."org/gnome/desktop/input-sources" = {
      xkb-options = mod_gnome_kbOptions;
      sources = sourcesFix;
    };

    settings."org/gnome/shell/extensions/trayIconsReloaded" = {
      icon-padding-horizontal = 4;
      icons-limit = 16;
    };

    settings."org/gnome/shell/extensions/show-desktop-button".indicator-position = "LEFT";

    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        resource-monitor.extensionUuid
        gsconnect.extensionUuid
        appindicator.extensionUuid
        show-desktop-button.extensionUuid
      ];
    };
  };

  home.packages = with pkgs.gnomeExtensions; [
    resource-monitor
    gsconnect
    appindicator
    show-desktop-button
  ];

  xdg.mimeApps.defaultApplications = {
    "image/*" = ["org.gnome.Loupe.desktop"];
    "image/png" = ["org.gnome.Loupe.desktop"];
    "image/jpeg" = ["org.gnome.Loupe.desktop"];
    "image/jpg" = ["org.gnome.Loupe.desktop"];
    "image/gif" = ["org.gnome.Loupe.desktop"];
    "image/webp" = ["org.gnome.Loupe.desktop"];
  };

}

{ config, pkgs, lib, user, ... }:

let
  inherit (import ../../users/${user}/vars.nix) mod_gnome_accentColor mod_gnome_kbOptions mod_gnome_kbSources;

  kbSourcesFix = map (layout: (lib.hm.gvariant.mkTuple ["xkb" "${layout}"])) mod_gnome_kbSources;
in
{

  dconf = {

    enable = true;

    # to help find dconf values, use: dconf watch /

    settings."org/gtk/gtk4/settings/file-chooser".sort-directories-first = true;

    settings."org/gnome/desktop/peripherals/touchpad".natural-scroll = false;

    settings."org/gnome/desktop/wm/preferences".num-workspaces = 4;

    settings."org/gnome/desktop/search-providers".disabled = [ "org.gnome.Nautilus.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.clocks.desktop" ];

    settings."org/gnome/desktop/privacy".remember-recent-files = false;

    settings."org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      natural-scroll = false;
    };

    settings."org/gnome/mutter" = {
      dynamic-workspaces = true;
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
      sources = kbSourcesFix;
    };

    settings."org/gnome/shell/extensions/trayIconsReloaded" = {
      icon-padding-horizontal = 4;
      icons-limit = 16;
    };

    settings."org/gnome/shell/extensions/alphabetical-app-grid".folder-order-position = "start";

    settings."org/gnome/shell/extensions/show-desktop-button".indicator-position = "LEFT";

    settings."com/github/Ory0n/Resource_Monitor" = {
      refreshtime = 4;
      diskspacestatus = false;
      diskstatsstatus = false;
      netethstatus = false;
      netwlanstatus = false;
      thermalcputemperaturestatus = true;
      extensionposition = "left";
      thermalcputemperaturedeviceslist = ["k10temp: Tctl-true-/sys/class/hwmon/hwmon1/temp1_input"];
      iconsposition = "left";
    };

    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        resource-monitor.extensionUuid
        gsconnect.extensionUuid
        appindicator.extensionUuid
        show-desktop-button.extensionUuid
        alphabetical-app-grid.extensionUuid
        user-themes.extensionUuid
      ];
    };
  };

  home.packages = with pkgs.gnomeExtensions; [
    resource-monitor
    gsconnect
    appindicator
    show-desktop-button
    alphabetical-app-grid
    user-themes
  ];

  xdg.mimeApps.defaultApplications."image/*" = ["org.gnome.Loupe.desktop"];

}

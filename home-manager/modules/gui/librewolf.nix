{ config, pkgs, lib, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["librewolf.desktop"];
    "x-scheme-handler/http" = ["librewolf.desktop"];
    "x-scheme-handler/https" = ["librewolf.desktop"];
  };

  home.packages = with pkgs; [
    comic-mono
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies.Preferences = {
      "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;
    };
    # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/17
    policies.ExtensionSettings = with builtins;
      let extension = shortId: uuid: {
        name = uuid;
        value = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
          installation_mode = "normal_installed";
        };
      };
      in listToAttrs [
        # about:debugging#/runtime/this-firefox
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        (extension "darkreader" "addon@darkreader.org")
        (extension "cookie-editor" "{c3c10168-4186-445c-9c5b-63f12b8e2c87}")
        (extension "dearrow" "deArrow@ajay.app")
        (extension "greasemonkey" "{e4a8a97b-f2ed-450b-b12d-ee082ba24781}")
        (extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
        (extension "read-aloud" "{ddc62400-f22d-4dd3-8b4a-05837de53c2e}")
        (extension "reloadmatic" "0.id@reloadmatic.webex")
        (extension "return-youtube-dislikes" "{762f9885-5a13-4abd-9c77-433dcd38b8fd}")
        (extension "single-file" "{531906d3-e22f-4a6c-a102-8057b88a1a63}")
        (extension "sponsorblock" "sponsorBlocker@ajay.app")
        (extension "volume-control-boost-volume" "{57e8684d-5ae8-47d6-93c9-f870ef0e40a3}")
        (extension "terms-of-service-didnt-read" "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack")
        (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
      ];
  };

}

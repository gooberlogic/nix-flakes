{ config, pkgs, lib, ... }:

{

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["brave-browser.desktop"];
    "x-scheme-handler/http" = ["brave-browser.desktop"];
    "x-scheme-handler/https" = ["brave-browser.desktop"];
  };

  home.packages = with pkgs; [
    comic-mono
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock
      "gebbhagfogifgggkldgodflihgfeippi" # return youtube dislike
      "enamippconapkdmgfgjchkhakpfinmaj" # dearrow
      "mnjggcdmjocbbbhaepdhchncahnbgone" # sponserblock
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
      "hlkenndednhfkekhgcdicdfddnkalmdm" # cookie-editor
      "jinjaccalgkegednnccohejagnlnfdag" # violentmonkey
      "clngdbkpkpeebahjckkjfobafhncgmne" # stylus
      "hdhinadidafjejdhmfkjgnolgimiaplp" # read aloud
      "mpiodijhokgodhhofbcjdecpffjipkle" # singlefile
      "clngdbkpkpeebahjckkjfobafhncgmne" # stylus
      "hjdoplcnndgiblooccencgcggcoihigg" # tosdr
      "jghecgabfgfdldnmbfkhmffcabddioke" # volume-master
      "mghenlmbmjcpehccoangkdpagbcbkdpc" # session-manager
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment --enable-gpu-rasterization --ignore-gpu-blacklist --disable-gpu-driver-workarounds --enable-features=AcceleratedVideoDecodeLinuxGL --ozone-platform=x11" 
    ];
  };
  
}

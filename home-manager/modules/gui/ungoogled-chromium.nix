{ config, pkgs, lib, ... }:

{

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["chromium.desktop"];
    "x-scheme-handler/http" = ["chromium.desktop"];
    "x-scheme-handler/https" = ["chromium.desktop"];
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock lite
      "hnijmpliikobphakkmejgdoffgicmcbc" # auto history wipe
      "gebbhagfogifgggkldgodflihgfeippi" # return youtube dislike
      "enamippconapkdmgfgjchkhakpfinmaj" # dearrow
      "mnjggcdmjocbbbhaepdhchncahnbgone" # sponserblock
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
      "hlkenndednhfkekhgcdicdfddnkalmdm" # cookie-editor
      "jinjaccalgkegednnccohejagnlnfdag" # violentmonkey
      "clngdbkpkpeebahjckkjfobafhncgmne" # stylus
      "mpiodijhokgodhhofbcjdecpffjipkle" # singlefile
      "hjdoplcnndgiblooccencgcggcoihigg" # tosdr
      "jghecgabfgfdldnmbfkhmffcabddioke" # volume-master
      "mghenlmbmjcpehccoangkdpagbcbkdpc" # session-manager
    ];
    #commandLineArgs = [
    #  "--disable-features=WebRtcAllowInputVolumeAdjustment --enable-gpu-rasterization --ignore-gpu-blacklist --disable-gpu-driver-workarounds --enable-features=AcceleratedVideoDecodeLinuxGL --ozone-platform=x11" 
    #];
  };
  
}

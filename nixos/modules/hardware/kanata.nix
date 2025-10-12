{ config, pkgs, lib, ... }:

{

  services.kanata = {
    enable = true;
    keyboards.default.config = ''
      (defsrc
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )

      ;; angle modded
      (deflayer gallium
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  b    l    d    c    z    j    f    o    u    ,    [    ]    \
        @cap n    r    t    s    v    y    h    a    e    i    /    ret
        lsft q    m    w    g    x    k    p    '    ;    .    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )

      ;; angle modded
      (deflayer colemakdh
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \
        @cap a    r    s    t    g    m    n    e    i    o    '    ret
        lsft x    c    d    v    z    k    h    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )
      
      (deflayer qwerty
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @cap a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )
      
      (defalias
        grl (tap-hold 200 200 grv (layer-toggle layers))
      
        gal (layer-switch gallium)
        cmk (layer-switch colemakdh)
        qwr (layer-switch qwerty)
      
        cap (tap-hold 200 200 caps lctl)
      )
      
      ;;(deflayermap (base)
      ;;  caps esc
      ;;  esc caps
      ;;)
      
      (deflayer layers
        _    @gal @cmk @qwr _    _    _    _    _    _    _    lrld _
        _    @gal @cmk @qwr _    _    _    _    _    _    _    lrld _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _              _              _    _    _
      )
    '';
  };

  # https://dev.to/shanu-kumawat/how-to-set-up-kanata-on-nixos-a-step-by-step-guide-1jkc

  boot.kernelModules = [ "uinput" ];

  hardware.uinput.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = { };

  systemd.services.kanata-default.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

}

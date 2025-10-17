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

      ;; Gallium v2 + classic angle mod
      ;; (Bryson's angle mod has too many changes)
      (deflayer gallium
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  b    l    d    c    v    j    f    o    u    ,    [    ]    \
        @cap n    r    t    s    g    y    h    a    e    i    /    ret
        @ftx q    m    w    z    x    k    p    '    ;    .    rsft
        @lct lmet lalt           spc            ralt rmet @rct
      )

      ;; Colemak-DH (angle modded)
      (deflayer colemakdh
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \
        @cap a    r    s    t    g    m    n    e    i    o    '    ret
        lsft x    c    d    v    z    k    h    ,    .    /    rsft
        @lct lmet lalt           spc            ralt rmet @rct
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
      
        cap (tap-hold 200 200 caps (layer-toggle nav))
        ftx (tap-hold 200 100 x lsft)

        lct (multi lctrl (layer-while-held qwerty))
        rct (multi rctrl (layer-while-held qwerty))

        ;;cap (tap-hold 200 200 caps (multi (fork S-[ (unshift {) (rsft lsft)) (fork S-] (unshift }) (rsft lsft)) (layer-toggle nav))
      )
      
      ;;(deflayermap (base)
      ;;  caps esc
      ;;  esc caps
      ;;)
      
      (deflayer layers
        _    @gal @qwr @cmk _    _    _    _    _    _    _    lrld _
        _    @gal @qwr @cmk _    _    _    _    _    _    _    lrld _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _              _              _    _    _
      )

      (deflayer nav 
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    S-]  S-[  _    _    _    _    _
        _    _    _    _    _    _    lft  down up   rght esc  _    _
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

  users.groups.uinput = {};

  systemd.services.kanata-default.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

}

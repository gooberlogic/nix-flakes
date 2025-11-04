{ config, pkgs, lib, ... }:

{

  services.kanata = {
    enable = true;
    keyboards.default.extraDefCfg = "delegate-to-first-layer yes";
    keyboards.default.config = ''
      (defsrc
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )

      ;; https://github.com/GalileoBlues/Gallium
      (deflayer gallium
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        @grl 1    2    3    4    5    6    7    8    9    0    -    =    caps
        tab  b    l    d    c    v    j    f    o    u    ,    [    ]    \
        @bsp n    r    t    s    g    y    h    a    e    i    /    ret
        @ftx q    m    w    z    x    k    p    '    ;    .    rsft
        @lct lmet lalt           spc            ralt rmet @rct
      )
      
      (deflayer qwerty
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 
        @grl 1    2    3    4    5    6    7    8    9    0    -    =    _
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        _    a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )

      (defvar
        tt 200
        ht 100
      )

      (defalias
        grl (tap-hold $tt $ht grv (layer-toggle layouts))
      
        gal (layer-switch gallium)
        qwr (layer-switch qwerty)

        bps (on-press-fakekey normal-bspc toggle)

        bsp (tap-hold $tt $ht bspc (layer-toggle navigation))
        cap (tap-hold $tt $ht caps (layer-toggle navigation))

        ftx (tap-hold $tt 90 x lsft)

        lct (multi lctrl (layer-while-held qwerty))
        rct (multi rctrl (layer-while-held qwerty))
      )

      (deffakekeys
        normal-bspc (layer-while-held normal-bspc)
      )

      (deflayer layouts
        _    @gal @qwr _    _    _    _    _    _    _    _    _    _
        _    @gal @qwr _    _    _    _    _    _    _    _    _    _    lrld
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        @bps _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _              _              _    _    _
      )

      (deflayer navigation
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _   C-lft S-] S-[ C-rght _    esc  _    _
        _    _    _    _    _    _    lft  down up   rght S-;  _    _
        _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _              _              _    _    _
      )

      (deflayermap normal-bspc
        bspc bspc
        caps @cap
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

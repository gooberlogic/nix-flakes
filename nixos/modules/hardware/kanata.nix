{ config, pkgs, lib, ... }:

{

  services.kanata = {
    enable = true;
    keyboards.default.config = ''
(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)

(deflayer colemakdh
  @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \
  @cap a    r    s    t    g    m    n    e    i    o    '    ret
  lsft x    c    d    v    z    k    h    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)

(deflayer qwerty
  @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  @cap a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)

(defalias
  ;; tap: backtick (grave), hold: toggle layer-switching layer while held
  grl (tap-hold 200 200 grv (layer-toggle layers))

  ;; layer-switch changes the base layer.
  cmk (layer-switch colemakdh)
  qwr (layer-switch qwerty)

  ;; tap for capslk, hold for lctl
  cap (tap-hold 200 200 caps lctl)
)

;;(deflayermap (base)
;;  caps esc
;;  esc caps
;;)

(deflayer layers
  _    @cmk @qwr _    _    _    _    _    _    _    lrld _    _    _
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

{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.switchaudio];

  wayland.windowManager.hyprland = {
    settings = {
      bind = let
        switchaudio = "${pkgs.switchaudio}/bin/switchaudio";
      in [
        "SUPER, F11, exec, ${switchaudio} btoff"
        "SUPER, F11, exec, ${switchaudio} hdmi"
        "SUPER SHIFT, F11, exec, ${switchaudio} btheadset"
      ];
    };
  };
}

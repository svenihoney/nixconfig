{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    # pkgs.speedcrunch
    pkgs.qalculate-gtk
  ];

  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        {
          "name" = "qalculate";
          "float" = "on";
          "match:title" = "(Qalculate!)";
        }
      ];
    };
  };
}

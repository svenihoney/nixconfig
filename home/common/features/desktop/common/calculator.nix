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
      window_rule = [
        {
          name = "qalculate";
          float = true;
          match.title = "(Qalculate!)";
        }
      ];
    };
  };
}

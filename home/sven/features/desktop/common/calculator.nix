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
      windowrulev2 = [
        # "float,class:(org.speedcrunch.)"
        "float,title:(Qalculate!)"
      ];
    };
  };
}

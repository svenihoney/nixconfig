{
  config,
  lib,
  pkgs,
  ...
}: {
  # home.packages = [pkgs.linphone];

  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        {
          "name" = "linphone";
          "float" = "on";
          "match:title" = "(linphone)";
        }
      ];
    };
  };
}

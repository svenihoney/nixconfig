{
  config,
  lib,
  pkgs,
  ...
}: {
  # home.packages = [pkgs.linphone];

  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        "float,class:(linphone)"
      ];
    };
  };
}

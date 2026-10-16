{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.linphone];

  wayland.windowManager.hyprland = {
    settings = {
      window_rule = [
        {
          name = "linphone";
          float = true;
          match.title = "(linphone)";
        }
      ];
    };
  };
}

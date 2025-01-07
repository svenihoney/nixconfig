{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.hyprlux = {
    enable = true;

    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    night_light = {
      enabled = true;
      # Manual sunset and sunrise
      start_time = "23:30";
      end_time = "06:00";
      # Automatic sunset and sunrise
      temperature = 4000;
    };

    # vibrance_configs = [
    # {
    #   window_class = "steam_app_1172470";
    #   window_title = "Apex Legends";
    #   strength = 100;
    # }
    # {
    #   window_class = "emacs";
    #   window_title = "";
    #   strength = 100;
    # }
    # ];
  };
}

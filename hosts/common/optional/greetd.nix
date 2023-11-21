{
  pkgs,
  lib,
  config,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd ${pkgs.hyprland}/bin/Hyprland";
        # user = "${user}";
        # user = lib.mkOverride 100 "sven";
      };
      # default_session = initial_session;
    };
  };
  programs.regreet = {
    enable = false;
    settings = {
      background = {
        path = "${config.stylix.image}";
      };
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
  };
}

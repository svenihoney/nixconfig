{
  pkgs,
  lib,
  config,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = rec {
      # default_session = {
      #   command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd ${pkgs.hyprland}/bin/Hyprland";
      #   # user = "${user}";
      #   # user = lib.mkOverride 100 "sven";
      # };
      # default_session = initial_session;
    };
  };
  programs.regreet = {
    enable = true;
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

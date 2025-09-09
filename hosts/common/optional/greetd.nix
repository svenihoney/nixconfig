{
  pkgs,
  lib,
  config,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = {
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd \'${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop\'";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session";
        user = "greeter";
        # user = "${user}";
        # user = lib.mkOverride 100 "sven";
      };
      # default_session = initial_session;
    };
  };

  programs.uwsm = {
    enable = true;
    # waylandCompositors.hyprland = {
    #   binPath = "${lib.getExe config.programs.hyprland.package}";
    #   prettyName = "Hyprland";
    #   comment = "Hyprland managed by UWSM";
    # };
  };
}

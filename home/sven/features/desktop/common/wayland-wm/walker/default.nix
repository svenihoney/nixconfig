{
  pkgs,
  lib,
  ...
}: let
  uswmapp = "${lib.getExe pkgs.uwsm} app -- ";
in {
  home.packages = with pkgs; [walker];
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "SUPER,d,exec,${uswmapp}${pkgs.walker}/bin/walker"
      ];
    };
  };

  systemd.user.services.walker = {
    Unit = {
      Description = "Application launcher backend";
    };
    Install = {
      WantedBy = ["hyprland-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.walker} --gapplication-service";
    };
  };
  # programs.walker = {
  #   enable = true;

  #   config = {
  #     # plugins = with inputs.anyrun.packages.${pkgs.system}; [
  #     #   uwsm_app
  #     #   rink
  #     #   shell
  #     #   symbols
  #     #   websearch
  #     # ];
  #     plugins = [
  #       "${pkgs.anyrun}/lib/libapplications.so"
  #       "${pkgs.anyrun}/lib/librink.so"
  #       "${pkgs.anyrun}/lib/libshell.so"
  #       "${pkgs.anyrun}/lib/libsymbols.so"
  #       "${pkgs.anyrun}/lib/libwebsearch.so"
  #     ];

  #     width.fraction = 0.25;
  #     y.fraction = 0.3;
  #     hidePluginInfo = true;
  #     closeOnClick = true;
  #   };

  #   extraCss = builtins.readFile (./. + "/style-dark.css");

  #   extraConfigFiles = {
  #     "uwsm_app.ron".text = ''
  #       Config(
  #         desktop_actions: false,
  #         max_entries: 5,
  #       )
  #     '';

  #     "shell.ron".text = ''
  #       Config(
  #         prefix: ">"
  #       )
  #     '';

  #     "websearch.ron".text = ''
  #       Config(
  #         prefix: "?",
  #         engines: [DuckDuckGo]
  #       )
  #     '';
  #   };
  # };
}

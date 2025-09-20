{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  uswmapp = "${lib.getExe pkgs.uwsm} app -- ";
in {
  # imports = [
  #   inputs.walker.homeManagerModules.default
  # ];

  # home.packages = with pkgs; [walker];
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "SUPER,d,exec,${uswmapp}${pkgs.walker}/bin/walker"
        # "SUPER,d,exec,${lib.getExe config.programs.walker.package}"
      ];
    };
  };

  systemd.user.services.walker = {
    Unit = {
      Description = "Application launcher backend";
      After = "graphical-session.target";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${uswmapp}${lib.getExe pkgs.walker} --gapplication-service";
    };
  };

  home.file."${config.xdg.configHome}/walker/config.toml".source = ./config.toml;

  # programs.walker = {
  #   enable = true;
  #   runAsService = true;

  #   # All options from the config.toml can be used here.
  #   # config = {
  #   #   placeholders."default".input = "Example";
  #   #   providers.prefixes = [
  #   #     {
  #   #       provider = "websearch";
  #   #       prefix = "+";
  #   #     }
  #   #     {
  #   #       provider = "providerlist";
  #   #       prefix = "_";
  #   #     }
  #   #   ];
  #   #   keybinds.quick_activate = ["F1" "F2" "F3"];
  #   # };

  #   # # If this is not set the default styling is used.
  #   # theme.style = ''
  #   #   * {
  #   #     color: #dcd7ba;
  #   #   }
  #   # '';
  # };
}

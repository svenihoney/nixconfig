{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.caelestia-shell.homeManagerModules.default];
  # services.caelestia-shell = {
  #   enable = true;
  # };
  programs.caelestia = {
    enable = lib.mkDefault true;
    systemd = {
      enable = config.programs.caelestia.enable;
    };
    cli.enable = true;
    settings = {
      general.apps.terminal = ["ghostty"];
      general.idle = {
        inhibitWhenAudio = true;
        timeouts = [];
        #   timeouts = lib.mkDefault [
        #     {
        #       timeout = 600;
        #       idleAction = "lock";
        #     }
        #     {
        #       timeout = 660;
        #       idleAction = "dpms off";
        #       returnAction = "dpms on";
        #     }
        #     {
        #       timeout = 1800;
        #       idleAction = [
        #         "systemctl"
        #         "suspend-then-hibernate"
        #       ];
        #     }
        #   ];
      };

      background = {
        enabled = false;
        wallpaperEnabled = false;
      };
      bar = {
        clock.showIcon = true;
        tray.recolour = true;
        workspaces = {
          activeIndicator = true;
          activeLabel = "";
          activeTrail = false;
          label = "";
          occupiedBg = false;
          occupiedLabel = "";
          perMonitorWorkspaces = false;
          showWindows = false;
          shown = 10;
        };
        activeWindow = {
          inverted = true;
        };
      };
      border.rounding = 15;
      notifs = {
        defaultExpireTimeout = 10000;
        expandThreshold = 2;
        openExpanded = true;
        expire = true;
      };
    };
  };

  # home.activation = {
  #   caelestiaWallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     ${lib.getExe config.programs.caelestia.cli.package} wallpaper -f ${config.stylix.image}
  #   '';
  # };



  wayland.windowManager.hyprland.settings.bind =
    let
      # hyprctl = "${lib.getExe' pkgs.hyprland "hyprctl"}";

      # terminal = config.programs.ghostty;

      caelestia = "${lib.getExe config.programs.caelestia.cli.package}";
      commands = {
        "SHIFT + F7" = "${caelestia} shell drawers toggle dashboard";
        "SHIFT + l" = "${caelestia} shell lock lock; systemctl hybrid-sleep";
        "d" = "${caelestia} shell drawers toggle launcher";

        "l" = "${caelestia} shell lock lock";
        "n" = "${caelestia} shell drawers toggle sidebar";
        "SHIFT + n" = "${caelestia} shell notifs clear";

        "F11" = "${caelestia} shell audio cycleOutput";
      };
    in lib.mkIf config.programs.caelestia.enable
    # One-shot tools
    (lib.mapAttrsToList (key: command: {
      _args = [
        "SUPER + ${key}"
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${command}\")")
      ];
    }) commands)
  ;
  #     # Launcher
  #     ++ (
  #       lib.optionals config.programs.wofi.enable
  #       ["SUPER,d,exec,${uswmapp}${config.programs.wofi.package}/bin/wofi -S drun"]
  #     )
  #     ++ (
  #       lib.optionals config.programs.fuzzel.enable
  #       ["SUPER,d,exec,${uswmapp}${pkgs.fuzzel}/bin/fuzzel"]
  #     )
  #     ++ (
  #       lib.optionals config.programs.hyprpanel.enable
  #       [
  #         "SUPER,n,exec,${hyprpanel} toggleWindow notificationsmenu"
  #         "SUPER SHIFT,n,exec,${hyprpanel} clearNotifications"
  #       ]
  #     )
  #     ++ [
  #       # (lib.optionals config.services.copyq.enable [
  #       # "SUPER, C, exec, ${copyq} toggle"
  #     ]
  #     #)
  #     # ++ (lib.optionals config.services.ulauncher.enable
  #     #  [ "SUPER, D, exec, ulauncher-toggle" ])
  #     ;
}

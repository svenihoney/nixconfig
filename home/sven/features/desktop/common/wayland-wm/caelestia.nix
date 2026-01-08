{
  config,
  lib,
  ...
}: {
  # services.caelestia-shell = {
  #   enable = true;
  # };
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
    };
    cli.enable = true;
    settings = {
      general.apps.terminal = ["foot"];
      general.idle.timeouts = [
        {
          timeout = 600;
          idleAction = "lock";
        }
        {
          timeout = 660;
          idleAction = "dpms off";
          returnAction = "dpms on";
        }
        {
          timeout = 1800;
          idleAction = [
            "systemctl"
            "suspend-then-hibernate"
          ];
        }
      ];

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
        excludedScreens = [
          "HDMI-A-1"
        ];
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
  wayland.windowManager.hyprland = let
    shell = "${lib.getExe config.programs.caelestia.package}";
  in {
    settings = {
      bind = [
        "SUPER ,d,exec,${shell} ipc call drawers toggle launcher"
        "SUPER ,n,exec,${shell} ipc call drawers toggle sidebar"
        "SUPER SHIFT,n,exec,${shell} ipc call notifs clear"
      ];
    };
  };
}

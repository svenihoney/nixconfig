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
}

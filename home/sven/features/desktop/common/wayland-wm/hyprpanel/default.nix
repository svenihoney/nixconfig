{
  osConfig,
  lib,
  ...
}@args:
let
  isNixOS = builtins.hasAttr "nixosConfig" args;
  hasUpower = isNixOS && osConfig.services.upower.enable;
in
{
  age.secrets = {
    "weatherapi/key".file = ../../../../../../../secrets/weatherapi/key.age;
  };

  # imports = [ ./theme.nix ];
  programs.hyprpanel = {
    enable = true;

    settings = {
      bar.battery.label = true;
      bar.bluetooth.label = false;
      bar.clock.format = "%H:%M:%S";
      bar.layouts = {
        "*" = {
          left = [ ];
          middle = [ ];
          right = [ ];
        };
        "0" = {
          left = [
            "dashboard"
            "workspaces"
            "media"
            # "cava"
          ];
          middle = [
            "windowtitle"
          ];
          right = [
            # "cpu"
            # "ram"
            # "storage"
            "volume"
            "network"
          ]
          ++ (lib.optionals hasUpower [
            "bluetooth"
            "battery"
          ])
          ++ [
            "systray"
            "clock"
            "notifications"
          ];
        };
      };
      "theme.bar.location" = "bottom";
      "theme.bar.transparent" = true;
      "menus.clock.time.military" = true;
      "menus.clock.weather.location" = "Moitzfeld";
      "menus.clock.weather.unit" = "metric";
      # "menus.clock.weather.key" = config.age.secrets."weatherapi/key".path;

      "menus.clock.weather.interval" = 1000000;
      "bar.customModules.worldclock.format" = "%H:%M:%S %Z";
      "bar.clock.format" = "%a %d. %b  %H:%M";
      "bar.notifications.show_total" = false;
      "bar.network.truncation_size" = 15;
      "theme.bar.buttons.windowtitle.enableBorder" = false;
      "bar.workspaces.monitorSpecific" = false;
      "bar.workspaces.show_icons" = false;
      "bar.workspaces.show_numbered" = true;
      "bar.workspaces.workspaceMask" = true;
      "bar.workspaces.showWsIcons" = false;
      "bar.workspaces.numbered_active_indicator" = "highlight";
      scalingPriority = "hyprland";
      tear = true;
    };
  };
}

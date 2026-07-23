{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  nix.settings = {
    builders-use-substitutes = true;
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };

  programs.noctalia = {
    enable = true;
    systemd.enable = config.programs.noctalia.enable;
    settings = {
      bar = {
        default = {
          center = [
            "media"
            "active_window"
          ]
          ;
          end = [
            "tray"
            "notifications"
            "clipboard"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "clock"
            "control-center"
            "session"
          ]
          ;
          margin_ends = 0.0;
          monitor = {
            HDMI-A-1 = {
              enabled = false;
            };
          };
          position = "left";
          scale = 1.250000011175871;
          start = [
            "launcher"
            "workspaces"
          ]
          ;
          widget_spacing = 20;
        };
      };
      calendar = {
        account = {
          fischereiaderssen = {
            type = "google";
          };
        };
        enabled = true;
      };
      config_version = 2;
      location = {
        address = "Moitzfeld";
        sunset = "23:00";
      };
      lockscreen_widgets = {
        enabled = false;
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        schema_version = 2;
        widget = {
          "lockscreen-login-box@DP-2" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 1920.0;
            cy = 2041.0;
            output = "DP-2";
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
            type = "login_box";
          };
          "lockscreen-login-box@HDMI-A-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 720.0;
            cy = 2441.0;
            output = "HDMI-A-1";
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
            type = "login_box";
          };
        };
        widget_order = [
          "lockscreen-login-box@HDMI-A-1"
          "lockscreen-login-box@DP-2"
        ]
        ;
      };
      nightlight = {
        enabled = true;
      };
      shell = {
        avatar_path = "~/.face";
        launch_apps_as_systemd_services = true;
        polkit_agent = true;
        screen_corners = {
          enabled = true;
          size = 28;
        };
        telemetry_enabled = false;
        ui_scale = 1.250000011175871;
      };
      system = {
        monitor = {
          gpu_poll_seconds = 2;
        };
      };
      # theme = {
      #   source = "builtin";
      #   templates = {
      #     enable_builtin_templates = false;
      #     enable_community_templates = false;
      #   };
      # };
      wallpaper = {
        enabled = false;
      };
      weather = {
        address = "Moitzfeld";
      };
};
  };

  services.hyprpolkitagent.enable = lib.mkIf config.programs.noctalia.enable false;
  services.hyprsunset.enable = false;
  programs.wlogout.enable = lib.mkIf config.programs.noctalia.enable false;

  wayland.windowManager.hyprland.settings.bind =
    let
      # hyprctl = "${lib.getExe' pkgs.hyprland "hyprctl"}";

      # terminal = config.programs.ghostty;

      noctalia = "${lib.getExe config.programs.noctalia.package} msg";
      commands = {
        # "SHIFT + F7" = "${noctalia} shell drawers toggle dashboard";
        # "SHIFT + l" = "${noctalia} shell lock lock; systemctl hybrid-sleep";
        "d" = "${noctalia} panel-toggle launcher";

        "l" = "${noctalia} session lock";
        "SHIFT + l" = "${noctalia} session lock-and-suspend";

        "n" = "${noctalia} panel-toggle control-center notifications";
        "SHIFT + n" = "${noctalia} notification-clear-history";

        "BACKSPACE" = "${noctalia} panel-toggle session";

        "TAB" = "${noctalia} panel-toggle control-center";
        "ESCAPE" = "${noctalia} panel-toggle control-center system";

        "c" = "${noctalia} panel-toggle clipboard";
        "m" = "${noctalia} mic-mute";
        # "F11" = "${noctalia} shell audio cycleOutput";
      };
    in lib.mkIf config.programs.noctalia.enable
    # One-shot tools
    (lib.mapAttrsToList (key: command: {
      _args = [
        "SUPER + ${key}"
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${command}\")")
      ];
    }) commands)
  ;
}

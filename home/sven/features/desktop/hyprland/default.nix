{
  lib,
  config,
  pkgs,
  ...
}: let
  uwsm = "${lib.getExe pkgs.uwsm}";
  keepassxc = "${lib.getExe pkgs.keepassxc}";
in {
  imports = [
    ../common
    ../common/wayland-wm

    # ./tty-init.nix
    ./basic-binds.nix
    ./keybindings.nix
    ./windowrules.nix
    # ./systemd-fixes.nix
    # ./hyprlux.nix

    # ./animation-default.nix
    ./animation-end4.nix
  ];

  # home.pointerCursor = {
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 24;
  #   gtk.enable = true;
  #   x11.enable = true;
  # };

  # services.hyprpaper.enable = lib.mkForce false;
  # services.hyprpaper.package = inputs.hyprpaper.overlays.hyprpaper.hyprpaper;
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    # package = pkgs.inputs.hyprland.hyprland;

    # xwayland.enable = true;
    systemd.enable = false; # Using uwsm
    systemd.variables = ["--all"];
    # withUwsm = true;
    # wrapperFeatures.gtk = true;

    settings = {
      env = [
        {
          _args = [
            "NIXOS_OZONE_WL"
            "1"
          ];
        }
        {
          _args = [
            "ELECTRON_OZONE_PLATFORM_HINT"
            "wayland"
          ];
        }
      ];
      config = {
        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };
        general = {
          gaps_in = 1;
          gaps_out = 4;
          border_size = 2;

          layout = "dwindle";
        };

        # use this instead of hidpi patches
        xwayland = {
          force_zero_scaling = true;
        };

        input = {
          kb_layout = "de,de";
          kb_variant = "neo_qwertz,deadacute";
          repeat_rate = 25;
          repeat_delay = 250;

          follow_mouse = 1;

          touchpad = {
            natural_scroll = false;
            disable_while_typing = true;
          };

          sensitivity = 0;
        };

        dwindle.split_width_multiplier = 1.35;

        misc = {
          focus_on_activate = true;
          disable_hyprland_logo = true;
          vrr = 2;

          enable_swallow = false;
          swallow_regex = "(org.wezfurlong.wezterm|kitty)";
        };

        debug = {
          disable_logs = true;
        };

        decoration = {
          active_opacity = 1.0;
          inactive_opacity = 0.95;
          fullscreen_opacity = 1.0;
          rounding = 10;
          blur = {
            enabled = true;
            size = 5;
            passes = 3;
            new_optimizations = true;
            ignore_opacity = true;
          };
          # shadow = {
          #   enabled = true;
          #   range = 12;
          #   offset = "3 3";
          # };
        };
      };


      monitor =
        map (
          m:
            if m.enabled
            then {
              output = m.name;
              mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
              position = "${toString m.x}x${toString m.y}";
              scale = m.scale;
              transform = m.transform;
            }
            else {
              output = m.name;
              disabled = true;
            }
        )
        config.monitors;

      device = [
        {
          name = "brian-low-sofle-choc";
          kb_layout = "de,de";
          kb_variant = "koy,neo_qwertz";
          # kb_layout = "de,en";
          # kb_variant = "koy,neo_qwertz";
        }
      ];

      on = [
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function ()
                hl.exec_cmd("${uwsm} finalize SSH_AUTH_SOCK")
                hl.exec_cmd("${lib.getExe pkgs.fish} -c ${keepassxc}")
              end
            '')
          ];
        }
      ];
    };
  };

  home.pointerCursor = {
    enable = true;
    hyprcursor.enable = true;
  };

  # stylix.targets.hyprland.image.enable = false;
  services.hyprpolkitagent.enable = lib.mkDefault true;

  services.hyprsunset = {
    enable = lib.mkDefault true;
    settings = {
      max-gamma = 150;

      profile = [
        {
          time = "7:30";
          identity = true;
        }
        {
          time = "23:00";
          temperature = 5000;
          gamma = 0.8;
        }
      ];
    };
  };
}

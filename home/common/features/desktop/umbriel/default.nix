{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.umbriel.homeModules.default
    ../common
    ../common/wayland-wm
  ];

  nix.settings = {
    extra-substituters = ["https://umbriel.cachix.org"];
    extra-trusted-public-keys = [
      "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
    ];
  };

  programs.umbriel = {
    enable = true;
    # package = pkgs.umbriel;
    # systemd.enable = config.programs.umbriel.enable;
    # settings = fromTOML (builtins.readFile ./umbriel-config.toml);

    settings = {
      general = {
        mod_key = "Super";
        xwayland = true;
        focus_on_activate = true;
        show_cheatsheet = false;
        autostart = ["noctalia" "keepassxc"];
      };
      environment = {
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };
      output = {
        eDP-1 = {
          mode = "3840x2160@60";
          position = [0 0];
          scale = 2.0;
          transform = "normal";
          workspaces = 10;
        };
        # desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564 = {
        # 	mode = "2560x1440@60";
        # 	position = [ 3840 0 ];
        # 	scale = 1.0;
        # 	transform = "90";
        # 	workspaces = 10;
        # };
      };
      layout = {
        mode = "dwindle";
        gap = 1;
      };
      appearance = {
        prefer_no_csd = true;
        border_width = 2;
        corner_radius = 10;
        blur = {
          enabled = true;
          optimized = true;
          passes = 3;
          radius = 5;
          noise = 0.02;
          brightness = 1.0;
          contrast = 1.0;
          saturation = 1.0;
        };
        shadow = {
          enabled = true;
          softness = 10;
          offset_x = 0;
          offset_y = 0;
        };
      };
      input = {
        keyboard = {
          layout = "de";
          variant = "neo_qwertz";
          repeat_delay = 250;
          repeat_rate = 25;
        };
        touchpad = {
          disable_while_typing = true;
          natural_scroll = false;
        };
        device = [
          {
            name = "brian-low-sofle-choc";
            layout = "de,de";
            variant = "koy,neo_qwertz";
          }
        ];
      };
      keybinds = {
        "Mod+Backspace" = "spawn noctalia msg panel-toggle session";
        "Mod+Escape" = "spawn noctalia msg panel-toggle control-center system";
        "Mod+Shift+L" = "spawn noctalia msg session lock-and-suspend";
        "Mod+Shift+N" = "spawn noctalia msg notification-clear-history";
        "Mod+Tab" = "spawn noctalia msg panel-toggle control-center";
        "Mod+C" = "spawn noctalia msg panel-toggle clipboard";
        "Mod+D" = "spawn noctalia msg panel-toggle launcher";
        "Mod+L" = "spawn noctalia msg session lock";
        "Mod+M" = "spawn noctalia msg mic-mute";
        "Mod+N" = "spawn noctalia msg panel-toggle control-center notifications";
        "Mod+Shift+D" = "spawn sh -c 'wtype -M ctrl a -m ctrl; sleep 0.05; wtype -M shift -k Delete -m shift'";
        "Mod+F10" = "spawn slack";
        "Mod+F2" = "spawn zen-beta";
        "Mod+F3" = "spawn thunderbird";
        "Mod+F5" = "spawn nautilus";
        "Mod+F7" = "spawn spotify";
        "Mod+K" = "spawn keepassxc";
        "Mod+Return" = {
          action = "spawn ${lib.getExe pkgs.ghostty}";
          repeat = false;
        };
        "Mod+V" = "spawn pwvucontrol";
        "Mod+F4" = "spawn emacs";
        "Mod+Shift+F4" = "spawn zeditor";
        "Mod+Ctrl+Print" = "spawn sh -c 'grimblast --notify --freeze save output - | satty --filename - --early-exit --initial-tool arrow --annotation-size-factor 0.5 --copy-command wl-copy --action-on-enter save-to-file --output-filename /tmp/satty-screen-$(date +%Y%m%d-%H:%M:%S).png'";
        "Mod+Print" = "spawn sh -c 'grimblast --notify --freeze save area - | satty --filename - --early-exit --initial-tool arrow --annotation-size-factor 0.5 --copy-command wl-copy --action-on-enter save-to-clipboard --output-filename /tmp/satty-area-$(date +%Y%m%d-%H:%M:%S).png'";
        "Mod+Shift+Print" = "spawn sh -c 'grimblast --notify --freeze save window - | satty --filename - --early-exit --initial-tool arrow --annotation-size-factor 0.5 --copy-command wl-copy --action-on-enter save-to-file --output-filename /tmp/satty-window-$(date +%Y%m%d-%H:%M:%S).png'";
        "Mod+F12" = "keyboard-layout-next";
        XF86AudioNext = "spawn playerctl next";
        XF86AudioPlay = "spawn playerctl play-pause";
        XF86AudioPrev = "spawn playerctl previous";
        XF86AudioStop = "spawn playerctl stop";
        XF86AudioLowerVolume = {
          action = "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          repeat = true;
          allow_when_locked = true;
        };
        XF86AudioRaiseVolume = {
          action = "spawn wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          repeat = true;
          allow_when_locked = true;
        };
        XF86MonBrightnessDown = {
          action = "spawn brightnessctl set 10%-";
          repeat = true;
          allow_when_locked = true;
        };
        XF86MonBrightnessUp = {
          action = "spawn brightnessctl set +10%";
          repeat = true;
          allow_when_locked = true;
        };
        "Mod+Shift+Q" = "window-close";
        "Mod+Shift+M" = "session-quit";
        "Mod+Shift+Space" = "window-toggle-floating";
        "Mod+F" = "window-toggle-fullscreen";
        "Mod+Shift+Minus" = "window-move-to-scratchpad";
        "Mod+Minus" = "scratchpad-toggle";
        "Mod+1" = "workspace-switch 1";
        "Mod+2" = "workspace-switch 2";
        "Mod+3" = "workspace-switch 3";
        "Mod+4" = "workspace-switch 4";
        "Mod+5" = "workspace-switch 5";
        "Mod+6" = "workspace-switch 6";
        "Mod+7" = "workspace-switch 7";
        "Mod+8" = "workspace-switch 8";
        "Mod+9" = "workspace-switch 9";
        "Mod+0" = "workspace-switch 10";
        "Mod+Shift+1" = "window-move-to-workspace 1";
        "Mod+Shift+2" = "window-move-to-workspace 2";
        "Mod+Shift+3" = "window-move-to-workspace 3";
        "Mod+Shift+4" = "window-move-to-workspace 4";
        "Mod+Shift+5" = "window-move-to-workspace 5";
        "Mod+Shift+6" = "window-move-to-workspace 6";
        "Mod+Shift+7" = "window-move-to-workspace 7";
        "Mod+Shift+8" = "window-move-to-workspace 8";
        "Mod+Shift+9" = "window-move-to-workspace 9";
        "Mod+Shift+0" = "window-move-to-workspace 10";
        "Mod+Down" = "window-focus-down";
        "Mod+Left" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+Up" = "window-focus-up";
        "Mod+Shift+Down" = "window-move-down";
        "Mod+Shift+Left" = "column-move-left";
        "Mod+Shift+Right" = "column-move-right";
        "Mod+Shift+Up" = "window-move-up";
        "Mod+Ctrl+Down" = "window-move-down";
        "Mod+Ctrl+Left" = "column-move-left";
        "Mod+Ctrl+Right" = "column-move-right";
        "Mod+Ctrl+Up" = "window-move-up";
      };
      window_rule = [
        {
          match = {
            app_id = "^org.keepassxc.KeePassXC$";
          };
          default_floating = true;
        }
        {
          match = {
            app_id = "^com.saivert.pwvucontrol$";
          };
          default_floating = true;
        }
        {
          match = {
            app_id = "^com.gabm.satty$";
          };
          default_floating = true;
        }
        {
          match = {
            title = "twinkle";
          };
          default_floating = true;
        }
        {
          match = {
            title = "^Bluetooth Devices$";
          };
          default_floating = true;
        }
        {
          match = {
            app_id = "^[Vv]ivaldi.*$";
          };
          default_workspace = "2";
        }
        {
          match = {
            app_id = "^org.qutebrowser.qutebrowser$";
          };
          default_workspace = "2";
        }
        {
          match = {
            app_id = "^firefox$";
          };
          default_workspace = "2";
        }
        {
          match = {
            app_id = "^zen(-beta)?$";
          };
          default_workspace = "2";
        }
        {
          match = {
            app_id = "^thunderbird$";
          };
          default_workspace = "3";
        }
        {
          match = {
            title = "^Kalendererinnerungen$";
          };
          default_floating = true;
        }
        {
          match = {
            app_id = "^spotify$";
          };
          default_workspace = "7";
        }
        {
          match = {
            title = "^Amazon Music Unlimited.*$";
          };
          default_workspace = "7";
        }
        {
          match = {
            app_id = "^Slack$";
          };
          default_workspace = "10";
        }
        {
          match = {
            title = "^Wargaming.net Game Center$";
          };
          default_floating = true;
        }
        {
          match = {
            title = "^W.o.T. Client$";
          };
          default_fullscreen = true;
        }
        {
          match = {
            title = ".*Huddle.*";
          };
          default_floating = true;
        }
        {
          match = {
            title = "^Verfassen:.*$";
          };
          default_floating = true;
          default_position = {
            x = 0;
            y = 0;
            anchor = "center";
          };
          dim_behind = 0.3;
        }
        {
          match = {
            title = "^Slint Window$";
          };
          default_floating = true;
        }
        {
          match = {
            app_id = ".*exe$";
          };
          default_floating = true;
          default_workspace = "5";
        }
        {
          match = {
            title = "^Qalculate!$";
          };
          default_floating = true;
        }
        {
          match = {
            app_id = "^com.nextcloud.desktopclient.nextcloud$";
          };
          default_floating = true;
          default_position = {
            x = 0;
            y = 0;
            anchor = "bottom_right";
          };
        }
      ];
    };
  };
}

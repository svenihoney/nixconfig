{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  hyprctl = "${lib.getExe' pkgs.hyprland "hyprctl"}";
  wlogout = "${config.programs.wlogout.package}/bin/wlogout";
  playerctld = "${config.services.playerctld.package}/bin/playerctld";
  # wofi = "${config.programs.wofi.package}/bin/wofi";
  # copyq = "${lib.getExe config.services.copyq.package}";
  neovide = "${lib.getExe pkgs.neovide}";
  spotify = "${lib.getExe pkgs.spotify}";
  keepassxc = "${lib.getExe pkgs.keepassxc}";
  # waybar = "${lib.getExe pkgs.waybar}";
  # hyprpanel = "${lib.getExe pkgs.hyprpanel}";
  # polkit = "${lib.getExe pkgs.lxqt.lxqt-policykit}";
  # thunar = "${lib.getExe pkgs.thunar}";

  # pwvucontrol = "${lib.getExe pkgs.pwvucontrol}";

  # terminal = config.home.sessionVariables.TERMINAL;
  terminal = config.programs.ghostty;

  caelestia = "${lib.getExe config.programs.caelestia.cli.package}";

  playerctl = "${lib.getExe config.services.playerctld.package}";
  wpctl = "${lib.getExe' pkgs.wireplumber "wpctl"}";
  brightnesscontrol = "${lib.getExe pkgs.brightnessctl}";

  grimblast = "${lib.getExe pkgs.grimblast}";
  satty = "${lib.getExe pkgs.satty}";
  satty_cmd = "${satty} --filename - --early-exit --initial-tool arrow --annotation-size-factor 0.5 --copy-command ${pkgs.wl-clipboard}/bin/wl-copy";

  uwsm = "${lib.getExe pkgs.uwsm}";
  uswmapp = "${uwsm} app -- ";
in {
  imports = [
    ../common
    ../common/wayland-wm

    # ./tty-init.nix
    ./basic-binds.nix
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

      window_rule = [
        {
          name = "windowrule-3";
          float = true;
          match.class = "org.keepassxc.KeePassXC";
        }
        {
          name = "windowrule-4";
          float = true;
          match.class = "com.saivert.pwvucontrol";
        }
        # {
        #   name = "windowrule-5";
        #   float = true;
        #   match.class = "(org.speedcrunch.)";
        # }
        # {
        #   name = "windowrule-6";
        #   float = true;
        #   move = "(cursor_x+(min(max(0,0),monitor_w-window_w))) (cursor_y+(min(max(0,0),monitor_h-window_h)))";
        #   match.class = "com.github.hluk.copyq";
        # }
        {
          name = "windowrule-7";
          float = true;
          match.class = "com.gabm.satty";
        }
        # {
        #   name = "windowrule-8";
        #   float = true;
        #   move = "(cursor_x+(min(max((monitor_w*0.5),0),monitor_w-window_w))) (cursor_y+(min(max((monitor_h*0.5),0),monitor_h-window_h)))";
        #   match.class = "com.nextcloud.desktopclient.nextcloud";
        # }
        {
          name = "windowrule-9";
          float = true;
          match.title = "(twinkle)";
        }
        {
          name = "windowrule-10";
          float = true;
          match.title = "Bluetooth Devices";
        }
        # {
        #   name = "windowrule-11";
        #   float = true;
        #   match.title = "Netxp.*";
        # }
        {
          name = "windowrule-12";
          workspace = "2";
          match.class = "([Vv]ivaldi.*)";
        }
        {
          name = "windowrule-13";
          workspace = "2";
          match.class = "(org.qutebrowser.qutebrowser)";
        }
        {
          name = "windowrule-14";
          workspace = "2";
          match.class = "firefox";
        }
        {
          name = "windowrule-15";
          workspace = "2";
          match.class = "zen.*";
        }
        {
          name = "windowrule-16";
          workspace = "3";
          match.class = "thunderbird";
        }
        {
          name = "windowrule-17";
          float = true;
          match.title = "(Kalendererinnerungen)";
        }
        {
          name = "windowrule-18";
          workspace = "7";
          match.class = "spotify";
        }
        {
          name = "windowrule-19";
          workspace = "7";
          match.title = "(Amazon Music Unlimited.*)";
        }
        {
          name = "windowrule-20";
          workspace = "10";
          match.class = "Slack";
        }
        {
          name = "windowrule-21";
          float = true;
          match.title = "Wargaming.net Game Center";
        }
        {
          name = "windowrule-22";
          fullscreen = true;
          match.title = "W.o.T. Client";
        }
        {
          name = "windowrule-23";
          float = true;
          match.title = ".*Huddle.*";
        }
        {
          name = "windowrule-24";
          match.title = "Verfassen:.*";
          float = true;
          center = true;
          size = "1000 1000";
          # min_size = "{ 600, 800 }";
          dim_around = true;
        }
      ];
      #   # windowrulev2 = [
      #   #   "float,class:org.keepassxc.KeePassXC"
      #   #   "float,class:com.saivert.pwvucontrol"
      #   #   "float,class:(org.speedcrunch.)"
      #   #   "float,class:com.github.hluk.copyq"
      #   #   "float,class:com.gabm.satty"
      #   #   # "move onscreen cursor 50% 50%,class:com.github.hluk.copyq"
      #   #   "move onscreen cursor 0 0,class:com.github.hluk.copyq"
      #   #   "float,class:com.nextcloud.desktopclient.nextcloud"
      #   #   "move onscreen cursor 50% 50%,class:com.nextcloud.desktopclient.nextcloud"
      #   #   "float,title:(twinkle)"
      #   #   "float,title:Bluetooth Devices"
      #   #   "float,title:Netxp.*"

      #   #   "workspace 2,class:([Vv]ivaldi.*)"
      #   #   "workspace 2,class:(org.qutebrowser.qutebrowser)"
      #   #   "workspace 2,class:firefox"
      #   #   "workspace 2,class:zen"

      #   #   "workspace 3,class:thunderbird"
      #   #   "float,title:(Kalendererinnerungen)"

      #   #   "workspace 7,class:spotify"
      #   #   "workspace 7,title:(Amazon Music Unlimited.*)"
      #   #   "workspace 10,class:Slack"
      #   # ];
      #   windowrule = [
      #   ];

      # monitor =
      #   map
      #   (m: let
      #     resolution = "${toString m.width}x${toString m.height}@${
      #       toString m.refreshRate
      #     }";
      #     position = "${toString m.x}x${toString m.y}";
      #   in "${m.name},${
      #     if m.enabled
      #     # then "${resolution},${position},${m.scale},transform,${m.transform},bitdepth,10"
      #     then "${resolution},${position},${m.scale},transform,${m.transform}"
      #     else "disable"
      #   }")
      #   (config.monitors);

      #   # workspace =
      #   #   map (m: "${m.name},${m.workspace}")
      #   #   (lib.filter (m: m.enabled && m.workspace != null) config.monitors);
      #   # workspace = [
      #   #   "1, defaultName:1, monitor:desc:Lenovo Group Limited LEN T27p-10 0x4E395246"
      #   #   "2, defaultName:2, monitor:desc:Lenovo Group Limited LEN T27p-10 0x4E395246"
      #   #   "3, defaultName:3, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   #   "4, defaultName:4, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   #   "5, defaultName:5"
      #   #   "6, defaultName:6"
      #   #   "7, defaultName:7, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   #   "8, defaultName:8"
      #   #   "9, defaultName:9, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   #   "0, defaultName:0, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   # ];

      bind =
        let
          runnables =
            {
              "RETURN" = terminal.package;
              "V" = pkgs.pwvucontrol;
              "F2" = config.programs.zen-browser.package;
              "F3" = config.programs.thunderbird.package;
            }
            // lib.attrsets.optionalAttrs config.programs.keepassxc.enable {
              "K" = config.programs.keepassxc.package;
            }
            // lib.attrsets.optionalAttrs config.programs.wlogout.enable {
              "BACKSPACE" = config.programs.wlogout.package;
            }
            // lib.attrsets.optionalAttrs config.programs.doom-emacs.enable {
              "F4" = config.programs.doom-emacs.finalEmacsPackage;
            }
            // lib.attrsets.optionalAttrs config.programs.neovide.enable {
              "SHIFT + F4" = config.programs.neovide.package;
            }
            // lib.attrsets.optionalAttrs (lib.elem pkgs.kdePackages.dolphin config.home.packages) {
              "F5" = pkgs.kdePackages.dolphin;
            }
            // lib.attrsets.optionalAttrs (lib.elem pkgs.nautilus config.home.packages) {
              "F5" = pkgs.nautilus;
            }
            // lib.attrsets.optionalAttrs (lib.elem pkgs.spotify config.home.packages) {
              "F7" = pkgs.spotify;
            }
            // lib.attrsets.optionalAttrs (lib.elem pkgs.slack config.home.packages) {
              "F10" = pkgs.slack;
            };
          commands =
            {
              "SHIFT + F7" = "${caelestia} shell drawers toggle dashboard";
              "F12" = "${hyprctl} switchxkblayout current next";
              "SHIFT + l" = "${caelestia} shell lock lock; systemctl hybrid-sleep";

              "Print" = "${grimblast} --notify --freeze save area - | ${satty_cmd} --action-on-enter save-to-clipboard --output-filename /tmp/satty-area-$(date '+%Y%m%d-%H:%M:%S').png";
              "SHIFT + Print" = "${grimblast} --notify --freeze save window - | ${satty_cmd} --action-on-enter save-to-file --output-filename /tmp/satty-window-$(date '+%Y%m%d-%H:%M:%S').png";
              "CONTROL + Print" = "${grimblast} --notify --freeze save output - | ${satty_cmd} --action-on-enter save-to-file --output-filename /tmp/satty-screen-$(date '+%Y%m%d-%H:%M:%S').png";
            }
            // lib.attrsets.optionalAttrs config.programs.caelestia.enable {
              "d" = "${caelestia} shell drawers toggle launcher";

              "l" = "${caelestia} shell lock lock";
              "n" = "${caelestia} shell drawers toggle sidebar";
              "SHIFT + n" = "${caelestia} shell notifs clear";

              "F11" = "${caelestia} shell audio cycleOutput";
            };
          nosuperCommands =
            {
            }
            // lib.attrsets.optionalAttrs config.services.playerctld.enable {
              # Media control
              "XF86AudioNext" = "${playerctl} next";
              "XF86AudioPrev" = "${playerctl} previous";
              "XF86AudioPlay" = "${playerctl} play-pause";
              "XF86AudioStop" = "${playerctl} stop";
            };
          repeatCommands = {
            "XF86MonBrightnessUp" = "${brightnesscontrol} set +10%";
            "XF86MonBrightnessDown" = "${brightnesscontrol} set 10%-";
            "XF86AudioRaiseVolume" = "${wpctl} set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume" = "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          };
        in
          [
            {
              _args = [
                "switch:Lid Switch"
                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"loginctl lock-session\")")
                {locked = true;}
              ];
            }
          ]
          # Runnable applications
          ++ (lib.mapAttrsToList
            (
              key: runnable: {
                _args = [
                  "SUPER + ${key}"
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${uswmapp} ${lib.getExe runnable}\")")
                ];
              }
            )
            runnables)
          # One-shot tools
          ++ (lib.mapAttrsToList
            (
              key: command: {
                _args = [
                  "SUPER + ${key}"
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${command}\")")
                ];
              }
            )
            commands)
          # One-shot tools, no SUPER key
          ++ (lib.mapAttrsToList
            (
              key: command: {
                _args = [
                  "${key}"
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${command}\")")
                ];
              }
            )
            nosuperCommands)
          # One-shot tools, no SUPER key, repeatable
          ++ (lib.mapAttrsToList
            (
              key: command: {
                _args = [
                  "${key}"
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${command}\")")
                  {repeating = true;}
                ];
              }
            )
            repeatCommands)
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
        ;

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
  services.hyprpolkitagent.enable = true;

  services.hyprsunset = {
    enable = true;
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

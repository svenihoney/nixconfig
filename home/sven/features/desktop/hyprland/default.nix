{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ../common/wayland-wm

    ./tty-init.nix
    ./basic-binds.nix
    # ./systemd-fixes.nix
  ];

  home.packages = with pkgs; [
    grimblast
    # hyprslurp
    hyprpicker
    hyprpaper
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.inputs.hyprland.hyprland;

    # xwayland.enable = true;
    systemd.enable = true;
    # wrapperFeatures.gtk = true;

    settings = {
      general = {
        # gaps_in = 15;
        # gaps_out = 20;
        # border_size = 2.7;
        # cursor_inactive_timeout = 4;
        # "col.active_border" = "0xff${config.colorscheme.colors.base0C}";
        # "col.inactive_border" = "0xff${config.colorscheme.colors.base02}";
        # "col.group_border_active" = "0xff${config.colorscheme.colors.base0B}";
        # "col.group_border" = "0xff${config.colorscheme.colors.base04}";

        gaps_in = "1";
        gaps_out = "4";
        border_size = "1";
        # "col.active_border" = "rgba(888888ee)";
        # "col.inactive_border" = "rgba(444444aa)";

        layout = "dwindle";
      };

      input = {
        kb_layout = "de";
        kb_variant = "neo_qwertz";
        repeat_rate = "25";
        repeat_delay = "250";

        follow_mouse = "1";

        touchpad = {
          natural_scroll = "no";
          disable_while_typing = false;
        };

        sensitivity = "0";
      };

      dwindle.split_width_multiplier = 1.35;
      misc.vfr = true;

      decoration = {
        active_opacity = 0.92;
        inactive_opacity = 0.75;
        fullscreen_opacity = 1.0;
        rounding = 5;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
        };
        drop_shadow = true;
        shadow_range = 12;
        shadow_offset = "3 3";
      };
      animations = {
        enabled = true;
        bezier = [
          "easein,0.11, 0, 0.5, 0"
          "easeout,0.5, 1, 0.89, 1"
          "easeinback,0.36, 0, 0.66, -0.56"
          "easeoutback,0.34, 1.56, 0.64, 1"
        ];

        animation = [
          "windowsIn,1,3,easeoutback,slide"
          "windowsOut,1,3,easeinback,slide"
          "windowsMove,1,1,easeoutback"
          "workspaces,1,1,easeoutback,slide"
          "fadeIn,1,3,easeout"
          "fadeOut,1,3,easein"
          "fadeSwitch,1,3,easeout"
          "fadeShadow,1,3,easeout"
          "fadeDim,1,3,easeout"
          "border,1,3,easeout"
        ];
      };

      exec = [
        "${pkgs.swaybg}/bin/swaybg -i ${config.stylix.image} --mode fill"
      ];

      # bindl = let swaylock = "${config.programs.swaylock.package}/bin/swaylock";
      # in [ ",switch:Lid Switch, exec, swaylock" ];

      bind =
        let
          swaylock = "${config.programs.swaylock.package}/bin/swaylock";
          playerctl = "${config.services.playerctld.package}/bin/playerctl";
          playerctld = "${config.services.playerctld.package}/bin/playerctld";
          makoctl = "${config.services.mako.package}/bin/makoctl";
          wofi = "${config.programs.wofi.package}/bin/wofi";
          # pass-wofi = "${
          #     pkgs.pass-wofi.override {
          #       pass = config.programs.password-store.package;
          #     }
          #   }/bin/pass-wofi";

          # grimblast = "${pkgs.inputs.hyprwm-contrib.grimblast}/bin/grimblast";
          grimblast = "grimblast";
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          # tly = "${pkgs.tly}/bin/tly";
          gtk-play = "${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play";
          notify-send = "${pkgs.libnotify}/bin/notify-send";

          gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
          xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
          defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";

          # terminal = config.home.sessionVariables.TERMINAL;
          terminal = "wezterm";
          # browser = defaultApp "x-scheme-handler/https";
          browser = "${pkgs.qutebrowser}/bin/qutebrowser";
          editor = defaultApp "text/plain";
        in
          [
            # Program bindings
            "SUPER,Return,exec,${terminal}"
            # "SUPER,e,exec,${editor}"
            # "SUPER,v,exec,${editor}"
            # "SUPER,b,exec,${browser}"
            "SUPER, F2, exec, vivaldi"
            "SUPER, F3, exec, thunderbird"
            "SUPER, F4, exec, teams-for-linux --enable-features=UseOzonePlatform --ozone-platform=wayland"
            "SUPER, C, exec, swaync-client -t"
            "SUPER SHIFT, C, exec, swaync-client -C"
            "SUPER SHIFT, K, exec, keepassxc"
            # "SUPER SHIFT, E, exec, nwg-bar"

            # Brightness control (only works if the system has lightd)
            ",XF86MonBrightnessUp,exec,light -A 10"
            ",XF86MonBrightnessDown,exec,light -U 10"
            # Volume
            ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
            ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
            ",XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
            "SHIFT,XF86AudioMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
            ",XF86AudioMicMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
            "SUPER SHIFT, V, exec, pavucontrol"
            # Screenshotting
            ",Print,exec,${grimblast} --notify --freeze copy output"
            "SHIFT,Print,exec,${grimblast} --notify --freeze copy active"
            "CONTROL,Print,exec,${grimblast} --notify --freeze copy screen"
            "SUPER,Print,exec,${grimblast} --notify --freeze copy area"
            "ALT,Print,exec,${grimblast} --notify --freeze copy area"
            # Tally counter
            # "SUPER,z,exec,${notify-send} -t 1000 $(${tly} time) && ${tly} add && ${gtk-play} -i dialog-information" # Add new entry
            # "SUPERCONTROL,z,exec,${notify-send} -t 1000 $(${tly} time) && ${tly} undo && ${gtk-play} -i dialog-warning" # Undo last entry
            # "SUPERCONTROLSHIFT,z,exec,${tly} reset && ${gtk-play} -i complete" # Reset
            # "SUPERSHIFT,z,exec,${notify-send} -t 1000 $(${tly} time)" # Show current time
          ]
          ++ (lib.optionals config.targets.genericLinux.enable [
            "SUPERSHIFT, F2, exec, nixGL ${browser}"
          ])
          ++ (lib.optionals (! config.targets.genericLinux.enable) [
            "SUPERSHIFT, F2, exec, ${browser}"
          ])
          ++ (lib.optionals config.services.playerctld.enable [
            # Media control
            ",XF86AudioNext,exec,${playerctl} next"
            ",XF86AudioPrev,exec,${playerctl} previous"
            ",XF86AudioPlay,exec,${playerctl} play-pause"
            ",XF86AudioStop,exec,${playerctl} stop"
            "ALT,XF86AudioNext,exec,${playerctld} shift"
            "ALT,XF86AudioPrev,exec,${playerctld} unshift"
            "ALT,XF86AudioPlay,exec,systemctl --user restart playerctld"
          ])
          # Screen lock
          # (lib.optionals config.programs.swaylock.enable [
          #   ",XF86Launch5,exec,${swaylock} -i ${config.wallpaper}"
          #   ",XF86Launch4,exec,${swaylock} -i ${config.wallpaper}"
          #   "SUPER,backspace,exec,${swaylock} -i ${config.wallpaper}"
          # ]) ++
          # Notification manager
          ++ (lib.optionals config.services.mako.enable
            ["SUPER,c,exec,${makoctl} dismiss"])
          # Launcher
          ++ (
            lib.optionals config.programs.wofi.enable [
              # "SUPER,x,exec,${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
              "SUPER,d,exec,${wofi} -S drun"
            ]
            # ++ (lib.optionals config.programs.password-store.enable [
            #   ",Scroll_Lock,exec,${pass-wofi}" # fn+k
            #   ",XF86Calculator,exec,${pass-wofi}" # fn+f12
            #   "SUPER,semicolon,exec,pass-wofi"
            # ])
          )
        # ++ (lib.optionals config.services.ulauncher.enable
        #  [ "SUPER, D, exec, ulauncher-toggle" ])
        ;

      windowrulev2 = [
        "float,class:(KeePassXC)"
        "float,class:(pavucontrol)"

        "workspace 2,class:(vivaldi.*)"
        "workspace 2,class:(org.qutebrowser.qutebrowser)"

        "workspace 3,class:(thunderbird)"
      ];

      monitor = map (m: let
        resolution = "${toString m.width}x${toString m.height}@${
          toString m.refreshRate
        }";
        position = "${toString m.x}x${toString m.y}";
      in "${m.name},${
        if m.enabled
        then "${resolution},${position},${m.scale},transform,${m.transform}"
        else "disable"
      }") (config.monitors);

      workspace =
        map (m: "${m.name},${m.workspace}")
        (lib.filter (m: m.enabled && m.workspace != null) config.monitors);
    };
    # This is order sensitive, so it has to come here.
    extraConfig = ''
      # Passthrough mode (e.g. for VNC)
      bind=SUPER,P,submap,passthrough
      submap=passthrough
      bind=SUPER,P,submap,reset
      submap=reset
    '';
  };
}

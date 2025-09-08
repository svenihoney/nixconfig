{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  # swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  hyprlock = "${lib.getExe config.programs.hyprlock.package}";
  pkill = "${pkgs.procps}/bin/pkill";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  hyprsunset = "${pkgs.hyprsunset}/bin/hyprsunset";
  wlogout = "${config.programs.wlogout.package}/bin/wlogout";
  playerctl = "${config.services.playerctld.package}/bin/playerctl";
  playerctld = "${config.services.playerctld.package}/bin/playerctld";
  makoctl = "${config.services.mako.package}/bin/makoctl";
  # wofi = "${config.programs.wofi.package}/bin/wofi";
  # copyq = "${lib.getExe config.services.copyq.package}";
  grimblast = "${lib.getExe pkgs.grimblast}";
  satty = "${lib.getExe pkgs.satty}";
  satty_cmd = "${satty} --filename - --early-exit --initial-tool arrow --annotation-size-factor 0.5 --action-on-enter save-to-clipboard --output-filename /tmp/satty-area-$(date '+%Y%m%d-%H:%M:%S').png";
  neovide = "${lib.getExe pkgs.neovide}";
  spotify = "${lib.getExe pkgs.spotify}";
  keepassxc = "${lib.getExe pkgs.keepassxc}";
  waybar = "${lib.getExe pkgs.waybar}";
  thunar = "${lib.getExe pkgs.xfce.thunar}";
  # pass-wofi = "${
  #     pkgs.pass-wofi.override {
  #       pass = config.programs.password-store.package;
  #     }
  #   }/bin/pass-wofi";

  # grimblast = "${pkgs.inputs.hyprwm-contrib.grimblast}/bin/grimblast";
  # grimblast = "grimblast";
  # tly = "${pkgs.tly}/bin/tly";
  gtk-play = "${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  # pwvucontrol = "${lib.getExe pkgs.pwvucontrol}";
  volcontrol = "${lib.getExe pkgs.pwvucontrol}";

  gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
  xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
  defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";

  # terminal = config.home.sessionVariables.TERMINAL;
  # terminal = "${lib.getExe pkgs.ghostty}";
  terminal = "ghostty";
  # browser = defaultApp "x-scheme-handler/https";
  # browser = "${pkgs.qutebrowser}/bin/qutebrowser";
  browser = "${pkgs.vivaldi}/bin/vivaldi";
  altbrowser = "${pkgs.firefox}/bin/firefox";
  # editor = defaultApp "text/plain";
  # editor = "${config.programs.emacs.package}/bin/emacs";
  editor = "${config.programs.doom-emacs.finalEmacsPackage}/bin/emacs";
  uswmapp = "${lib.getExe pkgs.uwsm} app -- ";
in {
  imports = [
    ../common
    ../common/wayland-wm

    # ./tty-init.nix
    ./basic-binds.nix
    # ./systemd-fixes.nix
    # ./hyprlux.nix
  ];

  # home.packages = with pkgs; [
  #   grim
  #   # hyprslurp
  #   hyprpicker
  # ];

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
    # package = pkgs.inputs.hyprland.hyprland;

    # xwayland.enable = true;
    systemd.enable = false; # Using uwsm
    systemd.variables = ["--all"];
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
        border_size = "2";
        # "col.active_border" = "rgba(888888ee)";
        # "col.inactive_border" = "rgba(444444aa)";

        layout = "dwindle";
      };

      # use this instead of hidpi patches
      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "de";
        kb_variant = "neo_qwertz";
        repeat_rate = "25";
        repeat_delay = "250";

        follow_mouse = "1";

        touchpad = {
          natural_scroll = "no";
          disable_while_typing = true;
        };

        sensitivity = "0";
      };

      dwindle.split_width_multiplier = 1.35;

      misc = {
        disable_hyprland_logo = true;
        vrr = 2;

        enable_swallow = false;
        swallow_regex = ["(org.wezfurlong.wezterm)" "(kitty)"];
      };

      debug = {
        disable_logs = true;
      };

      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.95;
        fullscreen_opacity = 1.0;
        rounding = 5;
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
      ];
      # exec-once = [
      # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # "dbus-update-activation-environment --systemd --all"
      # "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # ];
      exec-once = [
        # finalize startup
        "uwsm finalize"
        # set cursor for HL itself
        # "hyprctl setcursor ${cursorName} ${toString pointer.size}"
        # "hyprlock"
        # "${uswmapp}${copyq}"
        "${uswmapp}${hyprsunset}"
        "${uswmapp}${keepassxc}"
        "${uswmapp}${waybar}"
      ];

      env = [
        "XDG_SESSION_DESKTOP,Hyprland"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      ];

      bindl = [",switch:Lid Switch, exec, ${hyprlock}"];

      bind =
        [
          # Program bindings
          "SUPER,Return,exec,${uswmapp}${terminal}"
          # "SUPER,e,exec,${editor}"
          # "SUPER,v,exec,${editor}"
          # "SUPER,b,exec,${browser}"
          "SUPER SHIFT, F2, exec, ${uswmapp}${altbrowser}"
          "SUPER, F2, exec, ${uswmapp}${browser}"
          "SUPER, F3, exec, ${uswmapp}thunderbird"
          # "SUPER, F4, exec, teams-for-linux --enable-features=UseOzonePlatform --ozone-platform=wayland"
          # "SUPER, F4, exec, fish -c ${editor}"
          "SUPER SHIFT, F4, exec, ${uswmapp}${neovide}"
          "SUPER, F5, exec, ${uswmapp}${thunar}"
          "SUPER, F7, exec, ${uswmapp}${spotify}"
          "SUPER, F12, exec, hyprctl switchxkblayout brian-low-sofle-choc next"
          # "SUPER, F11, exec, ~/bin/switchaudio btoff"
          # "SUPER, F11, exec, ~/bin/switchaudio hdmi"
          # "SUPER SHIFT, F11, exec, ~/bin/switchaudio btheadset"

          "SUPER, K, exec, ${uswmapp}${keepassxc}"
          # "SUPER SHIFT, E, exec, nwg-bar"

          # Volume
          ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          "SUPER, V, exec, ${uswmapp}${volcontrol}"
          # Screenshotting
          "SUPER ,Print,exec,${grimblast} --notify --freeze save area - | ${satty_cmd}"
          "SUPER SHIFT,Print,exec,${grimblast} --notify --freeze save window - | ${satty_cmd} --filename - --output-filename /tmp/satty-window-$(date '+%Y%m%d-%H:%M:%S').png"
          "SUPER CONTROL,Print,exec,${grimblast} --notify --freeze save output - | ${satty_cmd} --filename - --output-filename /tmp/satty-screen-$(date '+%Y%m%d-%H:%M:%S').png"
          # Tally counter
          # "SUPER,z,exec,${notify-send} -t 1000 $(${tly} time) && ${tly} add && ${gtk-play} -i dialog-information" # Add new entry
          # "SUPERCONTROL,z,exec,${notify-send} -t 1000 $(${tly} time) && ${tly} undo && ${gtk-play} -i dialog-warning" # Undo last entry
          # "SUPERCONTROLSHIFT,z,exec,${tly} reset && ${gtk-play} -i complete" # Reset
          # "SUPERSHIFT,z,exec,${notify-send} -t 1000 $(${tly} time)" # Show current time
          "SUPERCONTROL,k,exec,${hyprctl} switchxkblayout brian-low-sofle-choc next"
        ]
        # ++ (lib.optionals config.targets.genericLinux.enable [
        #   "SUPERSHIFT, F2, exec, nixGL ${browser}"
        # ])
        # ++ (lib.optionals (! config.targets.genericLinux.enable) [
        #   "SUPERSHIFT, F2, exec, ${browser}"
        # ])
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
        ++ (lib.optionals config.services.swayidle.enable [
          "SUPER,l,exec,${pkill} -SIGUSR1 swayidle"
          "SUPER SHIFT,l,exec,${uswmapp}${hyprlock} --daemonize && ${pkill} -SIGUSR1 swayidle"
        ])
        # Logout screen
        ++ (lib.optionals config.programs.wlogout.enable [
          "SUPER, BACKSPACE, exec, ${uswmapp}${wlogout}"
        ])
        # Notification manager
        ++ (lib.optionals config.services.mako.enable
          ["SUPER SHIFT,c,exec,${makoctl} dismiss"])
        # Launcher
        ++ (
          lib.optionals config.programs.wofi.enable
          ["SUPER,d,exec,${uswmapp}${config.programs.wofi.package}/bin/wofi -S drun"]
        )
        ++ (
          lib.optionals config.programs.fuzzel.enable
          ["SUPER,d,exec,${uswmapp}${pkgs.fuzzel}/bin/fuzzel"]
        )
        # ++ (lib.optionals config.programs.password-store.enable [
        #   ",Scroll_Lock,exec,${pass-wofi}" # fn+k
        #   ",XF86Calculator,exec,${pass-wofi}" # fn+f12
        #   "SUPER,semicolon,exec,pass-wofi"
        # ])
        ++ [
          # (lib.optionals config.services.copyq.enable [
          # "SUPER, C, exec, ${copyq} toggle"
        ]
        #)
        # ++ (lib.optionals config.services.ulauncher.enable
        #  [ "SUPER, D, exec, ulauncher-toggle" ])
        ;

      binde = [
        # Brightness control ()
        ",XF86MonBrightnessUp,exec,light -A 10"
        ",XF86MonBrightnessDown,exec,light -U 10"
        # Volume
        ",XF86AudioRaiseVolume,exec,wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      windowrulev2 = [
        "float,class:org.keepassxc.KeePassXC"
        "float,class:com.saivert.pwvucontrol"
        "float,class:(org.speedcrunch.)"
        "float,class:com.github.hluk.copyq"
        "float,class:com.gabm.satty"
        # "move onscreen cursor 50% 50%,class:com.github.hluk.copyq"
        "move onscreen cursor 0 0,class:com.github.hluk.copyq"
        "float,class:com.nextcloud.desktopclient.nextcloud"
        "move onscreen cursor 50% 50%,class:com.nextcloud.desktopclient.nextcloud"
        "float,title:(twinkle)"
        "float,title:Bluetooth Devices"
        "float,title:Netxp.*"

        "workspace 2,class:([Vv]ivaldi.*)"
        "workspace 2,class:(org.qutebrowser.qutebrowser)"
        "workspace 2,class:firefox"

        "workspace 3,class:thunderbird"
        "float,title:(Kalendererinnerungen)"

        "workspace 7,class:spotify"
        "workspace 0,class:Slack"
      ];

      monitor =
        map
        (m: let
          resolution = "${toString m.width}x${toString m.height}@${
            toString m.refreshRate
          }";
          position = "${toString m.x}x${toString m.y}";
        in "${m.name},${
          if m.enabled
          # then "${resolution},${position},${m.scale},transform,${m.transform},bitdepth,10"
          then "${resolution},${position},${m.scale},transform,${m.transform}"
          else "disable"
        }")
        (config.monitors);

      # workspace =
      #   map (m: "${m.name},${m.workspace}")
      #   (lib.filter (m: m.enabled && m.workspace != null) config.monitors);
      # workspace = [
      #   "1, defaultName:1, monitor:desc:Lenovo Group Limited LEN T27p-10 0x4E395246"
      #   "2, defaultName:2, monitor:desc:Lenovo Group Limited LEN T27p-10 0x4E395246"
      #   "3, defaultName:3, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   "4, defaultName:4, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   "5, defaultName:5"
      #   "6, defaultName:6"
      #   "7, defaultName:7, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   "8, defaultName:8"
      #   "9, defaultName:9, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      #   "0, defaultName:0, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
      # ];
    };
    # This is order sensitive, so it has to come here.
    extraConfig = let
      sofleOld = ''
        device:brian-low-sofle-choc {
          kb_layout=de,de
          kb_variant=koy,neo_qwertz
        }
      '';
      sofleNew = ''
        # Name has to be first option, does not work with settings section
        device {
          name=brian-low-sofle-choc
          kb_layout=de,de
          kb_variant=koy,neo_qwertz
        }
      '';
      sofle =
        if builtins.compareVersions pkgs.hyprland.version "0.36" < 0
        then sofleOld
        else sofleNew;
    in ''
      # Passthrough mode (e.g. for VNC)
      bind=SUPER,P,submap,passthrough
      submap=passthrough
      bind=SUPER,P,submap,reset
      submap=reset

      ${sofle}
    '';
  };
}

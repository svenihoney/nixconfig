{
  pkgs,
  config,
  lib,
  ...
}:
let
  hyprctl = "${lib.getExe' pkgs.hyprland "hyprctl"}";

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
in
{
  wayland.windowManager.hyprland.settings = {

    bind =
      let
        runnables = {
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
        # // lib.attrsets.optionalAttrs config.programs.doom-emacs.enable {
        #   "F4" = config.programs.doom-emacs.finalEmacsPackage;
        # }
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
        commands = {
          "SHIFT + F7" = "${caelestia} shell drawers toggle dashboard";
          "F12" = "${hyprctl} switchxkblayout current next";
          "SHIFT + l" = "${caelestia} shell lock lock; systemctl hybrid-sleep";

          "Print" =
            "${grimblast} --notify --freeze save area - | ${satty_cmd} --action-on-enter save-to-clipboard --output-filename /tmp/satty-area-$(date '+%Y%m%d-%H:%M:%S').png";
          "SHIFT + Print" =
            "${grimblast} --notify --freeze save window - | ${satty_cmd} --action-on-enter save-to-file --output-filename /tmp/satty-window-$(date '+%Y%m%d-%H:%M:%S').png";
          "CONTROL + Print" =
            "${grimblast} --notify --freeze save output - | ${satty_cmd} --action-on-enter save-to-file --output-filename /tmp/satty-screen-$(date '+%Y%m%d-%H:%M:%S').png";
          # Workaround for emacs not being set up correctly for ssh access
          "F4" =
            "${lib.getExe config.programs.fish.package} -c ${lib.getExe config.programs.doom-emacs.finalEmacsPackage}";
        }
        // lib.attrsets.optionalAttrs config.programs.caelestia.enable {
          "d" = "${caelestia} shell drawers toggle launcher";

          "l" = "${caelestia} shell lock lock";
          "n" = "${caelestia} shell drawers toggle sidebar";
          "SHIFT + n" = "${caelestia} shell notifs clear";

          "F11" = "${caelestia} shell audio cycleOutput";
        };
        nosuperCommands = {
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
            { locked = true; }
          ];
        }
      ]
      # Runnable applications
      ++ (lib.mapAttrsToList (key: runnable: {
        _args = [
          "SUPER + ${key}"
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${uswmapp} ${lib.getExe runnable}\")")
        ];
      }) runnables)
      # One-shot tools
      ++ (lib.mapAttrsToList (key: command: {
        _args = [
          "SUPER + ${key}"
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${command}\")")
        ];
      }) commands)
      # One-shot tools, no SUPER key
      ++ (lib.mapAttrsToList (key: command: {
        _args = [
          "${key}"
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${command}\")")
        ];
      }) nosuperCommands)
      # One-shot tools, no SUPER key, repeatable
      ++ (lib.mapAttrsToList (key: command: {
        _args = [
          "${key}"
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${command}\")")
          { repeating = true; }
        ];
      }) repeatCommands)
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
  };
}

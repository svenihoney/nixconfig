{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  lock = "${pkgs.systemd}/bin/loginctl lock-session";

  brillo = lib.getExe pkgs.brillo;

  # timeout after which DPMS kicks in
  timeout = 1800;
in {
  # screen idle
  services.hypridle = {
    enable = true;

    # package = inputs.hypridle.packages.${pkgs.system}.hypridle;

    settings = {
      general.lock_cmd = lib.getExe config.programs.hyprlock.package;

      listener = [
        {
          timeout = timeout - 10;
          # save the current brightness and dim the screen over a period of
          # 500 ms
          on-timeout = "${brillo} -O; ${brillo} -u 500000 -S 10";
          # brighten the screen over a period of 250ms to the saved value
          on-resume = "${brillo} -I -u 250000";
        }
        {
          inherit timeout;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = timeout + 10;
          on-timeout = lock;
        }
      ];
    };
  };

  systemd.user.services.hypridle.Unit.After = lib.mkForce "graphical-session.target";

  # Use in place of hypridle's before_sleep_cmd, since systemd does not wait for
  # it to complete
  systemd.user.services.before-suspend = let
    suspendScript = pkgs.writeShellScript "suspend-script" ''
      # Pause media before suspend
      ${lib.getExe pkgs.playerctl} pause

      # Lock the compositor
      ${lock}

      # Wait for lockscreen to be up
      sleep 3
    '';
  in {
    Install.RequiredBy = ["suspend.target"];

    Service = {
      ExecStart = suspendScript.outPath;
      Type = "forking";
    };

    Unit = {
      Description = "Commands run before suspend";
      PartOf = "suspend.target";
    };
  };
}
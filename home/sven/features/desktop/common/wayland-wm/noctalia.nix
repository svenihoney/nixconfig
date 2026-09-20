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
    settings = fromTOML (builtins.readFile ./noctalia-config.toml);
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

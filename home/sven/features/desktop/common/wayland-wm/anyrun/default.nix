{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # imports = [
  #   inputs.anyrun.homeManagerModules.default
  # ];
  nix.settings = {
    builders-use-substitutes = true;
    extra-substituters = [
      "https://anyrun.cachix.org"
    ];

    extra-trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        uwsm_app
        rink
        shell
        symbols
        websearch
      ];
      # plugins = [
      #   "${pkgs.anyrun}/lib/libapplications.so"
      #   "${pkgs.anyrun}/lib/librink.so"
      #   "${pkgs.anyrun}/lib/libshell.so"
      #   "${pkgs.anyrun}/lib/libsymbols.so"
      #   "${pkgs.anyrun}/lib/libwebsearch.so"
      # ];

      width.fraction = 0.25;
      y.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = builtins.readFile (./. + "/style-dark.css");

    extraConfigFiles = {
      "uwsm_app.ron".text = ''
        Config(
          desktop_actions: false,
          max_entries: 5,
        )
      '';

      "shell.ron".text = ''
        Config(
          prefix: ">"
        )
      '';

      "websearch.ron".text = ''
        Config(
          prefix: "?",
          engines: [DuckDuckGo]
        )
      '';
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "SUPER,d,exec,${lib.getExe pkgs.uwsm} app -- ${pkgs.anyrun}/bin/anyrun"
      ];
    };
  };
}

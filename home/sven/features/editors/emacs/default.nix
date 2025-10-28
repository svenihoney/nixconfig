{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-doom-emacs-unstraightened.hmModule
  ];

  config = lib.mkIf config.svenihoney.devel.emacs {
    # Dependencies
    home.packages = with pkgs; [
      # Dash docs
      sqlite
      # Emacs vterm
      # libtool
      # libvterm
      shellcheck
      bash-language-server
    ];

    programs.doom-emacs = {
      enable = true;
      emacs = pkgs.emacs-pgtk;
      doomDir = ./doom.d;
      experimentalFetchTree = true; # Disable if there are fetcher issues
      extraPackages = epkgs:
        with epkgs; [
          vterm
          treesit-grammars.with-all-grammars
        ];
    };

    # services = {
    #   emacs = {
    #     enable = true;
    #     client.enable = true;
    #     socketActivation.enable = true;
    #     package = lib.mkForce config.programs.doom-emacs.finalEmacsPackage;
    #   };
    # };
    # programs.fish.shellAbbrs.ec = "emacsclient -t";

    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "SUPER, F4, exec, fish -c ${lib.getExe config.programs.doom-emacs.finalEmacsPackage}"
        ];
      };
    };
  };
}

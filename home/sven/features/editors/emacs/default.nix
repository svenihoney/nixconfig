{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Dependencies
  home.packages = with pkgs; [
    # Dash docs
    sqlite
    # Emacs vterm
    # libtool
    # libvterm
  ];

  imports = [
    inputs.nix-doom-emacs-unstraightened.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    emacs = pkgs.emacs-pgtk;
    doomDir = ./doom.d;
    experimentalFetchTree = true; # Disable if there are fetcher issues
    extraPackages = epkgs:
      with epkgs; [
        vterm
        # treesit-grammars.with-all-grammars
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
}

{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./stylix-cli.nix
  ];

  stylix = {
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      sansSerif = {
        # package = pkgs.ibm-plex;
        # name = "IBM Plex Sans";
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        # package = pkgs.ibm-plex;
        # name = "IBM Plex Serif";
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      monospace = {
        # package = pkgs.julia-mono;
        # name = "Julia Mono";
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrains Mono Nerd Font";
        # package = pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" ]; };
        # name = "BlexMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 9;
        desktop = 9;
        terminal = 10;
      };
    };

    targets.gnome.enable = true;
  };
}

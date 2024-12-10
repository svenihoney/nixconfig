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
    enable = true;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
    image = "${pkgs.plasma-workspace-wallpapers}/share/wallpapers/MilkyWay/contents/images/5120x2880.png";

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

        # package = pkgs.jetbrains-mono;
        # name = "JetBrainsMono";

        package = pkgs.nerd-fonts.jetbrains-mono;
        # name = "JetBrainsMono Nerd Font";
        name = "JetBrainsMono";

        # package = pkgs.nerdfonts.override {fonts = ["Cousine"];};
        # name = "Cousine Nerd Font";
        # package = pkgs.nerdfonts.override {fonts = ["Lilex"];};
        # name = "Lilex Nerd Font";

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
        popups = 10;
      };
    };

    targets.gnome.enable = true;
  };
}

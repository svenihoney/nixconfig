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

    # image = pkgs.nixos-artwork.wallpapers.simple-dark-gray.gnomeFilePath;
    # image = pkgs.fetchurl {
    #   url =
    #     "https://r4.wallpaperflare.com/wallpaper/9/737/99/carbon-fiber-textured-texture-minimalism-wallpaper-e8d67d3810b0ecd800ecd1ee78d2846a.jpg";
    #   sha256 =
    #     "1d40a99a005873c686e0f193bf1a851889ff150f87551c77afaf577d90aef513";
    # };

    # image = pkgs.fetchurl {
    #   url =
    #     "https://img.peapix.com/ac1f084c6a274aff9ddc97517f2d81d8_UHD.jpg?attachment&modal";
    #   sha256 =
    #     "570b8b277326e39f30914b7d082a8c9f2325f09304edb825c31f992e2dc8fa4c";
    # };

    # eat sleep code repeat
    # image = pkgs.fetchurl {
    #   url = "https://raw.githubusercontent.com/D3Ext/aesthetic-wallpapers/main/images/routine.jpg";
    #   sha256 = "sha256-mTWlrcD3JSoOW1rvyqroM5w9qjJY4pukbJeLTaJGEtQ=";
    # };

    # MilkyWay from KDE
    # image = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/MilkyWay/contents/images/5120x2880.png";

    # Chalk board
    # image = pkgs.fetchurl {
    #   url = "https://c1.wallpaperflare.com/path/942/218/505/black-board-chalk-traces-school-057e0867f80cd327b7d2ed2b255819ec.jpg";
    #   sha256 = "sha256-fywmonoQpC1K17NGESBpfJm5vOD1Frdp3JXd5Z+f2/4=";
    # };

    # Leaves blue
    # image = pkgs.fetchurl {
    #   url = "https://4kwallpapers.com/images/wallpapers/leaves-blue-3840x2160-17461.jpeg";
    #   sha256 = "sha256-S2x7nt/7wBhFcYf094Fwm/3AqiIee/pizS3F8OgB3fQ=";
    # };
    image = ./assets/images/liquid1.jpg;

    icons = {
      enable = true;
      dark = "Papirus-Dark";
      light = "Papirus";
      package = pkgs.papirus-icon-theme;
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

        # package = pkgs.nerd-fonts.jetbrains-mono;
        # name = "JetBrainsMono Nerd Font";

        # package = pkgs.nerd-fonts.fantasque-sans-mono;
        # name = "FantasqueSansMono Nerd Font";

        # package = pkgs.nerd-fonts.monaspace;
        package = pkgs.monaspace;
        name = "Monaspace Argon NF";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 9;
        desktop = 9;
        terminal = 11;
        popups = 11;
      };
    };

    targets.gnome.enable = true;
  };

}

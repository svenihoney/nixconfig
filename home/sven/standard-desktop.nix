{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix

    ./features/emacs
    ./features/nvim/lsp.nix
    # ./features/desktop/common/keepassxc.nix
    ./features/desktop/common/nixgl.nix
  ];

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/hardcore.yaml";
    # polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    # We need this otherwise the autoimport clashes with our manual import.
    # homeManagerIntegration.autoImport = false;
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
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/D3Ext/aesthetic-wallpapers/main/images/routine.jpg";
      sha256 = "sha256-mTWlrcD3JSoOW1rvyqroM5w9qjJY4pukbJeLTaJGEtQ=";
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
  };

  # colorscheme = lib.mkDefault colorSchemes.dracula;
  # wallpaper =
  #   let
  #     largest = f: xs: builtins.head (builtins.sort (a: b: a > b) (map f xs));
  #     largestWidth = largest (x: x.width) config.monitors;
  #     largestHeight = largest (x: x.height) config.monitors;
  #   in
  #   lib.mkDefault (nixWallpaperFromScheme
  #     {
  #       scheme = config.colorscheme;
  #       width = largestWidth;
  #       height = largestHeight;
  #       logoScale = 4;
  #     });
  # home.file.".colorscheme".text = config.colorscheme.slug;
}

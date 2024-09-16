{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    polarity = "dark";
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
    # image = pkgs.fetchurl {
    #   url = "https://raw.githubusercontent.com/D3Ext/aesthetic-wallpapers/main/images/routine.jpg";
    #   sha256 = "sha256-mTWlrcD3JSoOW1rvyqroM5w9qjJY4pukbJeLTaJGEtQ=";
    # };

    # MilkyWay from KDE
    image = lib.mkDefault "${pkgs.plasma-workspace-wallpapers}/share/wallpapers/MilkyWay/contents/images/5120x2880.png";

    # Chalk board
    # image = pkgs.fetchurl {
    #   url = "https://c1.wallpaperflare.com/path/942/218/505/black-board-chalk-traces-school-057e0867f80cd327b7d2ed2b255819ec.jpg";
    #   sha256 = "sha256-fywmonoQpC1K17NGESBpfJm5vOD1Frdp3JXd5Z+f2/4=";
    # };
  };
}

{pkgs, ...}: {
  imports = [
    # ./lutris.nix
    # ./steam.nix
    # ./prism-launcher.nix
    # ./runescape.nix
    ../desktop/common/wine.nix
  ];
  # home.packages = with pkgs; [ gamescope ];
  home.packages = with pkgs; [
    faugus-launcher
    steam
  ];
}

{ inputs, outputs, ... }: {
  imports = [
    ./global
    ./standard-desktop.nix
    # ./features/desktop/hyprland
    # ./features/rgb
    # ./features/productivity
    # ./features/pass
    # ./features/games
    # ./features/music
  ];

  targets.genericLinux.enable = true;
  # colorscheme = inputs.nix-colors.colorschemes.tokyo-night-storm;
  # wallpaper = outputs.wallpapers.watercolor-beach;

  #  ------   -----   ------
  # | DP-3 | | DP-1| | DP-2 |
  #  ------   -----   ------
  monitors = [
    {
      name = "desc:Lenovo Group Limited LEN T27p-10 0x4E395246";
      width = 3840;
      height = 2160;
      workspace = "1";
      primary = true;
    }
    {
      name =
        "desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564";
      width = 2560;
      height = 1440;
      x = 3840;
      workspace = "3";
      transform = "1";
    }
  ];
}

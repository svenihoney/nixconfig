{ inputs, outputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
    # ./features/desktop/wireless
    # ./features/productivity
    # ./features/pass
    # ./features/games
  ];

  # wallpaper = outputs.wallpapers.aenami-lunar;
  # colorscheme = inputs.nix-colors.colorSchemes.atelier-heath;

  monitors = [
    {
      name = "desc:BOE 0x08E2";
      width = 1920;
      height = 1080;
      workspace = "1";
      primary = true;
    }
    {
      name =
        "desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564";
      width = 2560;
      height = 1440;
      x = 1920;
      workspace = "3";
      transform = "1";
    }
  ];
}

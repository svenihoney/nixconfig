{
  imports = [
    ./global
    ./features/cli
    ./features/desktop/hyprland
    ./features/desktop/wireless
    ./features/trusted
    ./features/games
  ];
  monitors = [{
    name = "eDP-1";
    width = 1920;
    height = 1080;
    workspace = "1";
  }];
}
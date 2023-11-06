{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    cinnamon.warpinator
  ];
}

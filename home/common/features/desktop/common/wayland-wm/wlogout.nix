{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.wlogout = {
    enable = lib.mkDefault true;
  };
}

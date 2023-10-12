{ pkgs, config, lib, ... }:
{
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = lib.mkForce "gtk2";
      package = pkgs.qt6Packages.qt6gtk2;
    };
  };
}

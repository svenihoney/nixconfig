{ pkgs, config, lib, ... }:
{
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = lib.mkForce "adwaita-dark";
      package = pkgs.adwaita-qt6;
    };
  };
}

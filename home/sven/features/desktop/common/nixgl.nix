{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  # home.packages = lib.optionals config.targets.genericLinux.enable [
  targets.genericLinux.nixGL = {
    packages = inputs.nixgl.packages;
    defaultWrapper = "mesa";
  };

  programs = lib.mkIf (config.targets.genericLinux.enable == true) {
    kitty = {
      package = config.lib.nixGL.wrap pkgs.kitty;
    };
    vivaldi = {
      package = config.lib.nixGL.wrap pkgs.vivaldi;
    };
    ghostty = {
      package = config.lib.nixGL.wrap pkgs.ghostty;
    };
  };
  wayland.windowManager.hyprland.package = config.lib.nixGL.wrap pkgs.hyprland;
}

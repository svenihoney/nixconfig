{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.geoclue2.enable = true;
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-gtk;
    };
  };
  security.pam.services = {swaylock = {};};
}

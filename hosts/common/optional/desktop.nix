{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      # common.default = ["kde"];
      # hyprland.default = ["kde" "hyprland"];
      common = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.FileChooser" = "kde";
      };
      # hyprland.default = ["gtk" "hyprland"];
    };
    # wlr.enable = true;
    # extraPortals = [pkgs.xdg-desktop-portal-gtk];
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
  };

  services.geoclue2.enable = true;
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-wlr;
      withUWSM = true;
      # portalPackage = pkgs.xdg-desktop-portal-kde;
    };
  };
  security.pam.services = {
    swaylock = {};
    hyprlock = {};
  };
}

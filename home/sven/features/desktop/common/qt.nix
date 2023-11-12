{
  pkgs,
  config,
  lib,
  ...
}: {
  qt = {
    enable = true;
    # platformTheme = "gtk";
    style = {
      name = lib.mkForce "gtk3";
    };
    # platformTheme = "gtk";
  };

  home.packages = with pkgs; [libsForQt5.qtstyleplugins qt6Packages.qt6gtk2 adwaita-qt adwaita-qt6];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";

    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # QT_WAYLAND_FORCE_DPI = "physical";
  };

}

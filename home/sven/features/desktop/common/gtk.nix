{
  config,
  pkgs,
  lib,
  ...
}:
# let
#   inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
# in
# rec {
{
  gtk = {
    enable = true;
    # font = {
    #   name = config.fontProfiles.regular.family;
    #   size = 12;
    # };
    # theme = {
    #   package = lib.mkForce pkgs.gnome.gnome-themes-extra;
    #   name = lib.mkForce "Adwaita-dark";
    # };
    # iconTheme = {
    #   name = "Papirus";
    #   package = pkgs.papirus-icon-theme;
    # };
    # gtk4 = {
    #   theme = null;
    # };
  };

  xfconf.enable = false;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      # Enable middle mouse button paste in GTK applications
      gtk-enable-primary-paste = true;
    };
  };
}

{config, ...}: {
  services.mako = {
    enable = true;
    # iconPath =
    #   if kind == "dark" then
    #     "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark"
    #   else
    #     "${config.gtk.iconTheme.package}/share/icons/Papirus-Light";
    # font = "${config.fontProfiles.regular.family} 12";
    settings = {
      padding = "10,20";
      anchor = "top-right";
      width = 400;
      height = 150;
      border-size = 2;
      default-timeout = 12000;
      # backgroundColor = "#${colors.base00}dd";
      # borderColor = "#${colors.base03}dd";
      # textColor = "#${colors.base05}dd";
      layer = "overlay";
    };
  };
}

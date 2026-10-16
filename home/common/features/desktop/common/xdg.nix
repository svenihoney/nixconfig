{
  pkgs,
  config,
  ...
}: {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mime.enable = true;
    mimeApps = {
      enable = true;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = false;
      extraConfig = {
        # XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };

  home.packages = [
    pkgs.xdg-utils
  ];
}

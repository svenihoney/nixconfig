{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    udiskie = {
      enable = true;
      automount = true;
      tray = "auto";
      settings = {
        program_options = {
          menu = "flat";
        };
      };
    };
  };
}

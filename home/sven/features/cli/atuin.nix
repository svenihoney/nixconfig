{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    atuin = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;

      settings = {
        filter_mode_shell_up_key_binding = "session";
      };
      flags = [
        "--disable-up-arrow"
      ];
    };
  };
}

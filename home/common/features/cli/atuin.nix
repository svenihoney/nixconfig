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
      enableZshIntegration = true;
      enableNushellIntegration = true;

      settings = {
        filter_mode_shell_up_key_binding = "session";
        ai.enabled = true;
      };
      flags = [
        "--disable-up-arrow"
      ];
    };
  };
}

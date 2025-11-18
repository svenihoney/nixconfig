{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    ollama.service.enable = lib.mkEnableOption "Enable ollama service module";
    ollama.tools.enable = lib.mkEnableOption "Enable ollama clients";
  };
  config = {
    services.ollama = lib.mkIf config.ollama.service.enable {
      enable = true;
      # acceleration = "rocm"; # Will be set in machine config
      # environmentVariables = {
      #   HCC_AMDGPU_TARGET = "gfx1030"; # used to be necessary, but doesn't seem to anymore
      # };
      # rocmOverrideGfx = "10.3.0";
    };
    home.packages = with pkgs;
      lib.mkIf config.ollama.tools.enable [
        oterm
        alpaca
        aider-chat
        lmstudio
      ];
  };
}

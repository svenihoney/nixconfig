{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  options = {
    ollama.service.enable = lib.mkEnableOption "Enable ollama service module";
    ollama.tools.enable = lib.mkEnableOption "Enable ollama clients";
    llama-cpp.enable = lib.mkEnableOption "Enable llama-cpp";
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
      lib.mkMerge
      [
        [
          # oterm
          # alpaca
          # aider-chat
          # lmstudio
          opencode
        ]
        (
          lib.mkIf osConfig.hardware.amdgpu.initrd.enable
          [
            llama-cpp-rocm
          ]
        )
        (
          lib.mkIf (!osConfig.hardware.amdgpu.initrd.enable)
          [
            llama-cpp
          ]
        )
      ];

    systemd.user.services.llama-cpp = lib.mkIf config.llama-cpp.enable {
      Unit = {
        Description = "Run llama-cpp with llama-swap as frontend";
      };
      Install = {
        WantedBy = ["default.target"];
      };
      Service = {
        ExecStart = "${lib.getExe pkgs.llama-swap} --listen :8090";
        WorkingDirectory = "/home/sven/kunden/vorwerk/image/llama-cpp";
      };
    };
  };
}

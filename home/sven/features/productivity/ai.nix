{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  options = {
    # ollama.service.enable = lib.mkEnableOption "Enable ollama service module";
    # ollama.tools.enable = lib.mkEnableOption "Enable ollama clients";
    # llama-cpp.enable = lib.mkEnableOption "Enable llama-cpp";
    ai-server.enable = lib.mkEnableOption "Enable local AI server";
    ai-client.enable = lib.mkEnableOption "Enable AI client";
  };
  config =
    let
      llamaPackage =
        if osConfig.hardware.amdgpu.initrd.enable then pkgs.llama-cpp-rocm else pkgs.llama-cpp;
    in
    {
      home.packages =
        with pkgs;
        [ ]
        ++ (lib.optionals config.ai-client.enable [
          # oterm
          # alpaca
          # aider-chat
          # lmstudio
          opencode
        ])
        ++ (lib.optionals config.ai-server.enable [
          llamaPackage
        ]);
      # home.packages = with pkgs;
      #   lib.mkMerge
      #   [
      #     (
      #       lib.mkIf config.ai-client.enable
      #       [
      #         # oterm
      #         # alpaca
      #         # aider-chat
      #         # lmstudio
      #         opencode
      #       ]
      #     )
      #     (
      #       lib.mkIf config.ai-server.enable
      #       [
      #         llamaPackage
      #       ]
      #     )
      #   ];

      services.ollama = lib.mkIf config.ai-server.enable {
        enable = true;
        acceleration = lib.optionals osConfig.hardware.amdgpu.initrd.enable "rocm";
        # acceleration = "rocm"; # Will be set in machine config
        # environmentVariables = {
        #   HCC_AMDGPU_TARGET = "gfx1030"; # used to be necessary, but doesn't seem to anymore
        # };
        # rocmOverrideGfx = "10.3.0";
      };
      systemd.user.services.llama-cpp = lib.mkIf config.ai-server.enable {
        Unit = {
          Description = "Run llama-cpp with llama-swap as frontend";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          ExecStart = "${lib.getExe pkgs.llama-swap} --listen :8090";
          WorkingDirectory = "/home/sven/kunden/vorwerk/image/llama-cpp";
        };
      };
    };
}

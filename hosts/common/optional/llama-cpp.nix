{
  pkgs,
  lib,
  ...
}: {
  hardware.graphics.enable = true;

  services.llama-cpp = {
    # enable = config.ai-server.enable;
    enable = true;
    package = pkgs.llama-cpp-rocm; # Alternative: pkgs.llama-cpp-vulkan
    openFirewall = true;

    settings = {
      host = "0.0.0.0";
      port = 8080;

      models-preset = (pkgs.formats.ini {}).generate "models-preset.ini" {
        "Qwen3.8-27B" = {
          # Download nach /var/cache/llama-cpp
          hf = "unsloth/Qwen3.8-27B-GGUF:UD-Q3_K_XL";
          alias = "Qwen3.8-27B";

          n-gpu-layers = "99";
          ctx-size = "65536";
          flash-attn = "on";
          cache-type-k = "q8_0";
          cache-type-v = "q4_0";
          jinja = "on";

          # Spekulatives Decoding per n-gram (kein Draft-Modell, kein Extra-VRAM)
          spec-type = "ngram-simple";
          # spec-ngram-size-n = "12";
          # spec-ngram-size-m = "48";
          # spec-ngram-mod-n-max = "16";
          # spec-ngram-mod-n-min = "2";

          sleep-idle-seconds = "120";
        };
      };
    };
  };

  # Zugriff auf die GPU
  systemd.services.llama-cpp = {
    environment.LLAMA_CACHE = lib.mkForce "/home/sven/kunden/vorwerk/image/llama-cpp/cache";
    serviceConfig = {
      SupplementaryGroups = ["video" "render"];
      TimeoutStartSec = "infinity"; # erster Start lädt GBs
    };
  };
}

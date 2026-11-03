{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  programs.opencode = {
    settings = {
      provider = {
        ollama = {
          models = {
            "qwen3:14b" = {
              "_launch" = true;
              name = "qwen3:14b";
            };
            "gpt-oss:20b-16k" = {
              name = "GPT OSS 20b (16k context)";
            };
            "gpt-oss:20b-32k" = {
              name = "GPT OSS 20b (32k context)";
              options = {
                extraBody = {
                  think = "high";
                };
              };
            };
            "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_S" = {
              name = "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_S";
            };
          };
          name = "Ollama";
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = "http://maja:11434/v1";
          };
        };
      };
    };
  };

  programs.pi-coding-agent = {
    models = {
      providers = {
        ollama = {
          baseUrl = "http://maja:11434/v1";
          api = "openai-completions";
          apiKey = "ollama";
          models = [
            {id = "hf.co/empero-ai/Qwen3.8-35B-A3B-Distill-GGUF:Q4_K_M";}
            {id = "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_S";}
            {id = "gpt-oss:20b-32k";}
            {id = "gemma4:12b";}
            {id = "deepseek-coder-v2:latest";}
          ];
        };
        requesty = {
          name = "Requesty";
          api = "openai-completions";
          baseUrl = "https://router.requesty.ai/v1";
          apiKey = "!${lib.getExe pkgs.libsecret} lookup requesty apikey";
          models = [
            {id = "novita/ling-3.1-flash";}
            {id = "nvidia/nemotron-3.5-lightning-30b-a3b";}
          ];
        };
      };
    };
    settings = {
      defaultProvider = "ollama";
      defaultModel = "gemma4:12b";
      packages = map (n: "${inputs.pi-packages.packages.${pkgs.stdenv.hostPlatform.system}."pi-${n}"}") [
        # "opencode-pi"
        "pi-web-access"
        # "git:github.com/requestyai/pi-requesty"
        "pi-requesty-provider"
      ];
      # pi-web-search = {
      #   backends = ["searxng"];
      #   searxngUrl = "https://searxng.leiderfischer.de";
      # };
    };
  };
  home.file."${config.programs.pi-coding-agent.configDir}/agent/web-search.json".text = builtins.toJSON {
    searxngBaseUrl = "https://searxng.leiderfischer.de";
    workflow = "none";
  };
}

{
  pkgs,
  inputs,
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
            {
              id = "hf.co/empero-ai/Qwen3.8-35B-A3B-Distill-GGUF:Q4_K_M";
            }
            {
              id = "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_S";
            }
            {
              id = "gpt-oss:20b-32k";
            }
            {
              id = "gemma4:12b";
            }
          ];
        };
      };
    };
    settings = {
      packages = map (n: "${inputs.pi-packages.packages.${pkgs.stdenv.hostPlatform.system}."pi-${n}"}") [
        # "opencode-pi"
        "pi-better-web-search"
      ];
    };
  };
}

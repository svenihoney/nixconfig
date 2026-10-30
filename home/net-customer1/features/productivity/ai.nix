{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  programs.opencode = {
    settings = {
      provider = {
        lite-llm = {
          models = {
            "qwen3.8" = {
              "_launch" = true;
              name = "qwen3.8";
            };
          };
          name = "lite-llm";
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = "https:/litellm.software.ads";
          };
        };
      };
    };
  };

  programs.pi-coding-agent = {
    settings = {
      defaultModel = "qwen3.8";
      defaultProvider = "openai";
    };
    models = {
      providers = {
        openai = {
          baseUrl = "https://litellm.software.ads";
          api = "openai-completions";
          apiKey = "!${lib.getExe pkgs.libsecret} lookup ki.software.ads fischer";
          models = [
            {
              id = "qwen3.8";
              name = "Qwen 3.8";
              reasoning = true;
              input = [
                "text"
                "image"
              ];
              contextWindow = 140000;
              maxTokens = 65000;
              cost = {
                input = 0;
                output = 0;
                cacheRead = 0;
                cacheWrite = 0;
              };
              thinkingLevelMap = {
                # off = null;
                # minimal = null;
                low = "low";
                medium = "medium";
                # high = null;
                xhigh = "xhigh";
                # max = null;
              };
            }
          ];
        };
      };
    };
  };
  ai.sandbox.extraAllowedDomains = ["software.ads"];
}

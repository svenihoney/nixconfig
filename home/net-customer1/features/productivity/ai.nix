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
        strata = {
          baseUrl = "http://nvidia-spark-gb10.software.ads:8080/v1";
          api = "openai-completions";
          apiKey = "!${lib.getExe pkgs.libsecret} lookup nvidia-spark-gb10.software.ads strata";
          compat = {
            supportsDeveloperRole = false;
            supportsReasoningEffort = false;
          };
          models = [
            {
              id = "swift-1.5-iq3_s";
              name = "Qwen3.8-Flash-Next (Strata, local)";
              reasoning = true;
              input = ["text"];
              contextWindow = 262144;
              maxTokens = 4096;
              thinking = {
                mode = "effort";
                efforts = ["minimal" "low" "medium" "high"];
                defaultLevel = "low";
                # cost = "{input: 0, output: 0, cacheRead: 0, cacheWrite: 0";
              };
            }
          ];
        };
      };
    };
  };
  ai.sandbox.extraAllowedDomains = ["software.ads"];
}

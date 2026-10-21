{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  options = {
    # ollama.service.enable = lib.mkEnableOption "Enable ollama service module";
    # ollama.tools.enable = lib.mkEnableOption "Enable ollama clients";
    # llama-cpp.enable = lib.mkEnableOption "Enable llama-cpp";
    ai-server.enable = lib.mkEnableOption "Enable local AI server";
    ai-client.enable = lib.mkEnableOption "Enable AI client";
    ai.sandbox.extraAllowedDomains = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Extra network.allowedDomains to add to the pi sandbox.json on top of the defaults";
    };
  };
  config =
    # let
    #   llamaPackage =
    #     if osConfig.hardware.amdgpu.initrd.enable
    #     then pkgs.llama-cpp-rocm
    #     else pkgs.llama-cpp;
    # in
    {
      home.packages =
        with pkgs;
          []
          ++ (lib.optionals config.ai-client.enable [
            oterm
            # alpaca
            # aider-chat
            # lmstudio
            # opencode
          ])
        # ++ (lib.optionals config.ai-server.enable [
        #   llamaPackage
        # ]);
        ;

      services.ollama = lib.mkIf config.ai-server.enable {
        enable = true;
        acceleration = lib.optionals osConfig.hardware.amdgpu.initrd.enable "rocm";
        # acceleration = "rocm"; # Will be set in machine config
        environmentVariables = {
          #   HCC_AMDGPU_TARGET = "gfx1030"; # used to be necessary, but doesn't seem to anymore
          OLLAMA_KEEP_ALIVE = "3m";
          OLLAMA_CONTEXT_LENGTH = "32768";
          OLLAMA_KV_CACHE_TYPE = "q4_0";
        };
      };

      programs.opencode = {
        enable = config.ai-client.enable;
      };

      xdg.configFile."opencode/AGENTS.md".text = ''
        - **Read surgically.** Read only the line ranges you need (offset/limit). Never re-read a file you've already seen unless it may have changed. Never read an entire large file.
        - **Search narrowly.** Use tight glob/grep patterns and cap results (e.g., `rg --max-count 20`, `| head -50`). If 2–3 targeted searches fail, ask me instead of exploring further.
        - **Keep command output small.** Pipe potentially long output through `head`/`tail`/`grep`, or redirect to a file and read only the relevant part.
        - **Edit minimally.** Prefer small targeted edits over rewriting files. Never print code back to me that you've just written or read — I can see the tool calls.
        - **Be terse.** Don't restate the task or explain your reasoning unless I ask. Finish with bullet lists or at most 1–2 sentences.
        - **Batch tool calls.** Make independent calls in parallel rather than one per turn. Run the cheapest check that validates a change; run full test suites only when I ask or the change touches tested paths.
        - **No subagents unless I explicitly ask.** They re-read context and multiply cost.
        - **If the task is ambiguous, ask one short question** instead of guessing and doing expensive rework.
        - **Stop when done.** No unsolicited cleanup, comments, docstrings, or extra verification passes.
        - **Searching** When searching, if nothing is found after checking 5 sources, stop searching immediately.
        - **Language** Casual, relaxed, or sloppy language is totally fine to use.
      '';


      programs.pi-coding-agent = {
        enable = config.ai-client.enable;
        configDir = "${config.xdg.configHome}/pi";
        extraPackages = with pkgs; [nodejs ripgrep bubblewrap socat];
        # extraPackages = with pkgs; [ nodejs ];
        settings = {
          defaultThinkingLevel = "low";
          hideThinkingBlock = true;
          packages = [
            # "npm:pi-opencode-free"
            # "git:github.com/Leoo0x1/pi-opencode-free"
            # "git:github.com/pedrostarkealexis/pi-opencode-free/"
            # "npm:@ollama/pi-web-search"
            "npm:@juicesharp/rpiv-ask-user-question"
            "npm:@juicesharp/rpiv-todo"
            # "npm:@gotgenes/pi-permission-system"
            "npm:pi-cc-extensions"
            "npm:@dietrichgebert/ponytail"
            "npm:pi-caveman"
            "npm:billion-context"
            "npm:pi-lens"
            "npm:pi-sandbox"
          ];
        };
      };

      home.file."${config.programs.pi-coding-agent.configDir}/extensions/pi-permission-system/config.json".text = builtins.toJSON {
        yoloMode = true;
        permission = {
          "*" = "allow";
          path = {
            "*" = "allow";
            "*.env" = "deny";
            "*.env.*" = "deny";
            "*.env.example" = "allow";
            "~/.ssh/*" = "deny";
          };
          bash = {
            "*" = "allow";
            "rm -rf /*" = "deny";
            "rm -rf ~" = "deny";
            "rm -rf /" = "deny";
          };
          external_directory = "allow";
        };
      };
      home.file."${config.programs.pi-coding-agent.configDir}/agent/sandbox.json".text = builtins.toJSON {
        enabled = true;
        permissionPromptTimeoutSeconds = 600;
        allowBrowserProcess = true;
        network = {
          allowLocalBinding = true;
          allowUnauthenticatedSocksProxy = true;
          allowAllUnixSockets = true;
          allowedDomains = (
            [
              "localhost"
              "127.0.0.1"
              # "html.duckduckgo.com"
              # "*.npmjs.org"
              # "*.pypi.org"
              # "*.github.com"
              # "raw.githubusercontent.com"
              # "mcp.context7.com"
            ]
            ++ config.ai.sandbox.extraAllowedDomains
          );
          deniedDomains = [];
        };
        filesystem = {
          denyRead = ["/home"];
          allowRead = [
            "."
            # "~/projects"
            "~/.config"
            "~/.cargo"
            "~/.local"
            "/nix/store"
            "~/.cache"
          ];
          allowWrite = [
            "."
            "/tmp"
            "~/.pi/"
            "~/.cache/uv"
            "~/.rustup"
            "~/.agent-browser"
          ];
          denyWrite = [
            ".env"
            ".env.*"
            "*.pem"
            "*.key"
          ];
        };
      };

      # In your Nix configuration
      # nix.settings = {
      #   extra-substituters = [ "https://nix-cache.lsinfra.de/pi-packages" ];
      #   extra-trusted-public-keys = [ "pi-packages:OF+SNU2ALJB8M+cQP/RfFOuKIOMN0w4WiV8k01pvUC4=" ];
      # };
    };
}

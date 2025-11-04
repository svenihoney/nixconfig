{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.lsp.enable {
    plugins = {
      copilot-lua = {
        enable = false;
        lazyLoad.settings.event = ["DeferredUIEnter"];
        settings = {
          panel = {
            auto_refresh = true;
            enabled = !config.plugins.blink-cmp-copilot.enable;
          };
          nes = {
            enabled = !config.plugins.blink-cmp-copilot.enable;
          };
          suggestion = {
            enabled = !config.plugins.blink-cmp-copilot.enable;
            # auto_trigger = false;
            # debounce = 90;
            # hide_during_completion = false;
            # keymap = {
            #   accept_line = false;
            #   accept_word = false;
            # };
          };

          on_attach = ''
            function()
                if not vim.g.copilot_enabled then
                  -- Immediately disable Copilot for this session
                  vim.cmd('Copilot disable')
                end
              end'';
        };
      };

      copilot-chat = {
        inherit (config.plugins.copilot-lua) enable;
      };

      avante = {
        enable = true;
        lazyLoad.settings.event = ["DeferredUIEnter"];
        settings = {
          # provider = "ollama"; # Default provider at startup
          provider = "copilot"; # Default provider at startup
          behaviour = {
            auto_set_keymaps = true;
            auto_suggestions = false; # Set to true if you want auto-suggestions
            support_paste_from_clipboard = false;
            auto_apply_diff_after_generation = false;
          };
          diff = {
            autojump = true;
            debug = false;
            list_opener = "copen";
          };
          highlights = {
            diff = {
              current = "DiffText";
              incoming = "DiffAdd";
            };
          };
          hints = {
            enabled = true;
          };
          mappings = {
            diff = {
              both = "cb";
              next = "]x";
              none = "c0";
              ours = "co";
              prev = "[x";
              theirs = "ct";
            };
          };
          providers = {
            ollama = {
              endpoint = "http://maja:11434";
              # model = "qwen2.5-coder:latest";
              # model = "danielsheep/Qwen3-Coder-30B-A3B-Instruct-1M-Unsloth:UD-IQ3_XXS";
              model = "qwen3:8b";
              is_env_set = {
                __raw = ''
                  function()
                    return true
                  end
                '';
              };

              # api_type = "ollama";
              extra_request_body = {
                options = {
                  temperature = 0.7;
                  num_ctx = 8192;
                  keep_alive = "5m";
                };
              };
            };
            copilot = {
              endpoint = "https://api.githubcopilot.com";
              model = "claude-sonnet-4-20250514";
              api_key_name = "cmd:secret-tool lookup service github-copilot";
              timeout = 30000;
            };
            gemini = {
              # endpoint = "https://generativelanguage.googleapis.com/v1beta/models";
              # model = "gemini-2.5-flash";
              model = "gemini-2.5-pro";
              api_key_name = "cmd:secret-tool lookup gemini apikey";
              timeout = 30000;
            };
          };
        };
      };
      which-key.settings.spec = lib.optionals config.plugins.avante.enable [
        {
          __unkeyed-1 = "<leader>a";
          group = "Avante";
          icon = "";
        }
      ];
    };
    keymaps = lib.optionals config.plugins.avante.enable [
      {
        mode = "n";
        key = "<leader>aC";
        action = "<CMD>AvanteClear<CR>";
        options.desc = "avante: clear";
      }
    ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    # codecompanion.enable = lib.mkEnableOption "Enable codecompanion module";
    codecompanion.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.codecompanion.enable {
    plugins.codecompanion = {
      enable = true;
      settings = {
        adapters.http = {
          ollama = {
            __raw = ''
              function()
                return require('codecompanion.adapters').extend('ollama', {
                  env = {
                    url = "http://maja:11434",
                  },
                  parameters = {
                    temperature = 0.8,
                    top_k = 40,
                    top_p = 0.7,
                    repeat_penalty = 1.1,
                    num_ctx = 32768,
                    stream = true,
                  },
                  schema = {
                    model = {
                      default = "gpt-oss:20b",
                    },
                  }
                })
              end
            '';
          };
        };
        opts = {
          log_level = "TRACE";
          send_code = true;
          use_default_actions = true;
          use_default_prompts = true;
          display = {
            action_palette = {
              provider = "telescope";
            };
            completion = {
              provider = "nvim-cmp";
            };
            command_palette = {
              provider = "telescope";
            };
            chat = {
              window = {
                width = 0.4; # 40% of screen width
                border = "rounded";
              };
            };
          };
          actions = {
            auto_import = true;
            auto_format = true;
          };
        };
        strategies = {
          agent = {
            adapter = "ollama";
          };
          chat = {
            adapter = "ollama";
          };
          inline = {
            adapter = "ollama";
          };
        };
      };
    };
    keymaps = [
      # codecompanion
      {
        mode = ["n" "v"];
        key = "<leader>aa";
        action = "<cmd>CodeCompanionActions<CR>";
        options = {
          desc = "CodeCompanion actions";
          silent = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>ac";
        action = "<cmd>CodeCompanionChat Toggle<CR>";
        options = {
          desc = "Toggle CodeCompanion chat";
          silent = true;
        };
      }
      {
        mode = "v";
        key = "<leader>as";
        action = "<cmd>CodeCompanionChat Add<CR>";
        options = {
          desc = "Send selection to chat";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ai";
        action = "<cmd>CodeCompanion<CR>";
        options = {
          desc = "Inline assistant";
          silent = true;
        };
      }
    ];
  };
}

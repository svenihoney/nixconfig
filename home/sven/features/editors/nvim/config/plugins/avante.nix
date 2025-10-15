{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.lsp.enable {
    plugins = {
      avante = {
        enable = true;
        settings = {
          provider = "ollama"; # Default provider at startup
          behaviour = {
            auto_set_keymaps = true;
            auto_suggestions = false; # Set to true if you want auto-suggestions
            support_paste_from_clipboard = false;
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
              model = "qwen2.5-coder";
            };
            copilot = {
              endpoint = "https://api.githubcopilot.com";
              model = "claude-sonnet-4-20250514";
              api_key_name = "cmd:secret-tool lookup service github-copilot";
              timeout = 30000;
            };
            gemini = {
              endpoint = "https://generativelanguage.googleapis.com/v1beta/models";
              model = "gemini-2.5-flash";
              api_key_name = "cmd:secret-tool lookup gemini apikey";
              timeout = 30000;
            };
          };
        };
      };
    };
  };
}

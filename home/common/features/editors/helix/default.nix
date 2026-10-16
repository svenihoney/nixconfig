{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.helix {
    home.sessionVariables.COLORTERM = "truecolor";
    programs.helix = {
      enable = true;
      # extraPackages = [pkgs.helix-gpt];
      extraPackages = [pkgs.ty];
      # defaultEditor = true;
      settings = {
        # theme = lib.mkDefault "dracula";
        editor = {
          color-modes = true;
          line-number = "relative";
          bufferline = "multiple";
          lsp.display-messages = true;
          # mouse = false;
          # middle-click-paste = false;
        };
        keys = {
          normal = {
            esc = ["collapse_selection" "keep_primary_selection"];
          };
        };
      };
      languages = {
        #   # # the language-server option currently requires helix from the master branch at https://github.com/helix-editor/helix/
        #   # language-server.typescript-language-server = with pkgs.nodePackages; {
        #   #   command = "${typescript-language-server}/bin/typescript-language-server";
        #   #   args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
        #   # };
        # language-server = {
        #   helix-assist = {
        #     command = lib.getExe pkgs.helix-assist;
        #     # Optional
        #     # args = [
        #     args = [
        #       "--completion-timeout"
        #       "30000"
        #       "--fetch-timeout"
        #       "30000"
        #       "--handler"
        #       "openai"
        #       "--num-suggestions"
        #       "2"
        #       "--openai-endpoint"
        #       "http://127.0.0.1:11434/v1"
        #       "--openai-key"
        #       "ollama"
        #       "--openai-model"
        #       "Qwen3-Coder-30B-16k"
        #     ];
        #     # args = ["--handler" "openai" "--num-suggestions" "2" "--openai-endpoint" "http://127.0.0.1:1234/v1" "-openai-key" "ollama" "-openai-model" "mistralai/devstral-small-2-2512"];
        #   };
        # };

        # language = [
        #   {
        #     name = "python";
        #     # language-servers = ["${lib.getExe pkgs.basedpyright}"];
        #     # language-servers = ["${lib.getExe pkgs.ty}"];
        #     language-servers = ["ty" "helix-assist"];
        #   }
        # ];
      };
    };
  };
}

{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.svenihoney.devel.helix {
    home.sessionVariables.COLORTERM = "truecolor";
    programs.helix = {
      enable = true;
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
      # languages = {
      #   # # the language-server option currently requires helix from the master branch at https://github.com/helix-editor/helix/
      #   # language-server.typescript-language-server = with pkgs.nodePackages; {
      #   #   command = "${typescript-language-server}/bin/typescript-language-server";
      #   #   args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
      #   # };

      #   language = [{
      #     name = "python";
      #     language-server = {
      #       command = "ruff-lsp";
      #     };
      #   }];
      # };
    };
  };
}

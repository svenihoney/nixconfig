{ config, ... }:
{
  home.sessionVariables.COLORTERM = "truecolor";
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        color-modes = true;
        line-number = "relative";
        bufferline = "multiple";
        lsp.display-messages = true;
      };
      keys = {
        normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
        };
      };
    };
  };
}

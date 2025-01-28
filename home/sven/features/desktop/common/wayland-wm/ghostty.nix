{
  config,
  pkgs,
  ...
}: let
in {
  home = {
    packages = [pkgs.ghostty];
    sessionVariables = {
      TERMINAL = "ghostty";
    };
  };

  # home.file."${config.xdg.configHome}/ghostty/config" = {
  home.file.".config/ghostty/config" = {
    text = ''
      font-size = 10

      gtk-tabs-location = bottom
      gtk-titlebar = false
      theme = Dracula
    '';
  };
}

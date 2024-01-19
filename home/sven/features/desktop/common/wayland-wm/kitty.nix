{
  config,
  pkgs,
  ...
}: let
  kitty-xterm = pkgs.writeShellScriptBin "xterm" ''
    ${config.programs.kitty.package}/bin/kitty -1 "$@"
  '';
in {
  home = {
    packages = [kitty-xterm];
    sessionVariables = {
      TERMINAL = "kitty -1";
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      # shell_integration = "no-rc"; # I prefer to do it manually
      shell_integration = "no-cursor"; # I prefer to do it manually
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      window_padding_width = 5;
      cursor_shape = "block";
      cursor_stop_blinking_after = 3;

      tab_bar_style = "powerline";
      tab_separator = " ┇";
      tab_powerline_style = "slanted";

      # nnn
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      enabled_layouts = "splits";

      paste_actions = "quote-urls-at-prompt";
    };
    keybindings = {
      "shift+page_up" = "scroll_page_up";
      "shift+page_down" = "scroll_page_down";

      "alt+shift+right" = "next_tab";
      "alt+shift+left" = "previous_tab";

      "kitty_mod+n" = "new_os_window_with_cwd";
      "kitty_mod+t" = "launch --cwd=current --type=tab";
    };
  };

  # Enable ssh kitten in fish
  programs.fish.shellAbbrs = rec {
    s = "kitten ssh";
  };
}

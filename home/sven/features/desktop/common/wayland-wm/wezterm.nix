{ config, lib, pkgs, ... }: {
  home = {
    sessionVariables = {
      TERMINAL = "wezterm";
    };
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local act = wezterm.action
      local config = {}

      -- config.color_scheme = 'Batman'
      -- config.color_scheme = 'Hardcore'
      -- config.font = wezterm.font('JetBrains Mono')
      -- config.font_size = 10
      -- config.line_height = 1.1

      config.window_decorations = "RESIZE"
      config.scrollback_lines = 10000

      config.adjust_window_size_when_changing_font_size = false
      config.hide_tab_bar_if_only_one_tab = true
      config.tab_bar_at_bottom = true

      config.keys = {
        { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
        { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },
        -- for shell undo
        { key = '_', mods = 'SHIFT|CTRL', action = act.DisableDefaultAssignment },
        { key = ';', mods = 'CTRL', action = act.IncreaseFontSize },
      }

      config.quick_select_patterns = {
        -- match things that look like sha1 hashes
        -- (this is actually one of the default patterns)
        '[0-9a-zA-Z_./-]+',
      }

      return config
    '';
  };
}

# { config, pkgs, ... }:

# let
#   inherit (config) colorscheme;
#   inherit (colorscheme) colors;
# in
# {
#   programs.wezterm = {
#     enable = true;
#     colorSchemes = {
#       "${colorscheme.slug}" = {
#         foreground = "#${colors.base05}";
#         background = "#${colors.base00}";

#         ansi = [
#           "#${colors.base08}"
#           "#${colors.base09}"
#           "#${colors.base0A}"
#           "#${colors.base0B}"
#           "#${colors.base0C}"
#           "#${colors.base0D}"
#           "#${colors.base0E}"
#           "#${colors.base0F}"
#         ];
#         brights = [
#           "#${colors.base00}"
#           "#${colors.base01}"
#           "#${colors.base02}"
#           "#${colors.base03}"
#           "#${colors.base04}"
#           "#${colors.base05}"
#           "#${colors.base06}"
#           "#${colors.base07}"
#         ];
#         cursor_fg = "#${colors.base00}";
#         cursor_bg = "#${colors.base05}";
#         selection_fg = "#${colors.base00}";
#         selection_bg = "#${colors.base05}";
#       };
#     };
#     extraConfig = /* lua */ ''
#       return {
#         font = wezterm.font("${config.fontProfiles.monospace.family}"),
#         font_size = 12.0,
#         color_scheme = "${colorscheme.slug}",
#         hide_tab_bar_if_only_one_tab = true,
#         window_close_confirmation = "NeverPrompt",
#         set_environment_variables = {
#           TERM = 'wezterm',
#         },
#       }
#     '';
#   };
# }
{ config, lib, pkgs, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local act = wezterm.action
      local config = {}

      -- config.color_scheme = 'Batman'
      config.color_scheme = 'Hardcore'
      config.font = wezterm.font('JetBrains Mono')
      config.font_size = 10
      -- config.line_height = 1.1

      config.window_decorations = "RESIZE"
      config.scrollback_lines = 10000

      config.adjust_window_size_when_changing_font_size = false
      config.hide_tab_bar_if_only_one_tab = true
      config.tab_bar_at_bottom = true
      -- config.use_fancy_tab_bar = false

      -- config.window_frame = {
      --  font = wezterm.font { family = 'Noto Sans', weight = 'Bold' },
      -- }

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

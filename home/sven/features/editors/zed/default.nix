{
  config,
  lib,
  pkgs,
  ...
}: {
  # config = lib.mkIf config.svenihoney.devel.zed {
  #   home.packages = [pkgs.zed-editor];
  # };
  programs.zed-editor = {
    enable = config.svenihoney.devel.zed;
    extensions = [
      "nix"
      "elisp"
    ];
    userSettings = {
      git_panel = {
        dock = "right";
      };
      load_direnv = "shell_hook";
      # load_direnv = "direct";
      # icon_theme = "Catppuccin Mocha";
      edit_predictions = {
        provider = "zed";
      };
      base_keymap = "VSCode";
      # theme = "Dracula";
      # ui_font_size = 17;
      # buffer_font_size = 18;
      file_finder = {
        modal_width = "medium";
      };
      # buffer_font_family = "Maple Mono NF";
      vim_mode = true;
      vim = {
        enable_vim_sneak = true;
      };
      relative_line_numbers = "enabled";
      tab_bar = {
        show = true;
      };
      scrollbar = {
        show = "never";
      };
      tabs = {
        show_diagnostics = "errors";
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      centered_layout = {
        left_padding = 0.15;
        right_padding = 0.15;
      };
      # assistant = {
      #   default_model = {
      #     provider = "copilot_chat";
      #     model = "claude-3-7-sonnet";
      #   };
      #   version = "2";
      # };
      agent = {
        default_model = {
          provider = "ollama";
          model = "gemma:e4b";
        };
        provider = null;
      };
      language_models = {
        ollama = {
          api_url = "http://localhost:11434";
        };
      };
      inlay_hints = {
        enabled = true;
      };
      lsp = {
        rust-analyzer = {
          binary = {
            # path = lib.getExe pkgs.rust-analyzer;
            path_lookup = true;
          };
        };

        # nix = {
        #   binary = {
        #     path_lookup = true;
        #   };
        # };
        nil = {
          binary = {
            path = "${lib.getExe pkgs.nil}";
          };
          # settings = {
          #   formatting = {
          #     command = ["alejandra"];
          #   };
          #   diagnostics = {
          #     ignored = [
          #       "unused_binding"
          #     ];
          #   };
          # };
        };
      };

      #   tailwindcss-language-server = {
      #     settings = {
      #       classAttributes = [
      #         "class"
      #         "className"
      #         "ngClass"
      #         "styles"
      #       ];
      #     };
      #   };
      # };
      languages = {
        # TypeScript = {
        #   inlay_hints = {
        #     enabled = true;
        #     show_parameter_hints = false;
        #     show_other_hints = true;
        #     show_type_hints = true;
        #   };
        Nix = {
          formatter = {
            language_server = {
              name = "${lib.getExe pkgs.alejandra}";
            };
          };
        };
      };
      #   Python = {
      #     format_on_save = {
      #       language_server = {
      #         name = "ruff";
      #       };
      #     };
      #     formatter = {
      #       language_server = {
      #         name = "ruff";
      #       };
      #     };
      #     language_servers = [
      #       "basedpyright"
      #       "ruff"
      #     ];
      #   };
      # };
      terminal = {
        # font_family = "Maple Mono NF";
        env = {
          EDITOR = "zed --wait";
        };
      };
      file_types = {
        Dockerfile = [
          "Dockerfile"
          "Dockerfile.*"
        ];
        JSON = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];
      };
      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/.hg"
        "**/CVS"
        "**/.DS_Store"
        "**/Thumbs.db"
        "**/.classpath"
        "**/.settings"
        "**/out"
        "**/dist"
        "**/.husky"
        "**/.turbo"
        "**/.vscode-test"
        "**/.vscode"
        "**/.next"
        "**/.storybook"
        "**/.tap"
        "**/.nyc_output"
        "**/report"
        "**/node_modules"
      ];
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      project_panel = {
        button = true;
        dock = "right";
        git_status = true;
      };
      outline_panel = {
        dock = "right";
      };
      collaboration_panel = {
        dock = "left";
      };
      notification_panel = {
        dock = "left";
      };
      chat_panel = {
        dock = "left";
      };
    };
    userKeymaps = [
      {
        context = "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu";
        bindings = {
          "space g h d" = "editor::ToggleSelectedDiffHunks";
          "space g g" = "git_panel::ToggleFocus";
          "space t i" = "editor::ToggleInlayHints";
          "space u w" = "editor::ToggleSoftWrap";
          "space c z" = "workspace::ToggleCenteredLayout";
          "space m p" = "markdown::OpenPreview";
          "space m P" = "markdown::OpenPreviewToTheSide";
          "space p p" = "projects::OpenRecent";
          "space s w" = "pane::DeploySearch";
          "space a c" = "assistant::ToggleFocus";
          "g f" = "editor::OpenExcerpts";
        };
      }
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
        bindings = {
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-l = "workspace::ActivatePaneRight";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-j = "workspace::ActivatePaneDown";
          "space c a" = "editor::ToggleCodeActions";
          "space ." = "editor::ToggleCodeActions";
          "space c r" = "editor::Rename";
          "g d" = "editor::GoToDefinition";
          "g D" = "editor::GoToDefinitionSplit";
          "g i" = "editor::GoToImplementation";
          "g I" = "editor::GoToImplementationSplit";
          "g t" = "editor::GoToTypeDefinition";
          "g T" = "editor::GoToTypeDefinitionSplit";
          "g r" = "editor::FindAllReferences";
          "] d" = "editor::GoToDiagnostic";
          "[ d" = "editor::GoToPreviousDiagnostic";
          "] e" = "editor::GoToDiagnostic";
          "[ e" = "editor::GoToPreviousDiagnostic";
          "s s" = "outline::Toggle";
          "s S" = "project_symbols::Toggle";
          "space c x" = "diagnostics::Deploy";
          "] h" = "editor::GoToHunk";
          "[ h" = "editor::GoToPreviousHunk";
          shift-h = "pane::ActivatePreviousItem";
          shift-l = "pane::ActivateNextItem";
          shift-q = "pane::CloseActiveItem";
          ctrl-q = "pane::CloseActiveItem";
          "space b d" = "pane::CloseActiveItem";
          "space b o" = "pane::CloseInactiveItems";
          ctrl-s = "workspace::Save";
          "space space" = "file_finder::Toggle";
          "space /" = "pane::DeploySearch";
          "space e" = "pane::RevealInProjectPanel";
          "space s p" = "workspace::SaveAll";
          "F7"= "task::Rerun";
          "shift-F7" = "task::Spawn";
        };
      }
      {
        context = "EmptyPane || SharedScreen";
        bindings = {
          "space space" = "file_finder::Toggle";
          "space p p" = "projects::OpenRecent";
        };
      }
      {
        context = "Editor && vim_mode == visual && !VimWaiting && !menu";
        bindings = {
          "g c" = "editor::ToggleComments";
          "c f" = "editor::Format";
        };
      }
      {
        context = "Editor && vim_mode == insert && !menu";
        bindings = {
          "j j" = "vim::NormalBefore";
          "j k" = "vim::NormalBefore";
        };
      }
      {
        context = "Editor && vim_operator == c";
        bindings = {
          c = "vim::CurrentLine";
          r = "editor::Rename";
        };
      }
      {
        context = "Editor && vim_operator == c";
        bindings = {
          c = "vim::CurrentLine";
          a = "editor::ToggleCodeActions";
        };
      }
      {
        context = "Editor && vim_operator == c";
        bindings = {
          c = "vim::CurrentLine";
          f = "editor::Format";
        };
      }
      {
        context = "Workspace";
        bindings = {
          "ctrl-\\" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "Terminal";
        bindings = {
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-l = "workspace::ActivatePaneRight";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-j = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          a = "project_panel::NewFile";
          A = "project_panel::NewDirectory";
          r = "project_panel::Rename";
          d = "project_panel::Delete";
          x = "project_panel::Cut";
          c = "project_panel::Copy";
          p = "project_panel::Paste";
          q = "workspace::ToggleRightDock";
          "space e" = "workspace::ToggleRightDock";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-l = "workspace::ActivatePaneRight";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-j = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "Dock";
        bindings = {
          "ctrl-w h" = "workspace::ActivatePaneLeft";
          "ctrl-w l" = "workspace::ActivatePaneRight";
          "ctrl-w k" = "workspace::ActivatePaneUp";
          "ctrl-w j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "Workspace";
        bindings = {
          cmd-b = "workspace::ToggleRightDock";
        };
      }
      {
        context = "EmptyPane || SharedScreen || vim_mode == normal";
        bindings = {
          "space r t" = [
            "editor::SpawnNearestTask"
            {
              reveal = "no_focus";
            }
          ];
        };
      }
      {
        context = "vim_mode == normal || vim_mode == visual";
        bindings = {
          s = [
            "vim::PushSneak"
            {}
          ];
          S = [
            "vim::PushSneakBackward"
            {}
          ];
        };
      }
    ];
  };
}

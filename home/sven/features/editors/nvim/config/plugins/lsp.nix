{pkgs, ...}: {
  plugins = {
    lsp-format.enable = true;
    lsp = {
      enable = true;
      servers = {
        # Rust
        # rust-analyzer = {
        #   enable = true;
        #   installRustc = false;
        #   installCargo = false;
        # };
        # Markdown
        # marksman = {
        #   enable = true;
        # };
        # Nix
        nil-ls = {
          enable = true;
          settings.formatting.command = ["${pkgs.alejandra}/bin/alejandra"];
        };
        # lua-ls = {
        #   enable = true;
        #   # settings = {
        #   #     workspace.library = [
        #   #         (helpers.mkRaw "vim.api.nvim_get_runtime_file(\"\", true)")
        #   #             "${pkgs.awesome}/share/awesome/lib"
        #   #     ];
        #   # };
        # };
        # ruff-lsp.enable = true;
        # pyright.enable = true;
        # # CSS
        # cssls = {
        #     enable = true;
        # };
        # # HTML
        # html = {
        #     enable = true;
        # };
        # C / C++
        clangd = {
          enable = true;
        };
      };
      #  keymaps.lspBuf = {
      #   "gd" = "definition";
      #   "gD" = "references";
      #   "gt" = "type_definition";
      #   "gi" = "implementation";
      #   "K" = "hover";
      # };
    };
    # LSP experience enhancements
    lspsaga = {
      enable = true;
      # ui.title = false;
      # symbolInWinbar.enable = false;
    };
    #
    lsp-lines = {
      enable = true;
    };

    # none-ls = {
    #   enable = true;
    #   enableLspFormat = true;
    #   sources = {
    #     diagnostics = {
    #       statix.enable = true;
    #     };
    #     formatting = {
    #       alejandra.enable = true;
    #       markdownlint.enable = true;
    #       shellharden.enable = true;
    #       shfmt.enable = true;
    #     };
    #   };
    # };
  };
  # LSP Mappings
  keymaps = [
    # Async LSP Finder
    {
      key = "<leader>lf";
      mode = ["n"];
      action = ":Lspsaga finder def+ref<CR>";
      options = {
        silent = true;
        desc = "Lspsaga Finder";
      };
    }
    # Call hierarchy
    {
      key = "<leader>lci";
      mode = ["n"];
      action = ":Lspsaga incoming_calls<CR>";
      options = {
        silent = true;
        desc = "Lspsaga Incoming Calls";
      };
    }
    {
      key = "<leader>lco";
      mode = ["n"];
      action = ":Lspsaga outgoing_calls<CR>";
      options = {
        silent = true;
        desc = "Lspsaga Outgoing Calls";
      };
    }
    # Code Action
    {
      key = "<leader>ca";
      mode = ["n"];
      action = ":Lspsaga code_action<CR>";
      options = {
        silent = true;
        desc = "Code Action";
      };
    }
    {
      key = "<leader>ca";
      mode = ["v"];
      action = ":<C-U>Lspsaga range_code_action<CR>";
      options = {
        silent = true;
        desc = "Code Action";
      };
    }
    # Rename
    {
      key = "<leader>cr";
      mode = ["n"];
      action = ":Lspsaga rename<CR>";
      options = {
        silent = true;
        desc = "LSP Rename";
      };
    }
    # Peek Definitions
    {
      key = "<leader>lpd";
      mode = ["n"];
      action = ":Lspsaga peek_definition<CR>";
      options = {
        silent = true;
        desc = "Peek Definition";
      };
    }
    {
      key = "<leader>lpt";
      mode = ["n"];
      action = ":Lspsaga peek_type_definition<CR>";
      options = {
        silent = true;
        desc = "Peek Type Definition";
      };
    }
    # Goto
    {
      key = "gD";
      mode = ["n"];
      action = "<Cmd>lua vim.lsp.buf.declaration()<CR>";
      options = {
        silent = true;
        desc = "Goto Declaration";
      };
    }
    {
      key = "gd";
      mode = ["n"];
      action = "<Cmd>:Lspsaga goto_definition<CR>";
      options = {
        silent = true;
        desc = "Goto Definition";
      };
    }
    {
      key = "gi";
      mode = ["n"];
      action = "<Cmd>lua vim.lsp.buf.implementation()<CR>";
      options = {
        silent = true;
        desc = "Goto Implementation";
      };
    }
    # LSP Outline
    {
      key = "<leader>lo";
      mode = ["n"];
      action = "<Cmd>Lspsaga outline<CR>";
      options = {
        silent = true;
        desc = "LSP Outline";
      };
    }
    # Workspace
    {
      key = "<space>wa";
      mode = ["n"];
      action = "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>";
      options = {
        silent = true;
        desc = "Add folder to workspace";
      };
    }
    {
      key = "<space>wr";
      mode = ["n"];
      action = "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>";
      options = {
        silent = true;
        desc = "Remove folder from workspace";
      };
    }
    {
      key = "<space>wl";
      mode = ["n"];
      action.__raw = ''
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end
      '';
      options = {
        desc = "Show all workspace folders";
      };
    }
    # Hover
    {
      key = "<leader>lk";
      mode = ["n"];
      action = "<Cmd>Lspsaga hover_doc<CR>";
      options = {
        silent = true;
        desc = "Hover Info";
      };
    }
    {
      key = "K";
      mode = ["n"];
      action = "<Cmd>Lspsaga hover_doc<CR>";
      options = {
        silent = true;
        desc = "Hover Info";
      };
    }
    {
      key = "<leader>ll";
      mode = ["n"];
      action = "<Cmd>Lspsaga show_line_diagnostics<CR>";
      options = {
        silent = true;
        desc = "Show Line Diagnostics";
      };
    }
    # Move Between Diagnostics
    {
      key = "[d";
      mode = ["n"];
      action = "<Cmd>lua vim.diagnostic.goto_prev()<CR>";
      options = {
        silent = true;
        desc = "Previous Diagnostic";
      };
    }
    {
      key = "]d";
      mode = ["n"];
      action = "<Cmd>lua vim.diagnostic.goto_next()<CR>";
      options = {
        silent = true;
        desc = "Next Diagnostic";
      };
    }
    {
      key = "<leader>cf";
      mode = ["n" "v"];
      # action = "<Cmd>lua vim.lsp.buf.format({ async = true, range = { [\"start\"] = vim.api.nvim_buf_get_mark(0, \"<\"), [\"end\"] = vim.api.nvim_buf_get_mark(0, \">\"), } })<CR>";
      action = "<Cmd>lua vim.lsp.buf.format({ async = true})<CR>";
      options = {
        silent = true;
        desc = "Format with LSP";
      };
    }
  ];
}

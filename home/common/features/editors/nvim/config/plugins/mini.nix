{lib, ...}: {
  plugins = {
    mini = {
      enable = true;
      modules = {
        icons = {};
        align = {
          mappings = {
            start = "ga";
            start_with_preview = "gA";
          };
        };
        # Smart parens
        # pairs = {
        #   modes = {
        #     insert = true;
        #     command = true;
        #     terminal = false;
        #   };
        #   # -- skip autopair when next character is one of these
        #   skip_next = ''[=[[%w%%%'%[%"%.%`%$]]=]'';
        #   # -- skip autopair when the cursor is inside these treesitter nodes
        #   skip_ts = "string";
        #   # -- skip autopair when next character is closing pair
        #   # -- and there are more closing pairs than opening pairs
        #   skip_unbalanced = true;
        #   # -- better deal with markdown code blocks
        #   markdown = true;
        # };
        surround = {
          mappings = {
            add = "gsa"; # Add surrounding in Normal and Visual modes
            delete = "gsd"; # Delete surrounding
            find = "gsf"; # Find surrounding (to the right)
            find_left = "gsF"; # Find surrounding (to the left)
            highlight = "gsh"; # Highlight surroundng
            replace = "cs"; # Replace surroundng
            update_n_lines = "gsn"; # Update `n_lines`
          };
        };
        ai = {
          n_lines = 500;
          custom_textobjects = {
            o.__raw = ''
              require("mini.ai").gen_spec.treesitter({ -- code block
                          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                        })'';
            f.__raw = ''require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }) '';
            c.__raw = ''require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })'';
            t.__raw = ''"<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" '';
            d.__raw = ''"%f[%d]%d+" '';
            # e = {
            #   __raw = ''
            #                 { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            #                 "^().*()$",
            #               '';
            # };
            # g = LazyVim.mini.ai_buffer, -- buffer
            # u = ai.gen_spec.function_call(), -- u for "Usage"
            # U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
          };
        };
        bufremove = {};
        files = {
          mappings = {
            go_in = "<CR>";
            go_out = "-";
          };
        };
        # indentscope = {
        #   symbol = "|";
        # };
      };
      mockDevIcons = true;
    };
    mini-clue = {
      enable = false;
      settings = {
        window.delay = 200;
        clues = [
          {__raw = "require(\"mini.clue\").gen_clues.builtin_completion()";}
          {__raw = "require(\"mini.clue\").gen_clues.g()";}
          {__raw = "require(\"mini.clue\").gen_clues.marks()";}
          {__raw = "require(\"mini.clue\").gen_clues.registers()";}
          {__raw = "require(\"mini.clue\").gen_clues.windows()";}
          {__raw = "require(\"mini.clue\").gen_clues.z()";}
        ];
        triggers = [
          {
            mode = "n";
            keys = "<Leader>";
          } # Leader triggers
          {
            mode = "x";
            keys = "<Leader>";
          }
          {
            mode = "n";
            keys = "\\";
          } # mini.basics
          {
            mode = "n";
            keys = "[";
          } # mini.bracketed
          {
            mode = "n";
            keys = "]";
          }
          {
            mode = "x";
            keys = "[";
          }
          {
            mode = "x";
            keys = "]";
          }
          {
            mode = "i";
            keys = "<C-x>";
          } # Built-in completion
          {
            mode = "n";
            keys = "g";
          } # `g` key
          {
            mode = "x";
            keys = "g";
          }
          {
            mode = "n";
            keys = "\"";
          } # Marks
          {
            mode = "n";
            keys = "`";
          }
          {
            mode = "x";
            keys = "\"";
          }
          {
            mode = "x";
            keys = "`";
          }
          {
            mode = "n";
            keys = "\"";
          } # Registers
          {
            mode = "x";
            keys = "\"";
          }
          {
            mode = "i";
            keys = "<C-r>";
          }
          {
            mode = "c";
            keys = "<C-r>";
          }
          {
            mode = "n";
            keys = "<C-w>";
          } # Window commands
          {
            mode = "n";
            keys = "z";
          } # `z` key
          {
            mode = "x";
            keys = "z";
          }
        ];
      };
    };
  };
  keymaps = [
    # mini.bufremove
    {
      key = "<leader>bd";
      mode = ["n"];
      action = ":lua MiniBufremove.delete(0, false)<CR>";
      options = {
        silent = true;
        desc = "Delete buffer";
      };
    }
    {
      key = "<leader>bD";
      mode = ["n"];
      action = ":lua MiniBufremove.delete(0, true)<CR>";
      options = {
        silent = true;
        desc = "Delete buffer (force)";
      };
    }
    {
      mode = ["n"];
      key = "<leader>o-";
      # action = "<cmd>Oil<cr>";
      action = "<cmd>:lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>";
      options = {
        desc = "Open file manager";
      };
    }
  ];
}

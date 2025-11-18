{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        disabled_filetypes = {
          __unkeyed-1 = "startify";
          __unkeyed-2 = "neo-tree";
          __unkeyed-3 = "neo-tree";
          statusline = [
            "dap-repl"
            "dashboard"
            "alpha"
            "ministarter"
          ];
          # winbar = [
          #   "aerial"
          #     "dap-repl"
          #     "neotest-summary"
          # ];
        };
        globalstatus = true;
      };
      sections = {
        lualine_a = [
          "mode"
        ];
        lualine_b = [
          "branch"
        ];
        lualine_c = [
          "filename"
          "diff"
        ];
        lualine_x = [
          "lsp_status"
          "diagnostics"
          # -- stylua: ignore
          # {
          #   function() return require("noice").api.status.command.get() end,
          #   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          #   color = function() return { fg = Snacks.util.color("Statement") } end,
          # },
          # -- stylua: ignore
          # {
          #   function() return require("noice").api.status.mode.get() end,
          #   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          #   color = function() return { fg = Snacks.util.color("Constant") } end,
          # },
          # -- stylua: ignore
          # {
          #   function() return "  " .. require("dap").status() end,
          #   cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          #   color = function() return { fg = Snacks.util.color("Debug") } end,
          # },
          # -- stylua: ignore
          # {
          #   require("lazy.status").updates,
          #   cond = require("lazy.status").has_updates,
          #   color = function() return { fg = Snacks.util.color("Special") } end,
          # },
          # {
          #   "diff",
          #   symbols = {
          #     added = icons.git.added,
          #     modified = icons.git.modified,
          #     removed = icons.git.removed,
          #   },
          #   source = function()
          #     local gitsigns = vim.b.gitsigns_status_dict
          #     if gitsigns then
          #       return {
          #         added = gitsigns.added,
          #         modified = gitsigns.changed,
          #         removed = gitsigns.removed,
          #       }
          #     end
          #   end,
          # },
        ];
        # lualine_x = [
        #   "diagnostics"
        #   {
        #     __unkeyed-1 = {
        #       __raw = ''
        #         function()
        #           local msg = ""
        #           local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        #           local clients = vim.lsp.get_active_clients()
        #           if next(clients) == nil then
        #             return msg
        #           end
        #           for _, client in ipairs(clients) do
        #             local filetypes = client.config.filetypes
        #             if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        #               return client.name
        #             end
        #           end
        #           return msg
        #         end
        #       '';
        #     };
        #     color = {
        #       fg = "#ffffff";
        #     };
        #     icon = "";
        #   }
        #   "encoding"
        #   "fileformat"
        #   "filetype"
        # ];
        lualine_y = [
          {
            __unkeyed-1 = "aerial";
            colored = true;
            cond = {
              __raw = ''
                function()
                local buf_size_limit = 1024 * 1024
                if vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0)) > buf_size_limit then
                  return false
                    end

                    return true
                    end
              '';
            };
            dense = false;
            dense_sep = ".";
            depth = {
              __raw = "nil";
            };
            sep = " ) ";
          }
        ];
        lualine_z = [
          # __unkePreviousyed-1 = "location";
          {
            __unkeyed-1 = "progress";
            separator = " ";
            padding = {
              left = 1;
              right = 0;
            };
          }
          {
            __unkeyed-1 = "location";
            padding = {
              left = 0;
              right = 1;
            };
          }
        ];
      };
      # tabline = {
      #     lualine_a = [
      #         {
      #             __unkeyed-1 = "buffers";
      #             symbols = {
      #                 alternate_file = "";
      #             };
      #         }
      #     ];
      #     lualine_z = [
      #         "tabs"
      #     ];
      # };
      # winbar = {
      #     lualine_c = [
      #         {
      #             # __unkeyed-1 = "navic";
      #             __unkeyed-1 = "lspsaga";
      #         }
      #     ];
      #     lualine_x = [
      #         {
      #             __unkeyed-1 = "filename";
      #             newfile_status = true;
      #             path = 3;
      #             shorting_target = 150;
      #         }
      #     ];
      # };
    };
  };
}

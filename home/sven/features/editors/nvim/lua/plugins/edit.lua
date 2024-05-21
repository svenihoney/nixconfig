return {
  {
    "tpope/vim-sleuth",
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  -- {
  --   "stevearc/conform.nvim",
  --   opts = function()
  --     local plugin = require("lazy.core.config").plugins["conform.nvim"]
  --     if plugin.config ~= M.setup then
  --       LazyVim.error({
  --         "Don't set `plugin.config` for `conform.nvim`.\n",
  --         "This will break **LazyVim** formatting.\n",
  --         "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
  --       }, { title = "LazyVim" })
  --     end
  --     ---@class ConformOpts
  --     local opts = {
  --       format_on_save = false;
  --       -- LazyVim will use these options when formatting with the conform.nvim formatter
  --       format = {
  --         timeout_ms = 3000,
  --         async = false, -- not recommended to change
  --         quiet = false, -- not recommended to change
  --         lsp_fallback = true, -- not recommended to change
  --       },
  --       ---@type table<string, conform.FormatterUnit[]>
  --       formatters_by_ft = {
  --         lua = { "stylua" },
  --         fish = { "fish_indent" },
  --         sh = { "shfmt" },
  --         python = {"black"},
  --       },
  --     }
  --     return opts
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = { autoformat = false }
  },
}

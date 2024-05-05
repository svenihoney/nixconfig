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
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = false,
    }
  },
  {
    "neovim/nvim-lspconfig",
    opts = { autoformat = false }
  },
}

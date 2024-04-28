-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.completeopt = "menu,menuone,noselect,noinsert"
opt.conceallevel = 0 -- So that `` is visible in markdown
opt.wrap = true      -- Enable line wrap

--      vim.opt.number = true                                  -- show line numbers
--      vim.opt.ruler = true
opt.ttyfast = true                                 -- terminal acceleration

--
--      vim.opt.tabstop = 4                               -- 4 whitespaces for tabs visual presentation
--      vim.opt.shiftwidth = 4                            -- shift lines by 4 spaces
--      vim.opt.smarttab = true                                -- set tabs for a shifttabs logic
--      vim.opt.expandtab = true                               -- expand tabs into spaces
--      vim.opt.autoindent = true                              -- indent when moving to the next line while writing code
--
--      -- set cursorline                              -- shows line under the cursor's line
--      vim.opt.showmatch = true                               -- shows matching part of bracket pairs (), [], {}
--
--      -- vim.opt.enc = utf-8                              -- utf-8 by default
--
--      vim.opt.backup = false                              -- no backup files
--      vim.opt.writebackup = false                           -- only in case you don't want a backup file while editing
--      vim.opt.swapfile = false                                -- no swap files
--
--      vim.opt.backspace = indent,eol,start              -- backspace removes all (indents, EOLs, start) What is start?
--
opt.scrolloff = 10                            -- let 10 lines before/after cursor during scroll
--
--      vim.opt.clipboard = unnamed                       -- use system clipboard
--
--      vim.opt.exrc = true                                    -- enable usage of additional .vimrc files from working directory
--      vim.opt.secure = true                                  -- prohibit .vimrc files to execute shell, create files, etc...
--
--      vim.opt.clipboard = unnamedplus                   -- using system clipboard
--      vim.opt.wildmode = longest,list                   -- get bash-like tab completions
--
--      -- Search settings
--      vim.opt.incsearch = true                                -- incremental search
--      vim.opt.hlsearch = true                             -- highlight search results
--
--      if vim.g.neovide then
--         vim.o.guifont = "JetBrainsMono_Nerd_Font:h9"
--         vim.g.neovide_cursor_animation_length = 0.01
--         vim.g.neovide_cursor_trail_size = 0.4
--      end
--
--      vim.g.mapleader = " "
--
--      vim.keymap.set("n", "<leader>oe", vim.cmd.Ex)
--
--      -- This is going to get me cancelled
--      vim.keymap.set("i", "jk", "<Esc>")
--      vim.keymap.set("i", "pw", "<Esc>")


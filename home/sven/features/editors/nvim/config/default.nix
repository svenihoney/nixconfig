{pkgs, ...}: {
  globals = {
    mapleader = " ";
    maplocalleader = " ";

    have_nerd_font = true;
  };
  opts = {
    number = true;
    # You can also add relative line numbers, to help with jumping.
    # Experiment for yourself to see if you like it!
    relativenumber = true;

    # Enable mouse mode, can be useful for resizing splits for example!
    mouse = "a";

    # Don"t show the mode, since it"s already in the status line
    showmode = false;

    # Sync clipboard between OS and Neovim.
    # Remove this option if you want your OS clipboard to remain independent.
    # See `:help "clipboard"`
    clipboard = "unnamedplus";

    # Enable break indent
    breakindent = true;

    # Save undo history
    undofile = true;

    # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    ignorecase = true;
    smartcase = true;

    # Keep signcolumn on by default
    signcolumn = "yes";

    # Decrease update time
    updatetime = 250;

    # Decrease mapped sequence wait time
    # Displays which-key popup sooner
    timeoutlen = 300;

    # Configure how new splits should be opened
    splitright = true;
    splitbelow = true;

    # Sets how neovim will display certain whitespace characters in the editor.
    # See `:help "list"`
    # and `:help "listchars"`
    list = true;
    listchars = {
      tab = "» ";
      trail = "·";
      nbsp = "␣";
    };

    # Preview substitutions live, as you type!
    inccommand = "split";

    # Show which line your cursor is on
    cursorline = true;

    # Minimal number of screen lines to keep above and below the cursor.
    scrolloff = 10;

    # [[ Basic Keymaps ]]
    # See `:help vim.keymap.set()`

    # incremental search
    incsearch = true;
    # Set highlight on search, but clear on pressing <Esc> in normal mode
    hlsearch = true;

    ttyfast = true;

    # 4 whitespaces for tabs visual presentation
    tabstop = 4;
    # shift lines by 4 spaces
    shiftwidth = 4;
    # set tabs for a shifttabs logic
    smarttab = true;
    # expand tabs into spaces
    expandtab = true;
    # indent when moving to the next line while writing code
    autoindent = true;

    # shows matching part of bracket pairs (), [], {}
    showmatch = true;

    # no backup files
    backup = false;
    # only in case you don't want a backup file while editing
    writebackup = false;
    # no swap files
    swapfile = false;

    # backspace removes all (indents, EOLs, start) What is start?
    backspace = "indent,eol,start";

    # prohibit .vimrc files to execute shell, create files, etc...
    secure = true;

    # get bash-like tab completions
    wildmode = "longest,list";
  };
  # Import all your configuration modules here
  imports = [
    ./plugins
    ./neovide.nix
    ./keymaps.nix
    # ./bufferline.nix
  ];

  # colorschemes.dracula-nvim.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    # For these no nixvim plugin exisis
    vim-abolish
  ];
}

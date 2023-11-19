{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      ms-python.python
      rust-lang.rust-analyzer
      asvetliakov.vscode-neovim
      # vscodevim.vim
      yzhang.markdown-all-in-one
    ];
    userSettings = {
      #   "vim.handleKeys" = {
      #     "<C-p>" = false;
      #   };
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
      "keyboard.dispatch" = "keyCode";
    };
    # keybindings = [
    #   {
    #     command = "-vscode-neovim.send";
    #     key = "ctrl+p";
    #   }
    # ];
  };
}

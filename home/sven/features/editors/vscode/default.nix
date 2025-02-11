{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      rust-lang.rust-analyzer
      asvetliakov.vscode-neovim
      yzhang.markdown-all-in-one
      mkhl.direnv
      ms-python.python
      # vadimcn.vscode-lldb
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

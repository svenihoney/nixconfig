{
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      ms-python.python
      rust-lang.rust-analyzer
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };
  home.packages = with pkgs; [curl];
}

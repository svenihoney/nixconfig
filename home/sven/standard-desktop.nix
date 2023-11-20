{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [

    ./features/editors/emacs
    ./features/editors/nvim/lsp.nix
    ./features/editors/vscode
    # ./features/desktop/common/keepassxc.nix
    ./features/desktop/common/nixgl.nix
    ./features/desktop/common/calculator.nix

    ../../hosts/common/optional/stylix.nix
  ];

}

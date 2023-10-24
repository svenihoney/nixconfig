{ config, lib, pkgs, ... }:

{
  imports = [
    ./features/emacs
    ./features/nvim/lsp.nix
    # ./features/desktop/common/keepassxc.nix
    ./features/desktop/common/nixgl.nix
  ];

}

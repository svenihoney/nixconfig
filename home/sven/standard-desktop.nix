{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # ./features/desktop/common/keepassxc.nix
    # ./features/desktop/common/nixgl.nix
    ./features/desktop/common/calculator.nix

    ../../hosts/common/optional/stylix.nix
  ];

  svenihoney.desktop = {
    enable = true;
  };

  svenihoney.devel = {
    emacs = true;
    nvim = true;
    extended = true;
  };

  home.packages = with pkgs; [thunar udiskie neovide];
  xdg.mimeApps.defaultApplications = {
    "text/plain" = "neovide.desktop";
    "inode/directory" = "thunar.desktop";
  };
  # home.packages = with pkgs; [pcmanfm udiskie neovide];
  # xdg.mimeApps.defaultApplications = {
  #   "text/plain" = "neovide.desktop";
  #   "inode/directory" = "pcmanfm.desktop";
  # };
}

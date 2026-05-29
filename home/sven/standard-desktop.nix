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

  programs.neovide.enable = true;

  # home.packages = with pkgs; [kdePackages.dolphin];
  home.packages = with pkgs; [nautilus];
  xdg.mimeApps.defaultApplications = {
    "text/plain" = "neovide.desktop";
    # "inode/directory" = "dolphin.desktop";
    "inode/directory" = "nautilus.desktop";
  };
  # home.packages = with pkgs; [pcmanfm udiskie neovide];
  # xdg.mimeApps.defaultApplications = {
  #   "text/plain" = "neovide.desktop";
  #   "inode/directory" = "pcmanfm.desktop";
  # };
}

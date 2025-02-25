{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # ./features/desktop/common/keepassxc.nix
    ./features/desktop/common/nixgl.nix
    ./features/desktop/common/calculator.nix

    ../../hosts/common/optional/stylix.nix
  ];

  programs.git = {
    extraConfig = {
      diff.tool = "meld";
      difftool.meld.path = "${pkgs.meld}/bin/meld";
      merge.tool = "kdiff3";
      mergetool.kdiff3.path = "${pkgs.kdiff3}/bin/kdiff3";
      difftool.prompt = false;
    };
  };
  home.packages = with pkgs; [pcmanfm udiskie neovide];
  xdg.mimeApps.defaultApplications = {
    "text/plain" = "neovide.desktop";
    "inode/directory" = "pcmanfm.desktop";
  };
}

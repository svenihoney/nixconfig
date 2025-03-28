{
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [
    # inputs.stylix.homeManagerModules.stylix
    ./global
    ../../hosts/common/optional/stylix-cli.nix
    # ./standard-desktop.nix

    # ./features/desktop/hyprland
    # ./features/desktop/common/networkmanager.nix
    # ./features/desktop/common/wayland-wm/wofi.nix
    # # ./features/desktop/wireless
    # ./features/productivity
    # ./features/media
    # # ./features/pass
    # ./features/games
    # # TODO: For standard
    # ./features/desktop/common/keepassxc.nix
    # ./features/desktop/common/kubernetes.nix
    # # ./features/desktop/common/wayland-wm/qutebrowser.nix
    # ./features/desktop/common/browser.nix
    # ./features/desktop/common/virtualisation.nix
    # ./features/development
  ];

  # workaround for error in home manager module if used standalone
  stylix.targets.kde.enable = false;
  gtk.enable = lib.mkForce false;

  programs.nixvim = {
    dap.enable = false;
    lsp.enable = false;
  };
  #targets.genericLinux.enable = true;
  # colorscheme = inputs.nix-colors.colorschemes.tokyo-night-storm;
  # wallpaper = outputs.wallpapers.watercolor-beach;

  #  ------   -----   ------
  # | DP-3 | | DP-1| | DP-2 |
  #  ------   -----   ------
  # monitors = [
  #   {
  #     name = "desc:Lenovo Group Limited LEN T27p-10 0x4E395246";
  #     width = 3840;
  #     height = 2160;
  #     workspace = "1";
  #     primary = true;
  #   }
  #   {
  #     name =
  #       "desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564";
  #     width = 2560;
  #     height = 1440;
  #     x = 3840;
  #     workspace = "3";
  #     transform = "1";
  #   }
  # ];
}

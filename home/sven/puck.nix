{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./global
    ./standard-desktop.nix

    ./features/desktop/hyprland
    ./features/desktop/common/networkmanager.nix
    ./features/desktop/common/wayland-wm/wofi.nix
    # ./features/desktop/wireless
    ./features/productivity
    ./features/media
    # ./features/pass
    ./features/games
    # TODO: For standard
    ./features/desktop/common/keepassxc.nix
    ./features/desktop/common/nextcloud-client.nix
    ./features/desktop/common/kubernetes.nix
    # ./features/desktop/common/wayland-wm/qutebrowser.nix
    ./features/desktop/common/browser.nix
    ./features/desktop/common/virtualisation.nix
    ./features/desktop/common/linphone.nix
    ./features/development
    ./features/development/syncthing.nix

    ./ssh/ssh-config.nix
  ];

  # wallpaper = outputs.wallpapers.aenami-lunar;
  # colorscheme = inputs.nix-colors.colorSchemes.atelier-heath;
  programs.emacs.package = pkgs.emacs29-pgtk;
  services.emacs.package = pkgs.emacs29-pgtk;
  services.blueman-applet.enable = true;

  monitors = [
    {
      name = "desc:California Institute of Technology 0x1615";
      width = 2560;
      height = 1600;
      workspace = "1";
      primary = true;
      scale = "1.333333";
    }
    {
      name = "desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564";
      width = 2560;
      height = 1440;
      x = 1920;
      workspace = "3";
      transform = "1";
    }
  ];

  # home.packages = [pkgs.lenopow];
  # Qt does not read the fractional scalea correctly...
  home.sessionVariables = {
    QT_SCREEN_SCALE_FACTORS = "1.33;1";
  };
}

{pkgs, ...}: {
  imports = [
    ./global
    ./standard-desktop.nix

    ./features/desktop/hyprland
    ./features/desktop/common/networkmanager.nix
    # ./features/desktop/common/wayland-wm/wofi.nix
    # ./features/desktop/common/wayland-wm/fuzzel.nix
    # ./features/desktop/wireless
    ./features/productivity
    ./features/media
    # ./features/pass
    ./features/games
    # TODO: For standard
    ./features/desktop/extended.nix
    ./features/desktop/common/nextcloud-client.nix
    ./features/desktop/common/kubernetes.nix
    # ./features/desktop/common/wayland-wm/qutebrowser.nix
    ./features/desktop/common/browser.nix
    ./features/desktop/common/virtualisation.nix
    ./features/desktop/common/linphone.nix
    ./features/desktop/common/jameica.nix
    ./features/desktop/common/switchaudio.nix
    ./features/development
    ./features/development/syncthing.nix
    ./features/development/networking.nix
    ./features/media/creativity.nix

    ./ssh/ssh-config.nix

    ./features/work
  ];

  #targets.genericLinux.enable = true;
  # colorscheme = inputs.nix-colors.colorschemes.tokyo-night-storm;
  # wallpaper = outputs.wallpapers.watercolor-beach;
  # programs.emacs.package = pkgs.emacs30-pgtk;
  # services.emacs.package = pkgs.emacs30-pgtk;
  # stylix.targets.kde.enable = false;

  #  ------   -----   ------
  # | DP-3 | | DP-1| | DP-2 |
  #  ------   -----   ------
  monitors = [
    {
      name = "desc:Lenovo Group Limited LEN T27p-10 0x4E395246";
      width = 3840;
      height = 2160;
      workspace = "1";
      primary = true;
    }
    {
      name = "desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564";
      width = 2560;
      height = 1440;
      x = 3840;
      workspace = "3";
      transform = "1";
    }
  ];

  wayland.windowManager.hyprland.settings.workspace = [
    "1, defaultName:1, monitor:desc:Lenovo Group Limited LEN T27p-10 0x4E395246"
    "2, defaultName:2, monitor:desc:Lenovo Group Limited LEN T27p-10 0x4E395246"
    "3, defaultName:3, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
    "4, defaultName:4, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
    "5, defaultName:5"
    "6, defaultName:6"
    "7, defaultName:7, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
    "8, defaultName:8"
    "9, defaultName:9, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
    "0, defaultName:0, monitor:desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564"
  ];

  programs.waybar.settings.primary.output = ["DP-2"];
}

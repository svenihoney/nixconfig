{
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [
    ../../hosts/common/optional/stylix-cli.nix

    ../sven/global
    ./dodo-ssh-config.nix

    ../sven/standard-desktop.nix

    ../sven/features/desktop/hyprland
    # ../sven/features/desktop/common/networkmanager.nix
    ../sven/features/desktop/common/wayland-wm/wofi.nix

    ../sven/features/desktop/common/browser.nix
    ../sven/features/desktop/common/virtualisation.nix
    # ../sven/features/desktop/common/kubernetes.nix
    ../sven/features/desktop/common/keepassxc.nix
    # ../sven/features/desktop/common/wine.nix
    # ./keepassxc.nix
    ../sven/features/development
    ../sven/features/editors/emacs

    ./dodo-ssh-config.nix
    # ../sven/features/productivity/neomutt.nix
    # ../sven/features/productivity/office.nix
  ];

  # stylix.targets.kde.enable = false;
  # stylix.targets.gnome.enable = false;

  home = {
    username = "fischer";
  };
  programs = {
    git = {
      userEmail = "fischer@software.ads";
    };

    firefox = {
      profiles.sven = {
        search = {
          default = "StartPage";
          engines = {
            "StartPage" = {
              urls = [{template = "https://www.startpage.com/search?query={searchTerms}";}];
            };
          };
        };
      };
    };
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

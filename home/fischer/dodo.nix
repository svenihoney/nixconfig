{
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [
    ../../hosts/common/optional/stylix-cli.nix

    ../sven/global

    ../sven/standard-desktop.nix

    ../sven/features/desktop/common/nixgl.nix

    ../sven/features/desktop/hyprland

    ../sven/features/desktop/common/browser.nix
    ../sven/features/desktop/common/virtualisation.nix
    ../sven/features/desktop/common/keepassxc.nix

    ../sven/features/development
    #../sven/features/editors/emacs

    # ../sven/features/productivity/neomutt.nix
    # ../sven/features/productivity/office.nix
  ];

  svenihoney.devel.emacs = lib.mkForce false;
  # stylix.targets.kde.enable = false;
  # stylix.targets.gnome.enable = false;
  targets.genericLinux.enable = true;
  # Hyprland crashes from Nix and ubuntu is too old
  # stylix.targets.hyprland.enable = false;

  home = {
    username = "fischer";
  };
  programs = {
    git.settings = {
      user.email = "fischer@software.ads";
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
}

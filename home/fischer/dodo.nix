{
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [
    ../../hosts/common/optional/stylix-cli.nix

    ../common/global

    ../common/standard-desktop.nix

    ../common/features/desktop/common/nixgl.nix

    ../common/features/desktop/hyprland

    ../common/features/desktop/common/browser.nix
    ../common/features/desktop/common/virtualisation.nix
    ../common/features/desktop/common/keepassxc.nix

    ../common/features/development
    #../common/features/editors/emacs

    # ../common/features/productivity/neomutt.nix
    # ../common/features/productivity/office.nix
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

{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    #inputs.stylix.homeManagerModules.stylix
    #inputs.sops-nix.homeManagerModules.sops-nix
    # inputs.home-manager-stable.nixosModules.home-manager
    ../../hosts/common/optional/stylix-cli.nix

    ../sven/global
    ../sven/standard-desktop.nix

    ../sven/features/desktop/hyprland
    ../sven/features/desktop/common/networkmanager.nix
    ../sven/features/desktop/common/wayland-wm/wofi.nix

    ../sven/features/desktop/common/browser.nix
    ../sven/features/desktop/common/virtualisation.nix
    ../sven/features/development
    ../sven/features/editors/emacs

    ./bilbo-ssh-config.nix
  ];

  # workaround for error in home manager module if used standalone
  # stylix.targets.kde.enable = false;
  # stylix.targets.gnome.enable = false;

  home = {
    username = "fischer";
  };
  programs.git = {
    userEmail = "fischer@software.ads";
  };
  #targets.genericLinux.enable = true;
  # colorscheme = inputs.nix-colors.colorschemes.tokyo-night-storm;
  # wallpaper = outputs.wallpapers.watercolor-beach;

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

  home.packages = with pkgs; [
    boost
  ];
}

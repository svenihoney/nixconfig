{
  inputs,
  outputs,
  pkgs,
  config,
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

    ../sven/features/desktop/common/browser.nix
    ../sven/features/desktop/common/virtualisation.nix
    ../sven/features/desktop/common/kubernetes.nix
    ../sven/features/desktop/common/keepassxc.nix
    ../sven/features/desktop/common/wine.nix
    # ./keepassxc.nix

    ./bilbo-ssh-config.nix
    ./bilbo-mail.nix
    ../sven/features/productivity/neomutt.nix
    ../sven/features/productivity/office.nix
    ../sven/features/productivity/ollama.nix
  ];

  # config.keepassFile = "${config.home.homeDirectory}/Passwörter.kdbx";

  # workaround for error in home manager module if used standalone
  # stylix.targets.kde.enable = false;
  # stylix.targets.gnome.enable = false;
  svenihoney.devel = {
    all = true;
    emacs = true;
    # helix = true;
    # zed = true;
    # copilot = true;
    # vscode = true;
  };

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
      name = "desc:AU Optronics 0x42EB";
      width = 3840;
      height = 2160;
      x = 0;
      workspace = "1";
      primary = true;
      scale = "2";
    }
    {
      name = "desc:Lenovo Group Limited LEN LT2423wC VN-A015TT";
      width = 1920;
      height = 1080;
      x = 1920;
      workspace = "2";
    }
    {
      name = "desc:Lenovo Group Limited LEN T2454pA 0x01010101";
      width = 1920;
      height = 1080;
      x = 3840;
      workspace = "4";
      transform = "1";
    }
    # PH34
    {
      name = "desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564";
      width = 2560;
      height = 1440;
      x = 1920;
      workspace = "3";
      transform = "1";
    }
  ];

  ollama.tools.enable = true;
  ollama.service.enable = true;
  services.ollama.acceleration = "cuda";
}

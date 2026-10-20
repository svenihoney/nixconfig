{pkgs, ...}: let
  lenovo = "desc:Lenovo Group Limited LEN T27p-10 0x4E395246";
  philips = "desc:Philips Consumer Electronics Company PHL 258B6QU UHB1625057564";
in {
  imports = [
    ../common/global
    ../common/standard-desktop.nix

    ../common/features/desktop/hyprland
    # ./features/desktop/mangowc
    ../common/features/desktop/common/networkmanager.nix
    # ./features/desktop/common/wayland-wm/wofi.nix
    # ./features/desktop/common/wayland-wm/fuzzel.nix
    # ./features/desktop/wireless
    ../common/features/development
    ../common/features/productivity
    ../common/features/productivity/ai.nix
    ../common/features/productivity/mail.nix
    ../common/features/productivity/calendar.nix

    ../common/features/media
    # ./features/pass
    ../common/features/games
    # TODO: For standard
    ../common/features/desktop/extended.nix
    ../common/features/desktop/common/nextcloud-client.nix
    # ./features/desktop/common/kubernetes.nix
    # ./features/desktop/common/wayland-wm/qutebrowser.nix
    ../common/features/desktop/common/browser.nix
    ../common/features/desktop/common/virtualisation.nix
    # ./features/desktop/common/linphone.nix
    ../common/features/desktop/common/jameica.nix
    ../common/features/desktop/common/switchaudio.nix
    # ./features/development/syncthing.nix
    ../common/features/development/networking.nix
    # ./features/media/creativity.nix

    ../net-ph34

    ./ssh/ssh-config.nix

    ../common/features/work
  ];

  svenihoney.devel = {
    all = true;
    zed = true;
    # vscode = true;
    # helix = true;
    # nvf = true;
  };

  # ollama = {
  #   tools.enable = true;
  #   service.enable = true;
  # };
  services.ollama = {
    acceleration = "rocm";
    # acceleration = "vulkan";
    host = "[::]";
  };
  ai-client.enable = true;
  ai-server.enable = true;

  # services.unison = {
  #   enable = true;
  #   pairs = {
  #     projects = {
  #       roots = [
  #         "/home/sven/projects"
  #         "ssh://sven@puck//home/sven/projects"
  #       ];
  #       commandOptions = {
  #         ignore = "Regex (.devenv|.direnv)";
  #       };
  #     };
  #   };
  # };
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
      name = lenovo;
      width = 3840;
      height = 2160;
      workspace = "1";
      primary = true;
    }
    {
      name = philips;
      width = 2560;
      height = 1440;
      x = 3840;
      workspace = "3";
      transform = 1;
    }
  ];
  # programs.caelestia.enable = false;
  # programs.caelestia.settings = {
  #   bar.excludedScreens = [
  #     "HDMI-A-1"
  #   ];
  # };
  programs.noctalia.settings.bar.default.monitor = {
    HDMI-A-1 = {
      enabled = false;
    };
  };

  programs.waybar.settings.primary.output = ["DP-2"];
  wayland.windowManager.hyprland.settings.workspace_rule = [
    {
      workspace = "1";
      default_name = "1";
      monitor = lenovo;
    }
    {
      workspace = "2";
      default_name = "2";
      monitor = lenovo;
      # layout = "scrolling";
    }
    {
      workspace = "3";
      default_name = "3";
      monitor = philips;
    }
    {
      workspace = "4";
      default_name = "4";
      monitor = philips;
    }
    {
      workspace = "5";
      default_name = "5";
      monitor = lenovo;
    }
    {
      workspace = "6";
      default_name = "6";
    }
    {
      workspace = "7";
      default_name = "7";
      monitor = philips;
    }
    {
      workspace = "8";
      default_name = "8";
    }
    {
      workspace = "9";
      default_name = "9";
      monitor = philips;
    }
    {
      workspace = "10";
      default_name = "10";
      monitor = philips;
    }
  ];
  home.packages = with pkgs; [rclone unison];
}

{pkgs, lib, ...}: {
  imports = [
    ../sven/features/cli
    # ./standard-desktop.nix

    # ./features/desktop/hyprland
    # ./features/desktop/common/networkmanager.nix
    # # ./features/desktop/common/wayland-wm/wofi.nix
    # # ./features/desktop/common/wayland-wm/fuzzel.nix
    # # ./features/desktop/wireless
    # ./features/development
    # ./features/productivity
    # ./features/productivity/ai.nix
    # ./features/productivity/mail.nix
    # ./features/productivity/calendar.nix

    # ./features/media
    # # ./features/pass
    # ./features/games
    # # TODO: For standard
    # ./features/desktop/extended.nix
    # ./features/desktop/common/nextcloud-client.nix
    # # ./features/desktop/common/kubernetes.nix
    # # ./features/desktop/common/wayland-wm/qutebrowser.nix
    # ./features/desktop/common/browser.nix
    # ./features/desktop/common/virtualisation.nix
    # ./features/desktop/common/linphone.nix
    # ./features/desktop/common/jameica.nix
    # ./features/desktop/common/switchaudio.nix
    # # ./features/development/syncthing.nix
    # ./features/development/networking.nix
    # # ./features/media/creativity.nix

    # ./ssh/ssh-config.nix

    # ./features/work
  ];


  # home.packages = with pkgs; [rclone unison linphone];
  home.stateVersion = lib.mkDefault "23.11";
}

{pkgs, ...}: {
  imports = [
    # ./hyprland-vnc.nix
    # ./gammastep.nix
    ./udiskie.nix
    # ./mako.nix
    # ./qutebrowser.nix
    # ./swayidle.nix
    # ./swaylock.nix
    ./hyprlock.nix
    ./hypridle.nix
    # ./waybar.nix
    ./hyprpanel
    ./wlogout.nix
    # ./wofi.nix
    # ./fuzzel.nix
    ./anyrun
    # ./walker
    ./zathura.nix
    ./vimiv.nix
    # ./wezterm.nix
    ./kitty.nix
    ./ghostty.nix
    # ./copyq.nix
    # ./quickshell
    # ./flameshot.nix # TODO: Does not work with wayland currently
  ];

  home.packages = with pkgs; [
    grim
    gtk3 # For gtk-launch
    mimeo
    # primary-xwayland
    pulseaudio
    slurp
    waypipe
    # wf-recorder
    wl-clipboard
    # wl-mirror
    # wl-mirror-pick
    # xdg-utils-spawn-terminal # Patched to open terminal
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    LIBSEAT_BACKEND = "logind";

    SDL_VIDEODRIVER = "wayland";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    MOZ_DBUS_REMOTE = "1";
    MOZ_USE_XINPUT2 = "1";

    _JAVA_AWT_WM_NONREPARENTING = "1";
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.xrender,true";
  };
}

{ pkgs, ... }: {
  imports = [
    # ./hyprland-vnc.nix
    ./gammastep.nix
    # ./udiskie.nix
    # ./kitty.nix
    ./mako.nix
    # ./qutebrowser.nix
    ./swayidle.nix
    # ./swaylock.nix
    ./waybar.nix
    # ./wofi.nix
    # ./zathura.nix
    ./wezterm.nix
  ];

  home.packages = with pkgs; [
    grim
    gtk3 # For gtk-launch
    imv
    mimeo
    # primary-xwayland
    pulseaudio
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    wl-mirror
    # wl-mirror-pick
    # xdg-utils-spawn-terminal # Patched to open terminal
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";

    #   "ECORE_EVAS_ENGINE,wayland_egl"
    #   "ELM_ENGINE,wayland_egl"
    SDL_VIDEODRIVER = "wayland";
    NIXOS_OZONE_WL = "1";

    MOZ_DBUS_REMOTE = "1";
    MOZ_USE_XINPUT2 = "1";

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_WAYLAND_FORCE_DPI = "physical";

    _JAVA_AWT_WM_NONREPARENTING = "1";
    _JAVA_OPTIONS =
      "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.xrender,true";

  };

}

{
  config,
  lib,
  pkgs,
  ...
}: {
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "svenihoney";
        password_cmd = "secret-tool lookup application rust-keyring service spotifyd username svenihoney";
        # use_keyring = true;
        backend = "pulseaudio";
        device_type = "computer";
      };
    };
  };

  home.packages = [
    pkgs.spotify
    pkgs.spotify-tui
  ];
}

{
  pkgs,
  config,
  lib,
  services,
  ...
}: let
  pinentryPkg =
    if config.gtk.enable && builtins.hasAttr "pinentry-gnome3" pkgs
    then pkgs.pinentry-gnome3
    else pkgs.pinentry-curses;
  pinentryConfig =
    if builtins.compareVersions lib.version "24.05" < 0
    then {
      pinentryFlavor = "qt";
    }
    else {
      pinentryPackage = pinentryPkg;
    };
in {
  # home.packages = pinentry.packages;

  services.gpg-agent =
    {
      enable = true;
      enableExtraSocket = true;
      # enableScDaemon = true;
      enableSshSupport = true;
      defaultCacheTtl = 34560000;
      maxCacheTtl = 34560000;
      #extraConfig = ''
      #  extra-socket /run/user/${toString config.home.uid}/gnupg/S.gpg-agent.extra
      #'';
      # if builtins.hasAttr "pinentryPackage" self then
      # pinentryPackage = pinentryPkg;
      # sshKeys = [ "149F16412997785363112F3DBD713BC91D51B831" ];
    }
    // pinentryConfig;

  programs = let
    fixGpg = ''
      gpgconf --launch gpg-agent
    '';
  in {
    # Start gpg-agent if it's not running or tunneled in
    # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
    # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
    bash.profileExtra = fixGpg;
    fish.loginShellInit = fixGpg;
    zsh.loginExtra = fixGpg;

    gpg = {
      enable = true;
      settings = {
        trust-model = "tofu+pgp";
      };
      # publicKeys = [{
      #   source = ../../pgp.asc;
      #   trust = 5;
      # }];
    };
  };

  # systemd.user.services = {
  #   # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
  #   # So that SSH config does not have to know the UID
  #   link-gnupg-sockets = {
  #     Unit = {
  #       Description = "link gnupg sockets from /run to /home";
  #     };
  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
  #       ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
  #       RemainAfterExit = true;
  #     };
  #     Install.WantedBy = [ "default.target" ];
  #   };
  # };
}
# vim: filetype=nix


{
  pkgs,
  lib,
  config,
  ...
}: let
  mbsync = "${config.programs.mbsync.package}/bin/mbsync";
  secret-tool = "${pkgs.libsecret}/bin/secret-tool";

  mailhost-chuck = "chuck.software.ads";

  common = rec {
    realName = "Sven Fischer";
    imap.host = "${mailhost-chuck}";
    imap.tls.enable = true;
    imap.port = 993;
    smtp.host = "${mailhost-chuck}";
    # gpg = {
    #   key = "58D4 8D66 4468 351D 3FDD  46B4 DDBD 617F 81BF 84F4";
    #   signByDefault = true;
    # };
    signature = {
      showSignature = "append";
    };
    # thunderbird.enable = true;
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };
    # folders = {
    #   inbox = "Inbox";
    #   drafts = "Drafts";
    #   sent = "Sent";
    #   trash = "Trash";
    # };
    neomutt = {
      enable = true;
      extraMailboxes = ["Archive" "Drafts" "Junk" "Sent" "Trash"];
    };
    # msmtp.enable = true;
  };
in {
  # home.persistence = {
  #   "/persist/home/${user}".directories = [ "Mail" ];
  # };

  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      rheinmetall = lib.mkMerge [
        rec {
          primary = true;
          address = "fischer@software.ads";
          passwordCommand = "${secret-tool} lookup ${mailhost-chuck} ${address}";
          signature.text = ''
            Sven Fischer (Dipl.-Phys.) - EDV- und SAP-Beratung
                            Platzer Höhenweg 34, 51429 Bergisch Gladbach, Germany
                            Tel.: +49-(0)2204-9670010, Fax: +49-(0)2204-9670019
                            Mobil: +49-(0)172-2012493, Web: http://www.effeffcee.de
          '';

          # msmtp.enable = true;
          userName = address;
          # neomutt.extraMailboxes = ["Rheinmetall" "Taxdigits" "Taxdigits/YouTrack"];
        }
        common
      ];
    };
  };

  # home.packages = [
  #   pkgs.thunderbird
  # ];
  # xdg.mimeApps.defaultApplications = {
  #   "x-scheme-handler/mailto" = ["thunderbird.desktop"];
  # };
  # programs.thunderbird = {
  #   enable = true;
  #   # profiles."2ec6vn7f.default" = {
  #   #   isDefault = true;
  #   #   name = "default";
  #   # };
  # };
  programs.mbsync.enable = true;
  # programs.msmtp.enable = true;

  # systemd.user.services.mbsync = {
  #   Unit = { Description = "mbsync synchronization"; };
  #   Service =
  #     let gpgCmds = import ../cli/gpg-commands.nix { inherit pkgs; };
  #     in
  #     {
  #       Type = "oneshot";
  #       ExecCondition = ''
  #         /bin/sh -c "${gpgCmds.isUnlocked}"
  #       '';
  #       ExecStart = "${mbsync} -a";
  #     };
  # };
  # systemd.user.timers.mbsync = {
  #   Unit = { Description = "Automatic mbsync synchronization"; };
  #   Timer = {
  #     OnBootSec = "30";
  #     OnUnitActiveSec = "5m";
  #   };
  #   Install = { WantedBy = [ "timers.target" ]; };
  # };
}

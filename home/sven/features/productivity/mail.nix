{
  pkgs,
  lib,
  config,
  ...
}: let
  mbsync = "${config.programs.mbsync.package}/bin/mbsync";
  secret-tool = "${pkgs.libsecret}/bin/secret-tool";

  mailhost-effeffcee = "mx1.effeffcee.de";

  common = rec {
    realName = "Sven Fischer";
    imap.host = "mx1.effeffcee.de";
    imap.tls.enable = true;
    imap.port = 993;
    smtp.host = "${mailhost-effeffcee}";
    gpg = {
      key = "58D4 8D66 4468 351D 3FDD  46B4 DDBD 617F 81BF 84F4";
      signByDefault = true;
    };
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
    msmtp.enable = true;
  };
in {
  # home.persistence = {
  #   "/persist/home/sven".directories = [ "Mail" ];
  # };

  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      leiderfischer =
        rec {
          primary = true;
          address = "sven@leiderfischer.de";
          # aliases = ["gabriel@gsfontes.com" "eu@sven.me"];
          passwordCommand = "${secret-tool} lookup ${mailhost-effeffcee} ${address}";
          signature.text = ''
            Sven Fischer -- Platzer Höhenweg 34, 51429 Bergisch Gladbach, Germany
                            Tel: +49-(0)2204-480985, Fax: +49-(0)2204-9670019
                            sven@leiderfischer.de
          '';

          userName = address;

          neomutt.extraMailboxes = ["Ablage"];
        }
        // common;

      effeffcee =
        rec {
          address = "sven.fischer@effeffcee.de";
          passwordCommand = "${secret-tool} lookup ${mailhost-effeffcee} ${address}";
          signature.text = ''
            Sven Fischer (Dipl.-Phys.) - EDV- und SAP-Beratung
                            Platzer Höhenweg 34, 51429 Bergisch Gladbach, Germany
                            Tel.: +49-(0)2204-9670010, Fax: +49-(0)2204-9670019
                            Mobil: +49-(0)172-2012493, Web: http://www.effeffcee.de
          '';

          # msmtp.enable = true;
          userName = address;
        }
        // common;
    };
  };

  home.packages = [
    pkgs.thunderbird
  ];
  # programs.thunderbird = {
  #   enable = true;
  #   # profiles."2ec6vn7f.default" = {
  #   #   isDefault = true;
  #   #   name = "default";
  #   # };
  # };
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;

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

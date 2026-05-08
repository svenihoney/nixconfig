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

    signature = {
      showSignature = "append";
    };

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };

    thunderbird = {
      enable = true;
      profiles = ["sven"];
    };

    neomutt = {
      enable = true;
      extraMailboxes = ["Drafts" "Sent" "Trash"];
    };
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

          userName = address;
          # neomutt.extraMailboxes = ["Rheinmetall" "Taxdigits" "Taxdigits/YouTrack"];
        }
        common
      ];
    };
  };

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

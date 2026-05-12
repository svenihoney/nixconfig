{
  pkgs,
  lib,
  config,
  inputs,
  # self,
  ...
}: let
  inherit (inputs) self;
  # mbsync = "${config.programs.mbsync.package}/bin/mbsync";
  secret-tool = "${pkgs.libsecret}/bin/secret-tool";

  mailhost-effeffcee = "mx1.effeffcee.de";

  common = {
    realName = "Sven Fischer";
    imap.host = lib.mkDefault "${mailhost-effeffcee}";
    imap.tls.enable = true;
    imap.port = 993;
    smtp.host = lib.mkDefault "${mailhost-effeffcee}";
    signature = {
      showSignature = "append";
    };
    smtp = {
      port = 465;
      tls = {
        enable = true;
        useStartTls = false;
      };
    };

    thunderbird = {
      enable = true;
      profiles = ["sven"];
    };

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
  #   "/persist/home/${user}".directories = [ "Mail" ];
  # };
  age.secrets = {
    "leiderfischer.de" = {
      file = self + /secrets/signatures/leiderfischer.de.age;
      path = "${config.home.homeDirectory}/.local/share/signatures/leiderfischer.txt";
    };
    "effeffcee.de" = {
      file = self + /secrets/signatures/effeffcee.de.age;
      path = "${config.home.homeDirectory}/.local/share/signatures/effeffcee.txt";
    };
    "taxdigits.de" = {
      file = self + /secrets/signatures/taxdigits.de.age;
      path = "${config.home.homeDirectory}/.local/share/signatures/taxdigits.txt";
    };
    "moitzfeld-ev.de" = {
      file = self + /secrets/signatures/moitzfeld-ev.de.age;
      path = "${config.home.homeDirectory}/.local/share/signatures/moitzfeld-ev.txt";
    };
  };

  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      leiderfischer = lib.mkMerge [
        rec {
          primary = true;
          address = "sven@leiderfischer.de";
          # aliases = ["gabriel@gsfontes.com" "eu@sven.me"];
          passwordCommand = "${secret-tool} lookup ${mailhost-effeffcee} ${address}";
          # signature.file = config.age.secrets."leiderfischer.de".path;
          signature.command = "cat ${config.age.secrets."leiderfischer.de".path}";
          # signature.text = ''
          #   Sven Fischer -- Platzer Höhenweg 34, 51429 Bergisch Gladbach, Germany
          #                   Tel: +49-(0)2204-480985, Fax: +49-(0)2204-9670019
          #                   sven@leiderfischer.de
          # '';
          thunderbird = {
            enable = true;
            perIdentitySettings = id: {
              "mail.identity.id_${id}.attach_signature" = true;
              "mail.identity.id_${id}.sig_file" =
                config.age.secrets."leiderfischer.de".path;
            };
          };

          userName = address;

          gpg = {
            key = "DDBD617F81BF84F4";
            signByDefault = true;
          };

          neomutt.extraMailboxes = [
            "Ablage/DMS"
            "Ablage/EBay"
            "Ablage/nebenan.de"
            # "Ablage/Geschäftliches"
            "Ablage/OSS"
            "Ablage/Registrierungen"
            "Ablage/Schule"
          ];
        }
        common
      ];

      effeffcee = lib.mkMerge [
        rec {
          address = "sven.fischer@effeffcee.de";
          passwordCommand = "${secret-tool} lookup ${mailhost-effeffcee} ${address}";
          signature.command = "cat ${config.age.secrets."effeffcee.de".path}";
          thunderbird = {
            enable = true;
            perIdentitySettings = id: {
              "mail.identity.id_${id}.attach_signature" = true;
              "mail.identity.id_${id}.sig_file" = config.age.secrets."effeffcee.de".path;
            };
          };

          gpg = {
            key = "DDBD617F81BF84F4";
            signByDefault = true;
          };

          # msmtp.enable = true;
          userName = address;
          neomutt.extraMailboxes = ["Rheinmetall" "Taxdigits" "Taxdigits/YouTrack"];
        }
        common
      ];

      dgm = lib.mkMerge [
        rec {
          imap.host = "imap.strato.de";
          smtp.host = "smtp.strato.de";
          address = "sven.fischer@moitzfeld-ev.de";
          passwordCommand = "${secret-tool} lookup ${imap.host} ${address}";
          signature.command = "cat ${config.age.secrets."moitzfeld-ev.de".path}";
          thunderbird = {
            enable = true;
            perIdentitySettings = id: {
              "mail.identity.id_${id}.attach_signature" = true;
              "mail.identity.id_${id}.sig_file" = config.age.secrets."moitzfeld-ev.de".path;
            };
          };

          # msmtp.enable = true;
          userName = address;
        }
        common
      ];

      taxdigits = lib.mkMerge [
        rec {
          imap.host = "kunden.aditsystems.de";
          smtp.host = "${imap.host}";
          address = "s.fischer@taxdigits.de";
          passwordCommand = "${secret-tool} lookup ${imap.host} ${address}";
          signature.command = "cat ${config.age.secrets."taxdigits.de".path}";
          thunderbird = {
            enable = true;
            perIdentitySettings = id: {
              "mail.identity.id_${id}.attach_signature" = true;
              "mail.identity.id_${id}.sig_file" = config.age.secrets."taxdigits.de".path;
            };
          };

          # msmtp.enable = true;
          userName = address;
        }
        common
      ];
    };
  };

  programs.thunderbird.profiles."sven" = {
    feedAccounts."feeds" = {};

    accountsOrder = [
      "leiderfischer"
      "effeffcee"
      "dgm"
      "taxdigits"
    ];
  };

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
}

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

  leiderfischerSig = "${config.home.homeDirectory}/.local/share/signatures/leiderfischer.txt";
  effeffceeSig = "${config.home.homeDirectory}/.local/share/signatures/effeffcee.txt";
  taxdigitsSig = "${config.home.homeDirectory}/.local/share/signatures/taxdigits.txt";
  dgmSig = "${config.home.homeDirectory}/.local/share/signatures/moitzfeld-ev.txt";
in {
  # home.persistence = {
  #   "/persist/home/${user}".directories = [ "Mail" ];
  # };
  age.secrets = {
    leiderfischer = {
      file = self + /secrets/signatures/leiderfischer.de.age;
      # path = "${config.home.homeDirectory}/.local/share/signatures/leiderfischer.txt";
    };
    effeffcee = {
      file = self + /secrets/signatures/effeffcee.de.age;
      # path = "${config.home.homeDirectory}/.local/share/signatures/effeffcee.txt";
    };
    taxdigits = {
      file = self + /secrets/signatures/taxdigits.de.age;
      # path = "${config.home.homeDirectory}/.local/share/signatures/taxdigits.txt";
    };
    dgm = {
      file = self + /secrets/signatures/moitzfeld-ev.de.age;
      # path = "${config.home.homeDirectory}/.local/share/signatures/moitzfeld-ev.txt";
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
          # signature.file = config.age.secrets.leiderfischer.path;
          signature.command = "cat ${config.age.secrets.leiderfischer.path}";
          thunderbird = {
            enable = true;
            perIdentitySettings = id: {
              "mail.identity.id_${id}.attach_signature" = true;
              "mail.identity.id_${id}.sig_file" = leiderfischerSig;
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
          signature.command = "cat ${config.age.secrets.effeffcee.path}";
          thunderbird = {
            enable = true;
            perIdentitySettings = id: {
              "mail.identity.id_${id}.attach_signature" = true;
              "mail.identity.id_${id}.sig_file" = effeffceeSig;
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
          signature.command = "cat ${config.age.secrets.dgm.path}";
          thunderbird = {
            enable = true;
            perIdentitySettings = id: {
              "mail.identity.id_${id}.attach_signature" = true;
              "mail.identity.id_${id}.sig_file" = dgmSig;
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
          signature.command = "cat ${config.age.secrets.taxdigits.path}";
          thunderbird = {
            enable = true;
            perIdentitySettings = id: {
              "mail.identity.id_${id}.attach_signature" = true;
              "mail.identity.id_${id}.sig_file" = taxdigitsSig;
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

  # Copy for thunderbird. Otherwise it follows links and does lose the signature
  # if the agenix path changes.
  home.activation = {
    copySig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      cp ${config.age.secrets.leiderfischer.path} ${leiderfischerSig}
      cp ${config.age.secrets.effeffcee.path} ${effeffceeSig}
      cp ${config.age.secrets.dgm.path} ${dgmSig}
      cp ${config.age.secrets.taxdigits.path} ${taxdigitsSig}
    '';
  };
}

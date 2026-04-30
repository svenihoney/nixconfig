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
    imap.host = lib.mkDefault "${mailhost-effeffcee}";
    imap.tls.enable = true;
    imap.port = 993;
    smtp.host = lib.mkDefault "${mailhost-effeffcee}";
    gpg = {
      key = "58D4 8D66 4468 351D 3FDD  46B4 DDBD 617F 81BF 84F4";
      signByDefault = true;
    };
    signature = {
      showSignature = "append";
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
    # msmtp.enable = true;
  };
in {
  # home.persistence = {
  #   "/persist/home/${user}".directories = [ "Mail" ];
  # };
  imports = [./thunderbird.nix];

  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      leiderfischer = lib.mkMerge [
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
          signature.text = ''
            Sven Fischer (Dipl.-Phys.) - EDV- und SAP-Beratung
                            Platzer Höhenweg 34, 51429 Bergisch Gladbach, Germany
                            Tel.: +49-(0)2204-9670010, Fax: +49-(0)2204-9670019
                            Mobil: +49-(0)172-2012493, Web: http://www.effeffcee.de
          '';

          # msmtp.enable = true;
          userName = address;
          neomutt.extraMailboxes = ["Rheinmetall" "Taxdigits" "Taxdigits/YouTrack"];
        }
        common
      ];

      dgm = lib.mkMerge [
        rec {
          imap.host = "imap.strato.de";
          smtp.host = "${imap.host}";
          address = "sven.fischer@moitzfeld-ev.de";
          passwordCommand = "${secret-tool} lookup ${imap.host} ${address}";
          signature.text = ''
          '';

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
          signature.text = ''
          '';

          # msmtp.enable = true;
          userName = address;
        }
        common
      ];
    };
  };

  # home.packages = [
  #   pkgs.thunderbird
  # ];
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mailto" = ["thunderbird.desktop"];
  };
  programs.thunderbird = {
    enable = true;
    # policies = let
    #   # mkLockedAttrs = builtins.mapAttrs (_: value: {
    #   #   Value = value;
    #   #   Status = "locked";
    #   # });
    #   mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
    #     # install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
    #     install_url = "https://services.addons.thunderbird.net/thunderbird/downloads/latest/${pluginId}-latest.xpi";
    #     installation_mode = "force_installed";
    #   });
    # in {
    #   # Preferences = mkLockedAttrs {
    #   #   "extensions.autoDisableScopes" = 0;
    #   #   "extensions.pocket.enabled" = false;
    #   #   "browser.ctrlTab.sortByRecentlyUsed" = true;
    #   #   "browser.tabs.loadInBackground" = false;
    #   #   "browser.tabs.warnOnClose" = false;
    #   #   "browser.translations.neverTranslateLanguages" = "en";
    #   #   "browser.download.dir" = "/home/${config.home.username}/Downloads/zen";
    #   # };
    #   ExtensionSettings = mkExtensionSettings {
    #     # "keepassxc-mail@kkapsner.de" = "keepassxc-mail";
    #     "keepassxc-mail/addon-988289" = "keepassxc-mail";
    #   };
    # };
    profiles."sven" = {
      isDefault = true;
      withExternalGnupg = true;
      extensions = [pkgs.keepassxc-mail pkgs.thunderbird-de];
      accountsOrder = [
        "leiderfischer"
        "effeffcee"
        "dgm"
        "taxdigits"
        "Feeds"
      ];
      feedAccounts = {
        # Home-manager's thunderbird module currently only supports
        # creating feed account containers to prevent them from being
        # wiped on rebuild. Individual feed URLs must be added manually
        # via Thunderbird's UI (Subscribe to Feed...).
        Feeds = {};
      };
      settings = {
        "mail.show_headers" = 1;
        "mail.phishing.detection.enabled" = true;
        "mail.openMessageBehavior" = 0;
        "app.update.auto" = true;

        "browser.policies.applied" = true;
        "browser.search.region" = "DE";
        "browser.tabs.warnOnClose" = false;
        "calendar.timezone.useSystemTimezone" = true;
        "mail.chat.enabled" = false;
        "mail.close_delete_window.exit_if_last_window" = true;
        "mail.display_name_type" = 2;
        "mail.openpgp.allow_external_gnupg" = true;
        "mail.provider.mode" = 1;
        "mail.provider.suggestFromAddress" = true;
        "mail.rights.version" = 1;
        "mail.spam.manualMark" = true;
        "mail.spam.markAsReadOnSpam" = true;
        "mailnews.default_news_message_to_download" = 1000;
        "mailnews.default_num_headers" = 1000;
        "mailnews.headers.extraAddonHeaders" = "autocrypt openpgp";
        "mailnews.mark_as_read.auto" = true;
        "mailnews.mark_as_read.delay" = true;
        "mailnews.mark_as_read.delay.sec" = 1;
        "mailnews.start_page.enabled" = false;
        "mailnews.tags.version" = 2;
        "media.gmp.storage.version.observed" = 1;
        "network.cookie.CHIPS.lastMigrateDatabase" = 2;
        "pdfjs.enabledCache.state" = true;
        "pdfjs.migrationVersion" = 2;
      };
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

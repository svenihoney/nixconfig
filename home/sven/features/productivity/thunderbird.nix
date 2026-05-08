{
  pkgs,
  lib,
  config,
  ...
}: {
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
      extensions = [
        pkgs.keepassxc-mail
        pkgs.thunderbird-de
        pkgs.nur.repos.rycee.thunderbird-addons.cardbook
      ];

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
        "mail.openpgp.fetch_pubkeys_from_gnupg" = true;
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
}

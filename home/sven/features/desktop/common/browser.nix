{
  pkgs,
  inputs,
  lib,
  ...
}: let
  browser = ["vivaldi-stable.desktop"];
  # browser = ["firefox.desktop"];

  # XDG MIME types
  associations = {
    "application/json" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;
  };
in {
  # programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    languagePacks = ["de" "en-US"];
    profiles.sven = {
      bookmarks = {};
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        keepassxc-browser
        # ublock-origin
        # cookie-autodelete
        # istilldontcareaboutcookies
        # decentraleyes
        # sponsorblock
        gesturefy
        # vimium
        # wikiwand-wikipedia-modernized
        # user-agent-string-switcher
        deutsch-de-language-pack
        # dictionary-german
        # firenvim
      ];
      search = {
        default = lib.mkDefault "ddg";
        force = true;
      };
      settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.translations.neverTranslateLanguages" = "en";
        "dom.security.https_only_mode" = true;
        "dom.event.contextmenu.enabled" = true;
        "ui.context_menus.after_mouseup" = true;
        "identity.fxaccounts.enabled" = false;
        "intl.accept_languages" = "de, en-US, en";
        "intl.locale.requested" = "de,en-US";
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
  };
  stylix.targets.firefox.profileNames = ["sven"];

  programs.vivaldi = {
    enable = true;
    extensions = [
      {id = "oboonakemofpalcgghocfoadofidjkkk";} # KeepassXC}
      {id = "edibdbjcniadpccecjdfdjjppcpchdlm";} # I still don't care about cookies
      {id = "hfjbmagddngcpeloejdejnfgbamkjaeg";} # Vimium C
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      # {id = "emffkefkbkpkgpdeeooapgaicgmcbolj";} # Wikiwand
    ];
  };

  # home = {
  #   persistence = {
  #     # Not persisting is safer
  #     # "/persist/home/${user}".directories = [ ".mozilla/firefox" ];
  #   };
  # };

  xdg.mimeApps.defaultApplications = associations;
}

{
  pkgs,
  inputs,
  ...
}: let
  # browser = ["vivaldi-stable.desktop"];
  browser = ["firefox.desktop"];

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
    profiles.sven = {
      bookmarks = {};
      # languagePacks = [ "de" "en-US" ];
      # extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        keepassxc-browser
        ublock-origin
        cookie-autodelete
        istilldontcareaboutcookies
        decentraleyes
        sponsorblock
        gesturefy
        vimium
        wikiwand-wikipedia-modernized
        deutsch-de-language-pack
      ];
      search = {
        default = "DuckDuckGo";
        force = true;
      };
      settings = {
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.translations.neverTranslateLanguages" = "en";
        # "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        "dom.security.https_only_mode" = true;
        "dom.event.contextmenu.enabled" = true;
        "ui.context_menus.after_mouseup" = true;
        "identity.fxaccounts.enabled" = false;
        "intl.accept_languages" = "de, en-US, en";
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
  };

  programs.vivaldi = {
    enable = true;
    extensions = [
      {
        id = "oboonakemofpalcgghocfoadofidjkkk"; # KeepassXC
      }
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

{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  # browser = ["vivaldi-stable.desktop"];
  # browser = ["firefox.desktop"];
  browser = ["zen-beta.desktop"];

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
  imports = [
    inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight
    # or inputs.zen-browser.homeModules.twilight-official
  ];

  # programs.browserpass.enable = true;
  programs.firefox = {
    enable = false;
    languagePacks = ["de" "en-US"];
    profiles.sven = {
      bookmarks = {};
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        keepassxc-browser
        ublock-origin
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
      {id = "oboonakemofpalcgghocfoadofidjkkk";} # KeepassXC
      {id = "edibdbjcniadpccecjdfdjjppcpchdlm";} # I still don't care about cookies
      {id = "hfjbmagddngcpeloejdejnfgbamkjaeg";} # Vimium C
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      # {id = "emffkefkbkpkgpdeeooapgaicgmcbolj";} # Wikiwand
    ];
  };

  programs.zen-browser = {
    enable = true;

    policies = let
      mkLockedAttrs = builtins.mapAttrs (_: value: {
        Value = value;
        Status = "locked";
      });
      # mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
      #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
      #   installation_mode = "force_installed";
      # });
    in {
      Preferences = mkLockedAttrs {
        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.tabs.loadInBackground" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.translations.neverTranslateLanguages" = "en";
        "browser.download.dir" = "/home/${config.home.username}/Downloads/zen";
      };
      # ExtensionSettings = mkExtensionSettings {
      #   # "wappalyzer@crunchlabz.com" = "wappalyzer";
      #   # "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
      #   "uBlock0@raymondhill.net" = "ublock-origin";
      #   "keepassxc-browser@keepassxc.org" = "keepassxc-browser";
      #   "floccus@handmadeideas.org" = "floccus";
      #   "idcac-pub@guus.ninja" = "istilldontcareaboutcookies";
      #   "{506e023c-7f2b-40a3-8066-bc5deb40aebe}" = "gesturefy";
      #   "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = "vimium-ff";
      # };
    };
    profiles.sven = {
      bookmarks = {};
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        keepassxc-browser
        ublock-origin
        # cookie-autodelete
        istilldontcareaboutcookies
        # decentraleyes
        # sponsorblock
        floccus
        gesturefy
        vimium
        # wikiwand-wikipedia-modernized
        # user-agent-string-switcher
        dictionary-german
        # firenvim
      ];
      # search = {
      #   default = lib.mkDefault "ddg";
      #   force = true;
      # };
      settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "dom.security.https_only_mode" = true;
        "dom.event.contextmenu.enabled" = true;
        "ui.context_menus.after_mouseup" = true;
        "identity.fxaccounts.enabled" = false;
        "intl.accept_languages" = "de, en-US, en";
        "intl.locale.requested" = "de,en-US";
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;

        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.tabs.loadInBackground" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.translations.neverTranslateLanguages" = "en";
        "browser.download.dir" = "/home/${config.home.username}/Downloads/zen";
      };
    };
  };
  stylix.targets.zen-browser.profileNames = ["sven"];

  # home.packages =
  # let
  #   extension = shortId: guid: {
  #     name = guid;
  #     value = {
  #       install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
  #       installation_mode = "normal_installed";
  #     };
  #   };

  #   prefs = {
  #     # Check these out at about:config
  #     "extensions.autoDisableScopes" = 0;
  #     "extensions.pocket.enabled" = false;
  #     "browser.ctrlTab.sortByRecentlyUsed" = true;
  #     "browser.tabs.loadInBackground"	 = false;
  #     "browser.translations.neverTranslateLanguages" = "en";
  #     "browser.download.dir" = "/home/${config.home.username}/Downloads/zen";
  #     # ...
  #   };

  #   extensions = [
  #     # To add additional extensions, find it on addons.mozilla.org, find
  #     # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
  #     # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
  #     (extension "ublock-origin" "uBlock0@raymondhill.net")
  #     (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org")
  #     (extension "floccus" "floccus@handmadeideas.org")
  #     (extension "istilldontcareaboutcookies" "idcac-pub@guus.ninja")
  #     (extension "gesturefy" "{506e023c-7f2b-40a3-8066-bc5deb40aebe}")
  #     (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
  #     # ...
  #   ];

  # in
  # [
  #   # inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  #   (pkgs.wrapFirefox
  #         inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
  #         {
  #           extraPrefs = lib.concatLines (
  #             lib.mapAttrsToList (
  #               name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
  #             ) prefs
  #           );

  #           extraPolicies = {
  #             DisableTelemetry = true;
  #             ExtensionSettings = builtins.listToAttrs extensions;

  #             SearchEngines = {
  #               Default = "ddg";
  #               Add = [
  #                 {
  #                   Name = "nixpkgs packages";
  #                   URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
  #                   IconURL = "https://wiki.nixos.org/favicon.ico";
  #                   Alias = "@np";
  #                 }
  #                 {
  #                   Name = "NixOS options";
  #                   URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
  #                   IconURL = "https://wiki.nixos.org/favicon.ico";
  #                   Alias = "@no";
  #                 }
  #                 {
  #                   Name = "NixOS Wiki";
  #                   URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
  #                   IconURL = "https://wiki.nixos.org/favicon.ico";
  #                   Alias = "@nw";
  #                 }
  #                 {
  #                   Name = "noogle";
  #                   URLTemplate = "https://noogle.dev/q?term={searchTerms}";
  #                   IconURL = "https://noogle.dev/favicon.ico";
  #                   Alias = "@ng";
  #                 }
  #               ];
  #             };
  #           };
  #         }
  #       )
  # ];
  # home = {
  #   persistence = {
  #     # Not persisting is safer
  #     # "/persist/home/${user}".directories = [ ".mozilla/firefox" ];
  #   };
  # };

  xdg.mimeApps.defaultApplications = associations;

}

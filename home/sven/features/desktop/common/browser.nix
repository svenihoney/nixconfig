{ pkgs, ... }:

{
  # programs.browserpass.enable = true;
  # programs.firefox = {
  #   enable = true;
  #   profiles.sven = {
  #     bookmarks = { };
  #     # extensions = with pkgs.inputs.firefox-addons; [
  #     #   ublock-origin
  #     #   browserpass
  #     # ];
  #     bookmarks = { };
  #     settings = {
  #       "browser.disableResetPrompt" = true;
  #       "browser.download.panel.shown" = true;
  #       "browser.download.useDownloadDir" = false;
  #       "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  #       "browser.shell.checkDefaultBrowser" = false;
  #       "browser.shell.defaultBrowserCheckCount" = 1;
  #       "browser.startup.homepage" = "https://start.duckduckgo.com";
  #       "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
  #       "dom.security.https_only_mode" = true;
  #       "identity.fxaccounts.enabled" = false;
  #       "privacy.trackingprotection.enabled" = true;
  #       "signon.rememberSignons" = false;
  #     };
  #   };
  # };

  programs.vivaldi = {
    enable = true;
    extensions = [{
      id = "oboonakemofpalcgghocfoadofidjkkk";
    } # KeepassXC
      ];
  };

  programs.qutebrowser = {
    enable = true;
    keyBindings = {
      normal = {
        M = "hint links spawn mpv {hint-url}";
        pw = "spawn --userscript qute-keepassxc --key DDBD617F81BF84F4";

      };
      insert = {
        "<Alt-Shift-u>" = "spawn --userscript qute-keepassxc --key DDBD617F81BF84F4";
      };
    };
  };

  # home = {
  #   persistence = {
  #     # Not persisting is safer
  #     # "/persist/home/sven".directories = [ ".mozilla/firefox" ];
  #   };
  # };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "vivaldi.desktop" ];
    "text/xml" = [ "vivaldi.desktop" ];
    "x-scheme-handler/http" = [ "vivaldi.desktop" ];
    "x-scheme-handler/https" = [ "vivaldi.desktop" ];
  };
}

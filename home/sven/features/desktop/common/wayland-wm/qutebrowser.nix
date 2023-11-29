{
  config,
  pkgs,
  ...
}: {
  # home.persistence = {
  #   "/persist/home/${user}".directories = [
  #     ".config/qutebrowser/bookmarks"
  #     ".config/qutebrowser/greasemonkey"
  #     ".local/share/qutebrowser"
  #   ];
  # };

  # xdg.mimeApps.defaultApplications = {
  #   "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
  #   "text/xml" = ["org.qutebrowser.qutebrowser.desktop"];
  #   "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
  #   "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
  #   "x-scheme-handler/qute" = ["org.qutebrowser.qutebrowser.desktop"];
  # };

  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = false;
    package = pkgs.qutebrowser.override {
      enableWideVine = true;
      pipewireSupport = true;
    };
    settings = {
      auto_save.session = true;
      editor.command = ["xdg-open" "{file}"];
      tabs = {
        show = "multiple";
        # position = "left";
      };
      content.headers.accept_language = "de-DE;de;en-US,en;q=0.9";
    };
    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      w = "https://www.wikiwand.com/de/{}?fullSearch=false";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      no = "https://mipmip.github.io/home-manager-option-search/?query={}";
      g = "https://www.google.com/search?hl=en&q={}";
      am = "https://www.amazon.de/s?k={}";
      yt = "https://www.youtube.com/results?search_query={}";
      maps = "https://maps.google.com/?q={}";
    };

    keyBindings = {
      normal = {
        M = "hint links spawn mpv {hint-url}";
        pw = "spawn --userscript qute-keepassxc --key DDBD617F81BF84F4";
      };
      insert = {
        "<Alt-Shift-u>" = "spawn --userscript qute-keepassxc --key DDBD617F81BF84F4";
      };
    };
    extraConfig = ''
      config.set('content.notifications.enabled', True, 'https://www.youtube.com')
      config.set('content.notifications.enabled', True, 'https://web.whatsapp.com/')
      c.tabs.padding = {"bottom": 7, "left": 7, "right": 7, "top": 7}
    '';
  };

  # Workaround for the whatsapp desktop notification button
  home.file."${config.xdg.dataHome}/qutebrowser/greasemonkey/enable-notification-web-whatsapp.js" = {
    text = ''
      // ==UserScript==
      // @name        Fix web WhatsApp Notifications
      // @description Hits the notification button, once
      // @version     1.0
      // @namespace   https://web.whatsapp.com/
      // @run-at document-idle
      // @grant       none
      // ==/UserScript==
      (function() {
          'use strict';

          var waitForThatFrickingButton = setInterval(function() {
              let xpath = "//span[@class='i5tg98hk'][contains(.,'Desktop-Benachrichtigungen einschalten')]";
              let button = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
              if(button) {
                  button.click();
                  clearInterval(waitForThatFrickingButton);
              }
          }, 500)
      })();
    '';
  };
}

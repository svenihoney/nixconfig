{
  pkgs,
  lib,
  config,
  ...
}: let
  secret-tool = "${pkgs.libsecret}/bin/secret-tool";

  mailhost-effeffcee = "mx1.effeffcee.de";

  common = {
    local = {
      type = "filesystem";
      fileExt = ".ics";
    };

    vdirsyncer.enable = true;

    khal = {
      enable = true;
    };

    thunderbird = {
      enable = lib.mkDefault true;
      profiles = ["sven"];
    };
  };
in {
  accounts.calendar = {
    basePath = "${config.home.homeDirectory}/.local/share/calendars";
    accounts = {
      leiderfischer = lib.mkMerge [
        {
          primary = true;

          remote = {
            type = "caldav";
            # url = "https://mx1.effeffcee.de/SOGo/dav/sven@leiderfischer.de/Calendar/personal/";
            # url = "https://mx1.effeffcee.de/.well-known/caldav";
            url = "https://mx1.effeffcee.de/dav/cal/sven@leiderfischer.de";
            userName = "sven@leiderfischer.de";
            # passwordCommand = ["secret-tool" "lookup" "caldav" "work"];
            passwordCommand = ["${secret-tool}" "lookup" "${mailhost-effeffcee}" "sven@leiderfischer.de"];
          };
          vdirsyncer = {
            collections = ["from a"];
          };

          khal = {
            color = "light blue";
          };
        }
        common
      ];

      effeffcee = lib.mkMerge [
        {
          remote = {
            type = "caldav";
            # url = "https://mx1.effeffcee.de/SOGo/dav/sven.fischer@effeffcee.de/Calendar/personal/";
            url = "https://mx1.effeffcee.de/dav/cal/sven.fischer@effeffcee.de";
            userName = "sven.fischer@effeffcee.de";
            # passwordCommand = ["secret-tool" "lookup" "caldav" "work"];
            passwordCommand = ["${secret-tool}" "lookup" "${mailhost-effeffcee}" "sven.fischer@effeffcee.de"];
          };
          vdirsyncer = {
            collections = ["from a"];
          };

          khal = {
            color = "yellow";
          };
        }
        common
      ];
      familie = lib.mkMerge [
        {
          remote = {
            type = "google_calendar";
            # url = "https://apidata.googleusercontent.com/caldav/v2/fischereiadressen@gmail.com/events/"; # not actually used for google_calendar type
          };
          vdirsyncer = {
            enable = true;
            clientIdCommand = ["${secret-tool}" "lookup" "google_client_id" "fischereiadressen.gmail.com"];
            clientSecretCommand = ["${secret-tool}" "lookup" "google_client_secret" "fischereiadressen.gmail.com"];
            tokenFile = "${config.home.homeDirectory}/.local/share/vdirsyncer/google_token";
            collections = [
              "fischereiadressen@gmail.com"
              "885e30718c0e356c168a85bccc22ef934ab34e41752bdc2ee9d995c0a6eec16c@group.calendar.google.com" # Papa
              "e312ff163a7798cf0c35b8e08c2db48f2d5620b7ccd142b9d4dfa719fb1e915a@group.calendar.google.com" # Nina
              "fed875bdb2ad2e49c34abec4829f9bfdcb76ec5361085df0c2bd23eb483342ff@group.calendar.google.com" # Lutz
              "264c7c8d585c208cff0a2d459edbc1f5e3538056951e243992e99c1270512961@group.calendar.google.com" # Mama
            ];
          };

          khal = {
            color = "light green";
          };
          thunderbird.enable = false;
        }
        common
      ];
    };
  };
  accounts.contact = {
    basePath = "${config.home.homeDirectory}/.local/share/contacts";
    accounts = {
      leiderfischer = lib.mkMerge [
        {
          remote = {
            type = "carddav";
            # url = "https://mx1.effeffcee.de/SOGo/dav/sven@leiderfischer.de/Contacts/personal/";
            url = "https://mx1.effeffcee.de/.well-known/carddav";
            userName = "sven@leiderfischer.de";
            passwordCommand = ["${secret-tool}" "lookup" "${mailhost-effeffcee}" "sven@leiderfischer.de"];
          };
          vdirsyncer = {
            collections = ["from a"];
          };

          khal = {
            color = "light blue";
          };
          khard.enable = true;
        }
        common
      ];

      effeffcee = lib.mkMerge [
        {
          remote = {
            type = "carddav";
            # url = "https://mx1.effeffcee.de/SOGo/dav/sven.fischer@effeffcee.de/Contacts/personal/";
            url = "https://mx1.effeffcee.de/.well-known/carddav";
            userName = "sven.fischer@effeffcee.de";
            # passwordCommand = ["secret-tool" "lookup" "caldav" "work"];
            passwordCommand = ["${secret-tool}" "lookup" "${mailhost-effeffcee}" "sven.fischer@effeffcee.de"];
          };
          vdirsyncer = {
            collections = ["from a"];
          };

          khal = {
            color = "yellow";
          };
          khard.enable = true;
        }
        common
      ];
      familie = lib.mkMerge [
        {
          remote = {
            type = "google_contacts";
          };
          vdirsyncer = {
            enable = true;
            clientIdCommand = ["${secret-tool}" "lookup" "google_client_id" "fischereiadressen.gmail.com"];
            clientSecretCommand = ["${secret-tool}" "lookup" "google_client_secret" "fischereiadressen.gmail.com"];
            tokenFile = "${config.home.homeDirectory}/.local/share/vdirsyncer/google_token";
            collections = ["from b"];
          };

          khal = {
            color = "light green";
          };
          thunderbird.enable = false;
          khard.enable = true;
        }
        common
      ];
    };
  };

  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;

  programs.khal.enable = true;
  programs.khard.enable = true;
}

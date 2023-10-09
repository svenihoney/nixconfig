{ lib, ... }: {
  i18n = {
    defaultLocale = lib.mkDefault "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
    supportedLocales =
      lib.mkDefault [ "en_US.UTF-8/UTF-8" "de_DE.UTF-8/UTF-8" ];
  };
  time.timeZone = lib.mkDefault "Europe/Berlin";
}

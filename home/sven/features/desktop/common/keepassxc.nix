{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    keepassxc
    nextcloud-client
    libsecret
  ];

  systemd.user.services.keepassxc = {
    Unit = {
      Description = "keepassxc";
      Documentation = ["man:keepassxc(1)"];
      PartOf = ["hyprland-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.keepassxc}/bin/keepassxc -platform wayland /home/sven/cloud/sync/keepass.kdbx";
      RestartSec = 3;
      Restart = "always";
    };
    Install = {
      WantedBy = ["hyprland-session.target"];
    };
  };

  xdg.configFile."keepassxc/keepassxc.ini".text = ''
    [General]
    ConfigVersion=2
    MinimizeAfterUnlock=true

    [Browser]
    CustomProxyLocation=
    Enabled=true
    NoMigrationPrompt=true

    [FdoSecrets]
    ConfirmAccessItem=false
    Enabled=true

    [GUI]
    MinimizeOnClose=true
    MinimizeOnStartup=false
    MinimizeToTray=true
    ShowTrayIcon=true
    TrayIconAppearance=monochrome-light

    [KeeShare]
    Active="<?xml version=\"1.0\"?><KeeShare><Active/></KeeShare>\n"
    Foreign="<?xml version=\"1.0\"?>\n<KeeShare xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n  <Foreign/>\n</KeeShare>\n"
    Own="<?xml version=\"1.0\"?><KeeShare><PrivateKey>MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZG5mKmOpe5vTb80R8lsILaS0RFFflcjciexO9PdYcb7qfTT2l1fAT1MCFOQ3uoxfG555lejykbHlog1uJvfTsqZPrU2TPksA4jUbgGhl1vd8Z2kHQPgtiKfByxjbqQeedWKvwsed5z/mhzlqt83gjHHgNX7xLgyqVJz1RLe7XrJt+rFMwHKkWwTRt1zhwO5kzY14v795IDTFQ5KfFPmaikTKSF0+obY75QFGz1IhbuRx4K3IzdmspgVZ/rW9U+1uptB6Thokl3CgHAs0c1LU4z9vqlgM/SEosh0nRafqo2yfJCRDYnI6AiISKX37bkxly7RIiFADzRLDyNlCgqFiXAgMBAAECggEAHg03dhtPib5fU1i7eKFnj6vJzKzrs7tZDWFK7K10BzCh/O30pBFWb3BKC8bHempB3srtvm8qmLnZHlHcaFcOYXnhmzfKYv8Vs14+2sNSFd2n1YzEAl6sNbTHbyOns0pXFI0TE7iUaWST0cVeAOkMDpQgu/0t86fey5GIZ8W7Y0fkXyG+MkoQpw9duFCfRIHUAKiQl6RRoBG1moGaIKERh55WYc7d0Z8/Cc1yjrbifTQJVYWnVPbRQlGnRWSJS/igSVcLKlyFeXtH/I5dSh1Gfl523Aypq6Q2DjG7pfrSSjFw+T36N2nYxAW0fCAsdV1fby69NcIMrve1Mh2Wt6gP6QKBgQDxjKoT3tRD5qXnnSM6ifGkhFZAHO0d98IVHvxINDyj0K/ha8V0LcvNAoSjveI+S9985evk84r6DZlHAm+lhEE2Vmom/nQ1NbPBxBYXbej1RWEGuNImLZtX0jCIXKK40HLDgtI4enUT6hpG1yA5RfUe8uqDPiEcqbDWJ6endxJlfwKBgQDmGJxgiCZSKffclAUYLt5hQvc9XVwIVbr/oUXrbv72dSbzUDEMNznYn4+o7tYpfkZ0I3+LmHFBhpwWzAYMSbWjLKyf/UUEHfdW5mxBZv/wN7Lr+1sW9E030dfwNgurarknQcVbzoLoTCt8XjcOrkzr6Jp8I13R5sR1nM3g/UII6QKBgGKKcBgLH61TuvryMB0BiYMEOeuN4W4IVTUonuMV7GcoC5h6zuLGjA3mqRXjsRiY+2OIqOOON3QreAxwAfwUKEZymnut8tqCPgMea6TDQfZNh3emjpTkpir9pK78m6Wp5Ce+huRjkL+/EVk1CgBTedxWXTWNcxSuZWX4Z3z6JpchAoGBAKBqJAuAoAbET5MudubHNi5ku23Curjs2/QAAXkD5yj3v/H9xFQZ5HBLvaIu8Iv5BzFM1k0COGNQb13NW6IReVqLeMYJkqYuJhQljO+D2Yclrc2rbXPxWixCVeOYKkaVnwPpbKh2rvk4sVCBdqz7g5EslxdYqL3/vpOogDgNGI6RAoGAEItSnXjYosonrX4XX/yD1k35fTXEwKOg+sW2P8LEZSrenQpBok5AYso5GVwnE1Z72lH7T+f+cv6Le8UClcYNrRWO2ojQcsLQp6uGblZ4L4CYphYN6HAk2lh3al5PJkBFuM+ywunwn6fnyQrKetJZiErw3J4aD+tooXC8YZV+W2g=</PrivateKey><PublicKey><Signer>sven</Signer><Key>MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZG5mKmOpe5vTb80R8lsILaS0RFFflcjciexO9PdYcb7qfTT2l1fAT1MCFOQ3uoxfG555lejykbHlog1uJvfTsqZPrU2TPksA4jUbgGhl1vd8Z2kHQPgtiKfByxjbqQeedWKvwsed5z/mhzlqt83gjHHgNX7xLgyqVJz1RLe7XrJt+rFMwHKkWwTRt1zhwO5kzY14v795IDTFQ5KfFPmaikTKSF0+obY75QFGz1IhbuRx4K3IzdmspgVZ/rW9U+1uptB6Thokl3CgHAs0c1LU4z9vqlgM/SEosh0nRafqo2yfJCRDYnI6AiISKX37bkxly7RIiFADzRLDyNlCgqFiXAgMBAAECggEAHg03dhtPib5fU1i7eKFnj6vJzKzrs7tZDWFK7K10BzCh/O30pBFWb3BKC8bHempB3srtvm8qmLnZHlHcaFcOYXnhmzfKYv8Vs14+2sNSFd2n1YzEAl6sNbTHbyOns0pXFI0TE7iUaWST0cVeAOkMDpQgu/0t86fey5GIZ8W7Y0fkXyG+MkoQpw9duFCfRIHUAKiQl6RRoBG1moGaIKERh55WYc7d0Z8/Cc1yjrbifTQJVYWnVPbRQlGnRWSJS/igSVcLKlyFeXtH/I5dSh1Gfl523Aypq6Q2DjG7pfrSSjFw+T36N2nYxAW0fCAsdV1fby69NcIMrve1Mh2Wt6gP6QKBgQDxjKoT3tRD5qXnnSM6ifGkhFZAHO0d98IVHvxINDyj0K/ha8V0LcvNAoSjveI+S9985evk84r6DZlHAm+lhEE2Vmom/nQ1NbPBxBYXbej1RWEGuNImLZtX0jCIXKK40HLDgtI4enUT6hpG1yA5RfUe8uqDPiEcqbDWJ6endxJlfwKBgQDmGJxgiCZSKffclAUYLt5hQvc9XVwIVbr/oUXrbv72dSbzUDEMNznYn4+o7tYpfkZ0I3+LmHFBhpwWzAYMSbWjLKyf/UUEHfdW5mxBZv/wN7Lr+1sW9E030dfwNgurarknQcVbzoLoTCt8XjcOrkzr6Jp8I13R5sR1nM3g/UII6QKBgGKKcBgLH61TuvryMB0BiYMEOeuN4W4IVTUonuMV7GcoC5h6zuLGjA3mqRXjsRiY+2OIqOOON3QreAxwAfwUKEZymnut8tqCPgMea6TDQfZNh3emjpTkpir9pK78m6Wp5Ce+huRjkL+/EVk1CgBTedxWXTWNcxSuZWX4Z3z6JpchAoGBAKBqJAuAoAbET5MudubHNi5ku23Curjs2/QAAXkD5yj3v/H9xFQZ5HBLvaIu8Iv5BzFM1k0COGNQb13NW6IReVqLeMYJkqYuJhQljO+D2Yclrc2rbXPxWixCVeOYKkaVnwPpbKh2rvk4sVCBdqz7g5EslxdYqL3/vpOogDgNGI6RAoGAEItSnXjYosonrX4XX/yD1k35fTXEwKOg+sW2P8LEZSrenQpBok5AYso5GVwnE1Z72lH7T+f+cv6Le8UClcYNrRWO2ojQcsLQp6uGblZ4L4CYphYN6HAk2lh3al5PJkBFuM+ywunwn6fnyQrKetJZiErw3J4aD+tooXC8YZV+W2g=</Key></PublicKey></KeeShare>\n"
    QuietSuccess=true

    [PasswordGenerator]
    AdditionalChars=
    AdvancedMode=false
    ExcludedChars=
    Length=20
    Logograms=true
    SpecialChars=true
    WordCount=3
    WordSeparator=

    [SSHAgent]
    Enabled=true

    [Security]
    IconDownloadFallback=true
    LockDatabaseScreenLock=false
    PasswordsRepeatVisible=false
  '';

  systemd.user.services.nextcloud = {
    Unit = {
      Description = "nextcloud";
      Documentation = ["man:nextcloud(1)"];
      PartOf = ["hyprland-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud --background";
      RestartSec = 3;
      Restart = "always";
    };
    Install = {
      WantedBy = ["hyprland-session.target"];
    };
  };
}

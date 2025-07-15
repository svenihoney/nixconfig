{pkgs, ...}: let
  oldSshHost = {
    user = "root";
    extraOptions = {
      StrictHostKeyChecking = "no";
      HostKeyAlgorithms = "ssh-rsa";
      KexAlgorithms = "diffie-hellman-group1-sha1";
      Ciphers = "aes128-cbc";
    };
  };
in {
  programs = {
    ssh = {
      enable = true;
      hashKnownHosts = true;

      extraOptionOverrides = {
        AddKeysToAgent = "confirm";
        VerifyHostKeyDNS = "ask";
      };
      matchBlocks = {
        # Private playground
        "localhost" = {
          extraOptions = {
            StrictHostKeyChecking = "no";
          };
        };

        # Netcup
        "s1" = {
          user = "sven";
          hostname = "s1.effeffcee.de";
        };
        "s2" = {
          hostname = "2a03:4000:48:5aa:4844:36ff:feeb:c58a";
        };
        "dgm" = {
          user = "hosting211916";
          hostname = "2a03:4000:61:a732::21:1916";
        };
        "nas" = {
          user = "root";
          hostname = "nas.fritz.box";
        };
        nas2 = {
          setEnv = {TERM = "xterm";};
        };
        "bluecake" = {
          hostname = "hosting155974.a2ee8.netcup.net";
          user = "hosting155974";
        };

        # Open source
        "github.com" = {
          user = "svenihoney";
          hostname = "github.com";
          identityFile = "~/.ssh/id_dsa";
          extraOptions = {
            PreferredAuthentications = "publickey";
          };
        };
        "aur.archlinux.org" = {
          identityFile = "~/.ssh/aur";
          user = "aur";
        };

        # Qt
        "codereview.qt-project.org" = {
          hostname = "codereview.qt-project.org";
          port = 29418;
          user = "svenihoney";
          identityFile = "~/.ssh/id_rsa";
          extraOptions = {
            PreferredAuthentications = "publickey";
          };
        };

        # gecon
        "gecon" = {
          user = "hosting116266";
          hostname = "hosting116266.a2f75.netcup.net";
        };
        "gecondb" = {
          user = "fischer";
          hostname = "h2226969.stratoserver.net";
        };

        # ASV
        "asv" = {
          hostname = "sven146.r2dc.de";
          extraOptions = {
            ProxyJump = "ssh.r2dc.de";
          };
        };
        "ssh.r2dc.de" = {
          port = 53022;
        };
        "ssh.r1" = {
          hostname = "ssh3.r25dc.de";
          port = 10022;
          #       user sven
          extraOptions = {
            ForwardAgent = "yes";
            # AddressFamily = "inet";
          };
        };
        "asv2" = {
          hostname = "dockweb123";
          extraOptions = {
            ProxyJump = "ssh.r1";
          };
        };

        # TaxDigits
        "taxworker" = {
          hostname = "dedivirt2025.your-server.de";
          user = "taxadmin";
          port = 222;
          extraOptions = {
            ForwardAgent = "yes";
          };
        };

        # Kunden
        "cosy" = {
          user = "root";
          hostname = "192.168.0.4";
          extraOptions = {
            SetEnv = "TERM=xterm";
          };
        };
      };
    };
  };
}

{...}: {
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;

      extraOptionOverrides = {
        AddKeysToAgent = "confirm";
        VerifyHostKeyDNS = "ask";
        WarnWeakCrypto = "no";
      };
      settings = {
        # Private playground
        localhost = {
          StrictHostKeyChecking = "no";
        };
        "*" = {
          HashKnownHosts = true;
        };

        # Netcup
        "s2" = {
          # hostname = "2a03:4000:48:5aa:4844:36ff:feeb:c58a";
          HostName = "struppi.effeffcee.de";
        };
        "dgm" = {
          User = "hosting211916";
          HostName = "2a03:4000:61:a732::21:1916";
        };
        # Strato
        "tim" = {
          # HostName = "2a03:4000:48:5aa:4844:36ff:feeb:c58a";
          HostName = "tim.effeffcee.de";
        };
        "dgmold" = {
          User = "stu844689249";
          HostName = "54070345.ssh.w1.strato.hosting";
        };

        "bluecake" = {
          HostName = "hosting155974.a2ee8.netcup.net";
          User = "hosting155974";
        };

        # Open source
        "github.com" = {
          User = "svenihoney";
          HostName = "github.com";
          IdentityFile = "~/.ssh/id_ed25519";
        };
        "aur.archlinux.org" = {
          IdentityFile = "~/.ssh/aur";
          User = "aur";
        };

        # Qt
        "codereview.qt-project.org" = {
          HostName = "codereview.qt-project.org";
          Port = 29418;
          User = "svenihoney";
          IdentityFile = "~/.ssh/id_rsa";
        };

        # gecon
        "gecon" = {
          User = "hosting116266";
          HostName = "hosting116266.a2f75.netcup.net";
        };
        "gecondb" = {
          User = "fischer";
          HostName = "h2226969.stratoserver.net";
        };

        # ASV
        "asv" = {
          HostName = "ssh.asv-bonn.de";
          Port = 53022;
        };

        # TaxDigits
        "taxworker" = {
          HostName = "dedivirt2025.your-server.de";
          User = "taxadmin";
          Port = 222;
          ForwardAgent = "yes";
        };

        # Kunden
        "cosy" = {
          User = "root";
          HostName = "192.168.0.4";
          IdentityFile = "~/.ssh/nwot_mif.rsa";
          StrictHostKeyChecking = "no";
        };
        "i-* mi-*" = {
          User = "ssm-user";
          # extraOptions = {ProxyCommand = "sh -c \"aws-gate ssh-proxy -P %p %h\"";};
          ProxyCommand = "sh -c \"aws-gate ssh-proxy -P %p %h\"";
        };
      };
    };
  };
}

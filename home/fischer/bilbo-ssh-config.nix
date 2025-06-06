{pkgs, ...}: let
  oldSshHost = {
    extraOptions = {
      StrictHostKeyChecking = "no";
      HostKeyAlgorithms = "+ssh-rsa";
      # KexAlgorithms = "diffie-hellman-group1-sha1";
      PubkeyAcceptedAlgorithms = "+ssh-rsa";
      # Ciphers = "aes128-cbc";
    };
  };
  rootUser = {
    user = "root";
  };
  xterm = {
    setEnv = {TERM = "xterm";};
  };
  qnxSshHost = rootUser // xterm // oldSshHost;
in {
  programs = {
    ssh = {
      hashKnownHosts = true;

      extraOptionOverrides = {
        AddKeysToAgent = "confirm";
        VerifyHostKeyDNS = "ask";
      };
      matchBlocks = {
        # ekf = {hostname = "ekf-fischer";} // qnxSshHost;
        ekf = {hostname = "ekf-fischer";} // qnxSshHost;
        halle = {hostname = "192.168.0.2";} // qnxSshHost;
        # ekf = qnxSshHost;

        # Host ekf
        #   Hostname ekf-fischer
        #   User root
        #   HostKeyAlgorithms +ssh-rsa
        #   PubkeyAcceptedAlgorithms +ssh-rsa
        # Host halle
        #   Hostname 192.168.0.2
        #   User root
        #   HostKeyAlgorithms +ssh-rsa
        #   PubkeyAcceptedAlgorithms +ssh-rsa
        # Host ekfhagen
        #   Hostname 192.168.0.3
        #   User root
        # Host ekfadauto
        #   Hostname 192.168.0.6
        #   User root
        # Host ekfa
        #   Hostname ekfallegro
        #   User root
        # Host ads2
        #   Hostname 192.168.0.2
        #   User root
        #   HostKeyAlgorithms +ssh-rsa
        #   PubkeyAcceptedAlgorithms +ssh-rsa

        docker = {
          user = "rancher";
          setEnv = {TERM = "xterm";};
        };
        mirror = rootUser // xterm;
        proxmox = {
          hostname = "proxmox1";
          user = "root";
        };
        chuck = rootUser // xterm;
        nas1 = rootUser;
        "gerrit.software.ads" = oldSshHost // xterm;

        willi = {
          hostname = "192.168.11.63";
          user = "sven";
        };
        maja = {
          hostname = "maja.fritz.box";
          user = "sven";
        };
        #   # Private playground
        #   "localhost" = {
        #     extraOptions = {
        #       StrictHostKeyChecking = "no";
        #     };
        #   };

        #   # Netcup
        #   "s1" = {
        #     user = "sven";
        #     hostname = "s1.effeffcee.de";
        #   };
        #   "s2" = {
        #     hostname = "2a03:4000:48:5aa:4844:36ff:feeb:c58a";

        #   };
        #   "bluecake" = {
        #     hostname = "hosting155974.a2ee8.netcup.net";
        #     user = "hosting155974";
        #   };

        #   # Open source
        #   "github.com" = {
        #     user = "svenihoney";
        #     hostname = "github.com";
        #     identityFile = "~/.ssh/id_dsa";
        #     extraOptions = {
        #       PreferredAuthentications = "publickey";
        #     };
        #   };
        #   "aur.archlinux.org" = {
        #     identityFile = "~/.ssh/aur";
        #     user = "aur";
        #   };

        #   # Qt
        #   "codereview.qt-project.org" = {
        #     hostname = "codereview.qt-project.org";
        #     port = 29418;
        #     user = "svenihoney";
        #     identityFile = "~/.ssh/id_rsa";
        #     extraOptions = {
        #       PreferredAuthentications = "publickey";
        #     };
        #   };

        #   # DEUTA
        #   "gitlab.deutaeit.intranet" = {
        #     port = 8222;
        #   };
        #   ave = qnxSshHost;
        #   avetest = qnxSshHost;
        #   qnx63 = qnxSshHost;

        #   # Variable DEUTA hosts
        #   "left right leftp rightp redbox" = {
        #     extraOptions = {
        #       PubkeyAcceptedKeyTypes = "+ssh-rsa";
        #       StrictHostKeyChecking = "no";
        #       UserKnownHostsFile = "/dev/null";
        #     };
        #     user = "root";
        #     # identityFile = "~/.ssh/deuta-root-dat.key";
        #     identityFile = "~/.ssh/id_rsa";
        #   };
        #   "leftp " = {
        #     hostname = "bg34";
        #     port = 22003;

        #   };
        #   "rightp " = {
        #     hostname = "bg34";
        #     port = 22004;

        #   };
        #   "bg34" = {
        #     extraOptions = {
        #       StrictHostKeyChecking = "no";
        #       UserKnownHostsFile = "/dev/null";
        #     };
        #     user = "pi";
        #   };
        #   "redbox" = {
        #     extraOptions = {
        #       UserKnownHostsFile = "/dev/null";
        #       StrictHostKeyChecking = "no";
        #       HostKeyAlgorithms = "ssh-dss";
        #       KexAlgorithms = "diffie-hellman-group1-sha1";
        #     };
        #   };
        #   "deutahost" = {
        #     user = "rancher";
        #     hostname = "192.168.2.60";
        #     extraOptions = {
        #       PreferredAuthentications = "publickey";
        #     };
        #     identityFile = "~/.ssh/deuta-rancher-rsa";
        #   };
        #   "qnx" = {
        #     user = "root";
        #     hostname = "192.168.11.75";
        #     extraOptions = {
        #       HostKeyAlgorithms = "ssh-rsa";
        #       KexAlgorithms = "diffie-hellman-group1-sha1";
        #       Ciphers = "aes256-cbc";
        #     };
        #   };
        #   "evl" = {
        #     user = "root";
        #   };
        #   "evr" = {
        #     user = "root";
        #   };

        #   # gecon
        #   "gecon" = {
        #     user = "hosting116266";
        #     hostname = "hosting116266.a2f75.netcup.net";
        #   };
        #   "gecondb" = {
        #     user = "fischer";
        #     hostname = "h2226969.stratoserver.net";
        #   };

        #   # ASV
        #   "asv" = {
        #     hostname = "sven146.r2dc.de";
        #     extraOptions = {
        #       ProxyJump = "ssh.r2dc.de";
        #     };
        #   };
        #   "ssh.r2dc.de" = {
        #     port = 53022;
        #   };

        #   # TaxDigits
        #   "taxworker" = {
        #     hostname = "dedivirt2025.your-server.de";
        #     user = "taxadmin";
        #     port = 222;
        #     extraOptions = {
        #       ForwardAgent = "yes";
        #     };
        #   };
      };
    };
  };
}

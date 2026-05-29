{pkgs, ...}: let
  oldSshHost = {
    StrictHostKeyChecking = "no";
    HostKeyAlgorithms = "+ssh-rsa";
    # KexAlgorithms = "diffie-hellman-group1-sha1";
    PubkeyAcceptedAlgorithms = "+ssh-rsa";
    # Ciphers = "aes128-cbc";
  };
  rootUser = {
    User = "root";
  };
  xterm = {
    SetEnv = {
      TERM = "xterm";
    };
  };
  qnxSshHost = rootUser // xterm // oldSshHost;
in {
  programs = {
    ssh = {
      # hashKnownHosts = true;
      enableDefaultConfig = false;

      extraOptionOverrides = {
        AddKeysToAgent = "confirm";
        VerifyHostKeyDNS = "ask";
      };
      settings = {
        # ekf = {hostname = "ekf-fischer";} // qnxSshHost;
        ekf =
          {
            HostName = "ekf-fischer";
          }
          // qnxSshHost;
        halle =
          {
            HostName = "192.168.0.2";
          }
          // qnxSshHost;

        docker =
          {
            User = "rancher";
          }
          // xterm;
        mirror = rootUser // xterm;
        proxmox =
          {
            HostName = "proxmox1";
          }
          // rootUser;
        chuck = rootUser // xterm;
        nas1 = rootUser // xterm;
        "gerrit.software.ads" = oldSshHost // xterm;

        willi = {
          HostName = "192.168.11.63";
          User = "sven";
        };
        maja = {
          HostName = "maja.fritz.box";
          User = "sven";
        };
      };
    };
  };
}

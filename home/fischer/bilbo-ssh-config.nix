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
  qnxSshHost = rootUser // oldSshHost;
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
          };
        mirror = rootUser;
        proxmox =
          {
            HostName = "proxmox1";
          }
          // rootUser;
        chuck = rootUser;
        nas1 = rootUser;
        "gerrit.software.ads" = oldSshHost;

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

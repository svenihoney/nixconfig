{pkgs, ...}: {
  programs = {
    ssh = {
      enable = true;
      # hashKnownHosts = true;
      enableDefaultConfig = false;

      extraOptionOverrides = {
        AddKeysToAgent = "confirm";
        # VerifyHostKeyDNS = "ask";
      };
    };
  };
}

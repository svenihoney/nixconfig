{pkgs, ...}: {
  programs = {
    ssh = {
      enable = true;
      hashKnownHosts = true;

      extraOptionOverrides = {
        AddKeysToAgent = "confirm";
        # VerifyHostKeyDNS = "ask";
      };
    };
  };
}

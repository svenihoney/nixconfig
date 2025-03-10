{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
  programs.fish.shellAbbrs.y = "yazi";
}

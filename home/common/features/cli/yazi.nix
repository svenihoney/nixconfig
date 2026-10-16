{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";
  };
  # programs.fish.shellAbbrs.y = "yazi";
}

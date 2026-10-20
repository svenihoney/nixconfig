{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";
  };
  # programs.fish.shellAbbrs.y = "yazi";
}

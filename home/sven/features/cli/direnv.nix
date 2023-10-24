{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  # Speed up direnv
  # services.lorri.enable = true;
}

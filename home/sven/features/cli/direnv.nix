{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };
  # Speed up direnv
  # services.lorri.enable = true;
}

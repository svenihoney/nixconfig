{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.lazyvim.homeManagerModules.default ];
  programs.lazyvim = {
    enable = true;
    # appName = "lvim";  # Creates config in ~/.config/lazyvim/
    extras = {
      lang.nix = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
      # lang.python.enable = true;
    };
    # extraPackages = with pkgs; [
    #   nixd
    #   statix
    #   alejandra
    # ];
    # treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [ lua nix ];
  };
}

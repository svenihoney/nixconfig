{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
# let
#   inherit (inputs.nix-colors) colorSchemes;
#   inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) colorschemeFromPicture nixWallpaperFromScheme;
# in
{
  imports =
    [
      # inputs.impermanence.nixosModules.home-manager.impermanence
      inputs.nixvim.homeModules.nixvim

      ../features/cli
      ../features/editors/nvim
      ../features/editors/helix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      trusted-users = ["${config.home.username}"];
    };
  };

  # systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "sven";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
    sessionPath = ["$HOME/.local/bin"];
    # sessionVariables = {
    #   FLAKE = "$HOME/Documents/NixConfig";
    # };

    # persistence = {
    #   "/persist/home/${user}" = {
    #     directories = [
    #       "Documents"
    #       "Downloads"
    #       "Pictures"
    #       "Videos"
    #       ".local/bin"
    #     ];
    #     allowOther = true;
    #   };
    # };
  };
}

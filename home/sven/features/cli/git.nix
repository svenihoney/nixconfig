{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      graph = "log --decorate --oneline --graph";
      si = "submodule update --init --recursive";
    };
    userName = "Sven Fischer";
    userEmail = lib.mkDefault "sven@leiderfischer.de";
    extraConfig = {
      init.defaultBranch = "main";
      # user.signing.key = "CE707A2C17FAAC97907FF8EF2E54EA7BFE630916";
      # commit.gpgSign = true;
      # gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    lfs.enable = true;
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        syntax-theme = "base16-stylix";
      };
    };
    ignores = [".direnv" "result"];
  };
}

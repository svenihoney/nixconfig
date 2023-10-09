{ pkgs, lib, config, ... }:
let
  ssh = "${pkgs.openssh}/bin/ssh";
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      graph = "log --decorate --oneline --graph";
      si = "submodule update --init --recursive";
    };
    userName = "Sven Fischer";
    userEmail = "sven@leiderfischer.de";
    extraConfig = {
      init.defaultBranch = "main";
      # user.signing.key = "CE707A2C17FAAC97907FF8EF2E54EA7BFE630916";
      # commit.gpgSign = true;
      # gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}

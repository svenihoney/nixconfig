{ self
, ...
}:

system:

with self.pkgs.${system};
{
  default = mkShell {
    name = "nix-config";
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
    nativeBuildInputs = [
      nix
      home-manager
      git

      sops
      ssh-to-age
      gnupg
      age

      cachix
      deploy-rs
      nil
      # nix-build-uncached
      # nix-eval-jobs
      # nixpkgs-fmt
      # nixfmt
      alejandra
      # statix

      # Lua
      # stylua
      # (luajit.withPackages (p: with p; [ luacheck ]))
      # lua-language-server

      # Shell
      shellcheck
      shfmt

      # GitHub Actions
      # act
      # actionlint
      # python3Packages.pyflakes

      # Misc
      # jq
      pre-commit
    ];

    shellHook = ''
      ${self.checks.${system}.pre-commit-check.shellHook}
    '';
  };
}

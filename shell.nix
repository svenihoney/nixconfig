# Shell for bootstrapping flake-enabled nix and other tooling
{ pkgs ? # If pkgs is not defined, instanciate nixpkgs from locked commit
  let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
  import nixpkgs { overlays = [ ]; }
, ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git

      sops
      ssh-to-age
      gnupg
      age

      cachix
      deploy-rs
      # nil
      # nix-build-uncached
      # nix-eval-jobs
      nixpkgs-fmt
      nixfmt
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
  };
}

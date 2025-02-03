{pkgs, ...}: {
  imports = [
    # ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./atuin.nix
    # ./gh.nix
    ./git.nix
    ./gpg.nix
    # ./jujutsu.nix
    # ./lyrics.nix
    ./nix-index.nix
    # ./pfetch.nix
    # ./ranger.nix
    # ./screen.nix
    # ./shellcolor.nix
    ./ssh.nix
    # ./starship.nix
    # ./xpo.nix
    ./yazi.nix
  ];
  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them
    # manix # Nix documentation search tool, seems to be abandoned

    # distrobox # Nice escape hatch, integrates docker images with my environment

    # System viewer
    bottom
    btop
    htop
    procs

    ncdu # TUI disk usage
    ripgrep # Better grep
    fd # Better find
    sd # Better sed
    file

    xh # Better curl
    wget
    # diffsitter # Better diff
    jaq # JSON pretty printer and manipulator, Rust clone
    # trekscii # Cute startrek cli printer
    # timer # To help with my ADHD paralysis

    # nil # Nix LSP
    # alejandra # Nix formatter
    # nix-inspect # See which pkgs are in your PATH
    nh # Nix helper

    # ltex-ls # Spell checking LSP

    # tly # Tally counter
    viddy
    just

    # inputs.nh.default # nixos-rebuild and home-manager CLI wrapper
    zip
    unzip
  ];

  programs = {
    zellij.enable = true;
    # thefuck.enable = true;
    eza = {
      # Better ls
      enable = true;
      git = false;
      icons = "auto";
      extraOptions = ["--hyperlink"];
    };
    fish = {
      shellAliases = {
        jq = "jaq";
      };
    };
  };
}

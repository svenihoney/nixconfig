{pkgs, ...}: {
  home = {
    # Fish plugin prerequisites
    packages = with pkgs; [
      grc
    ];
  };

  programs = {
    # Fish plugin prerequisites
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "bass";
          src = pkgs.fishPlugins.bass.src;
        }
        {
          name = "autopairs";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "puffer-fish";
          src = pkgs.fishPlugins.puffer.src;
        }
        # {
        #   name = "fifc";
        #   src = pkgs.fishPlugins.fifc.src;
        # }
      ];

      shellAbbrs = {
        jqless = "jq -C | less -r";

        n = "nix";
        nd = "nix develop -c $SHELL";
        ns = "nix shell";
        nsn = "nix shell nixpkgs#";
        nb = "nix build";
        nbn = "nix build nixpkgs#";
        nf = "nix flake";

        nr = "nixos-rebuild --flake .";
        nrs = "nixos-rebuild --flake . switch";
        snr = "sudo nixos-rebuild --flake .";
        snrs = "sudo nixos-rebuild --flake . switch";
        hm = "home-manager --flake .";
        hms = "home-manager --flake . switch";

        j = "just";
      };
      shellAliases = {
        # Clear screen and scrollback
        clear = "printf '\\033[2J\\033[3J\\033[1;1H'";

        cat = "${pkgs.bat}/bin/bat --paging=never";
        # ".j" = "${pkgs.just}/bin/just --justfile ~/.user.justfile";
        less = ''${pkgs.bat}/bin/bat --paging=always --pager "${pkgs.less}/bin/less -RF"'';
        # man = "${pkgs.bat-extras.batman}/bin/batman";
        nis = "${pkgs.nix}/bin/nix search nixpkgs";
      };
      functions = {
        # Disable greeting
        fish_greeting = "";
        # Integrate ssh with shellcolord
        # ssh = mkIf hasShellColor ''
        #   ${shellcolor} disable $fish_pid
        #   # Check if kitty is available
        #   if set -q KITTY_PID && set -q KITTY_WINDOW_ID && type -q -f kitty
        #     kitty +kitten ssh $argv
        #   else
        #     command ssh $argv
        #   end
        #   ${shellcolor} enable $fish_pid
        #   ${shellcolor} apply $fish_pid
        # '';
      };
      interactiveShellInit =
        # Open command buffer in vim when alt+e is pressed
        ''
          bind \ee edit_command_buffer
        '';
    };
  };

  services.gpg-agent = {
    enableFishIntegration = true;
  };
}

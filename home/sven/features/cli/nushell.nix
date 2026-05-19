{
  pkgs,
  lib,
  ...
}: {
  programs.nushell = {
    enable = true;

    # Typed settings — home-manager flattens these into $env.config assignments
    # which avoids clobbering unrelated defaults
    settings = {
      show_banner = false;
      edit_mode = "vi"; # or "emacs"
      buffer_editor = "vi";
      # table_mode          = "rounded";
      # use_ls_colors       = true;
      # color_config.header = "purple_bold";
      table.mode = "light";

      history = {
        # max_size        = 100000;
        # sync_on_enter   = true;
        file_format = "sqlite"; # much better than plaintext
        # isolation       = true;             # per-session history
      };

      # completions = {
      #   case_sensitive = false;
      #   quick          = true;
      #   partial        = true;
      #   algorithm      = "fuzzy";
      #   external = {
      #     enable      = true;
      #     max_results = 100;
      #   };
      # };

      cursor_shape = {
        vi_normal = "line";
        vi_insert = "block";
      };

      # keybindings = [
      #   ''          {
      #         name: insert_last_token
      #         modifier: alt
      #         keycode: char_.
      #         mode: [emacs vi_normal vi_insert]
      #         event: [
      #           { edit: InsertString, value: "!$" }
      #           { send: Enter }
      #         ]''
      # ];
    };

    # Raw Nu code appended to config.nu — use for things settings can't express
    extraConfig = ''
      # ── Carapace completions ────────────────────────────────────────────────
      # let carapace_completer = {|spans|
      #   carapace $spans.0 nushell ...$spans
      #     | from json
      #     | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
      # }
      # $env.config.completions.external.completer = $carapace_completer

      # ── Better ls helpers ───────────────────────────────────────────────────
      def ll [...args] { ls -l  ...(if $args == [] { ["."] } else { $args }) | sort-by type name -i }
      def la [...args] { ls -a  ...(if $args == [] { ["."] } else { $args }) | sort-by type name -i }
      def lla [...args] { ls -la ...(if $args == [] { ["."] } else { $args }) | sort-by type name -i }

      #   # ── Convenience ─────────────────────────────────────────────────────────
      #   def mkcd [dir: path] { mkdir $dir; cd $dir }

      def up [n: int = 1] {
        cd (1..$n | reduce -f "." {|_, acc| $acc + "/.."})
      }
    '';

    # env.nu — PATH and environment variables
    # extraEnv = ''
    #   $env.EDITOR  = "hx"       # or nvim, vim, etc.
    #   $env.VISUAL  = $env.EDITOR
    #   $env.PAGER   = "less -RF"

    #   # XDG
    #   $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
    #   $env.XDG_CACHE_HOME  = ($env.HOME | path join ".cache")
    #   $env.XDG_DATA_HOME   = ($env.HOME | path join ".local/share")

    #   # Starship prompt
    #   $env.STARSHIP_SHELL = "nu"
    #   $env.PROMPT_COMMAND = { starship prompt }
    #   $env.PROMPT_COMMAND_RIGHT = { starship prompt --right }
    #   $env.PROMPT_INDICATOR = ""
    #   $env.PROMPT_INDICATOR_VI_INSERT  = ": "
    #   $env.PROMPT_INDICATOR_VI_NORMAL  = "〉"
    #   $env.PROMPT_MULTILINE_INDICATOR  = "::: "
    # '';

    shellAliases = {
      cat = "${pkgs.bat}/bin/bat --paging=never";
      # ".j" = "${pkgs.just}/bin/just --justfile ~/.user.justfile";
      less = ''${pkgs.bat}/bin/bat --paging=always --pager "${pkgs.less}/bin/less -RF"'';
      # man = "${pkgs.bat-extras.batman}/bin/batman";
      nis = "${pkgs.nix}/bin/nix search nixpkgs";
      j = "${lib.getExe pkgs.just}";

      #   # Editors
      #   v   = "hx";
      #   vim = "hx";

      #   # Navigation
      #   ".." = "cd ..";
      #   "..." = "cd ../..";

      #   # Git
      #   g   = "git";
      #   gs  = "git status";
      #   gd  = "git diff";
      #   gp  = "git push";
      #   gl  = "git log --oneline --graph --decorate";

      #   # Nix
      #   nrs  = "sudo nixos-rebuild switch --flake .#";
      #   hms  = "home-manager switch --flake .#";
      #   nfu  = "nix flake update";
      #   ngc  = "nix-collect-garbage -d";

      #   # Misc
      #   cat  = "bat";
      #   ls   = "ls";           # keep nushell's built-in
      #   grep = "rg";

      # rgrc
      blkid = "${lib.getExe pkgs.rgrc} blkid";
      curl = "${lib.getExe pkgs.rgrc} curl";
      df = "${lib.getExe pkgs.rgrc} df";
      diff = "${lib.getExe pkgs.rgrc} diff";
      dig = "${lib.getExe pkgs.rgrc} dig";
      docker = "${lib.getExe pkgs.rgrc} docker";
      # du = "${lib.getExe pkgs.rgrc} du";
      env = "${lib.getExe pkgs.rgrc} env";
      fdisk = "${lib.getExe pkgs.rgrc} fdisk";
      findmnt = "${lib.getExe pkgs.rgrc} findmnt";
      free = "${lib.getExe pkgs.rgrc} free";
      gcc = "${lib.getExe pkgs.rgrc} gcc";
      getfacl = "${lib.getExe pkgs.rgrc} getfacl";
      id = "${lib.getExe pkgs.rgrc} id";
      ip = "${lib.getExe pkgs.rgrc} ip";
      iptables = "${lib.getExe pkgs.rgrc} iptables";
      last = "${lib.getExe pkgs.rgrc} last";
      lsblk = "${lib.getExe pkgs.rgrc} lsblk";
      lsmod = "${lib.getExe pkgs.rgrc} lsmod";
      lspci = "${lib.getExe pkgs.rgrc} lspci";
      # ls = "${lib.getExe pkgs.rgrc} ls";
      mount = "${lib.getExe pkgs.rgrc} mount";
      ping = "${lib.getExe pkgs.rgrc} ping";
      podman = "${lib.getExe pkgs.rgrc} podman";
      # ps = "${lib.getExe pkgs.rgrc} ps";
      showmount = "${lib.getExe pkgs.rgrc} showmount";
      ss = "${lib.getExe pkgs.rgrc} ss";
      # stat = "${lib.getExe pkgs.rgrc} stat";
      sysctl = "${lib.getExe pkgs.rgrc} sysctl";
      systemctl = "${lib.getExe pkgs.rgrc} systemctl";
      journalctl = "${lib.getExe pkgs.rgrc} journalctl --no-pager | less -R";
      tail = "${lib.getExe pkgs.rgrc} tail";
      # uptime = "${lib.getExe pkgs.rgrc} uptime";
      vmstat = "${lib.getExe pkgs.rgrc} vmstat";
    };
  };

  home.shell.enableNushellIntegration = true;

  # Companion tools that integrate with the config above
  programs = {
    zoxide.enableNushellIntegration = true;
    yazi.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    # pay-respects.enableNushellIntegration = true;
    nix-your-shell.enableNushellIntegration = true;
    nix-index.enableNushellIntegration = true;
    lazygit.enableNushellIntegration = true;
    eza.enableNushellIntegration = true;
    direnv.enableNushellIntegration = true;

    carapace.enableNushellIntegration = true;
    carapace.enable = true;
  };
  services.gpg-agent.enableNushellIntegration = true;
}

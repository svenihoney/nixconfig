{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # History-Vorschläge aus der History (wie fish / zsh-autosuggestions)
    autosuggestion.enable = true;

    # Syntax-Highlighting (wird von HM automatisch als letztes geladen)
    # syntaxHighlighting.enable = true;
    fastSyntaxHighlighting.enable = true;

    history = {
      size = 100000;
      save = 100000;
      ignoreDups = true;
      share = true;
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

    zsh-abbr = {
      enable = true;
      abbreviations = {
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
        ds = "devenv shell";

        sc = "systemctl";
        jc = "journalctl";
      };
    };

    plugins = [
      {
        name = pkgs.zsh-fzf-tab.pname;
        src = pkgs.zsh-fzf-tab.src;
        # Upstream-Datei heißt nicht <pname>.plugin.zsh – HM überspringt sie sonst still
        file = "fzf-tab.plugin.zsh";
      }
      # Achtung: HM lädt diese Plugins NACH compinit – genau richtig für fzf-tab.
      {
        name = pkgs.zsh-autopair.pname;
        src = pkgs.zsh-autopair.src;
      }
      {
        name = pkgs.zsh-nix-shell.pname;
        src = pkgs.zsh-nix-shell.src;
        file = "nix-shell.plugin.zsh";
      }
      {
        name = pkgs.zsh-bd.pname;
        src = pkgs.zsh-bd.src;
        file = "bd.plugin.zsh";
      }
    ];

    # Alles andere nach compinit
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)
      '')
      ''
        # ── Fish-Feature 2: Completion-Menü mit fzf ──────────
        # zstyle ':completion:*' menu select
        # zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        # zstyle ':completion:*:descriptions' format '[%d]'

        # disable sort when completing `git checkout`
        zstyle ':completion:*:git-checkout:*' sort false
        # set descriptions format to enable group support
        # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
        zstyle ':completion:*:descriptions' format '[%d]'
        # set list-colors to enable filename colorizing
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
        zstyle ':completion:*' menu no
        # preview directory's content with eza when completing cd
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
        # custom fzf flags
        # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
        zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
        # To make fzf-tab follow FZF_DEFAULT_OPTS.
        # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
        # zstyle ':fzf-tab:*' use-fzf-default-opts yes
        # switch group using `<` and `>`
        zstyle ':fzf-tab:*' switch-group '<' '>'
        # Case insensitive completion match
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

        # ── Fish-Feature 3: `*` + Tab expandiert nativ (nix zu tun) ────────
        # Optionale Ergänzung: Tab zeigt zuerst Liste statt sofort zu expandieren
        setopt glob_complete
        setopt auto_cd

        # ── puffer-fish-Äquivalent: global alias Expansion ────────────────
        alias -g ...='../..'
        alias -g ....='../../..'

        # ── Shift+Left/Right: wortweise springen, nimmt Autosuggestion teilweise an ──
        # (forward-word ist in ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS)
        bindkey '^[[1;5D' backward-word
        bindkey '^[[1;5C' forward-word
      ''
    ];

    dotDir = "${config.xdg.configHome}/zsh";
  };
}

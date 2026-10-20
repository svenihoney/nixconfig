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
        name = "fzf-tab";                  # fish-"fifc"-Äquivalent
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-autopair";             # fish-"autopairs"-Äquivalent
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      # Achtung: HM lädt diese Plugins NACH compinit – genau richtig für fzf-tab.
    ];


    # Alles andere nach compinit
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)
      '')
      ''
      # ── Fish-Feature 2: Completion-Menü mit Cursor-Navigation ──────────
      # zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

      # ── Fish-Feature 3: `*` + Tab expandiert nativ (nix zu tun) ────────
      # Optionale Ergänzung: Tab zeigt zuerst Liste statt sofort zu expandieren
      setopt glob_complete
      setopt auto_cd

      # ── puffer-fish-Äquivalent: global alias Expansion ────────────────
      alias -g ...='../..'
      alias -g ....='../../..'
      # !!, !$ und !* funktionieren in zsh nativ (History-Expansion).

      # ── Autosuggestion: ganzen Vorschlag annehmen, dann editierbar ────
      bindkey '^ ' expand-word

      # ── fzf-Tab: nach der fzf-Integration (Order 910) wieder binden ──
      bindkey '^I' fzf-tab-complete

      # ── Ctrl+Alt+F: Dateisuche wie in fish (fzf.fish) ────────────────
      bindkey '^[^F' fzf-file-widget
      ''];

    dotDir = "${config.xdg.configHome}/zsh";
  };
}

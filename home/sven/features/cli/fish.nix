{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf;
  hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;
  hasRipgrep = hasPackage "ripgrep";
  hasExa = hasPackage "eza";
  hasNeovim = config.programs.neovim.enable;
  hasEmacs = config.programs.emacs.enable;
  # hasNeomutt = config.programs.neomutt.enable;
  # hasShellColor = config.programs.shellcolor.enable;
  # hasKitty = config.programs.kitty.enable;
  # shellcolor = "${pkgs.shellcolord}/bin/shellcolor";
in
{
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
    eza = {
      enable = true;
      enableAliases = true;
      git = false;
      icons = true;
    };

    fish = {
      enable = true;
      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "tide"; src = pkgs.fishPlugins.tide.src; }
        { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
      ];

      shellAbbrs = rec {
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

        # ls = mkIf hasExa "eza";
        exa = mkIf hasExa "eza";

        em = mkIf hasEmacs "emacsclient -t";

        vim = mkIf hasNeovim "nvim";
        vi = vim;
        v = vim;

        j = "just";
      };
      shellAliases = {
        # Clear screen and scrollback
        clear = "printf '\\033[2J\\033[3J\\033[1;1H'";

        cat = "${pkgs.bat}/bin/bat";
        # ".j" = "${pkgs.just}/bin/just --justfile ~/.user.justfile";
        less = ''${pkgs.bat}/bin/bat --paging=always --pager "${pkgs.less}/bin/less -RF"'';
        man = "${pkgs.bat-extras.batman}/bin/batman";
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
        '' +
        # Use terminal colors
      #   ''
      #   set -U fish_color_autosuggestion      brblack
      #   set -U fish_color_cancel              -r
      #   set -U fish_color_command             brgreen
      #   set -U fish_color_comment             brmagenta
      #   set -U fish_color_cwd                 green
      #   set -U fish_color_cwd_root            red
      #   set -U fish_color_end                 brmagenta
      #   set -U fish_color_error               brred
      #   set -U fish_color_escape              brcyan
      #   set -U fish_color_history_current     --bold
      #   set -U fish_color_host                normal
      #   set -U fish_color_match               --background=brblue
      #   set -U fish_color_normal              normal
      #   set -U fish_color_operator            cyan
      #   set -U fish_color_param               brblue
      #   set -U fish_color_quote               yellow
      #   set -U fish_color_redirection         bryellow
      #   set -U fish_color_search_match        'bryellow' '--background=brblack'
      #   set -U fish_color_selection           'white' '--bold' '--background=brblack'
      #   set -U fish_color_status              red
      #   set -U fish_color_user                brgreen
      #   set -U fish_color_valid_path          --underline
      #   set -U fish_pager_color_completion    normal
      #   set -U fish_pager_color_description   yellow
      #   set -U fish_pager_color_prefix        'white' '--bold' '--underline'
      #   set -U fish_pager_color_progress      'brwhite' '--background=cyan'
      # '' +
        # Tide prompt setup
        ''
        set -U tide_aws_bg_color FF9900
        set -U tide_aws_color 232F3E
        set -U tide_aws_icon 
        set -U tide_character_color 5FD700
        set -U tide_character_color_failure FF0000
        set -U tide_character_icon ❯
        set -U tide_character_vi_icon_default ❮
        set -U tide_character_vi_icon_replace ▶
        set -U tide_character_vi_icon_visual V
        set -U tide_chruby_bg_color B31209
        set -U tide_chruby_color 000000
        set -U tide_chruby_icon 
        set -U tide_cmd_duration_bg_color C4A000
        set -U tide_cmd_duration_color 000000
        set -U tide_cmd_duration_decimals 0
        set -U tide_cmd_duration_icon 
        set -U tide_cmd_duration_threshold 3000
        set -U tide_context_always_display false
        set -U tide_context_bg_color 444444
        set -U tide_context_color_default D7AF87
        set -U tide_context_color_root D7AF00
        set -U tide_context_color_ssh D7AF87
        set -U tide_context_hostname_parts 1
        set -U tide_crystal_bg_color FFFFFF
        set -U tide_crystal_color 000000
        set -U tide_crystal_icon ⬢
        set -U tide_docker_bg_color 2496ED
        set -U tide_docker_color 000000
        set -U tide_docker_default_contexts 'default'  'colima'
        set -U tide_docker_icon 
        set -U tide_git_bg_color 4E9A06
        set -U tide_git_bg_color_unstable C4A000
        set -U tide_git_bg_color_urgent CC0000
        set -U tide_git_color_branch 000000
        set -U tide_git_color_conflicted 000000
        set -U tide_git_color_dirty 000000
        set -U tide_git_color_operation 000000
        set -U tide_git_color_staged 000000
        set -U tide_git_color_stash 000000
        set -U tide_git_color_untracked 000000
        set -U tide_git_color_upstream 000000
        set -U tide_git_icon 
        set -U tide_git_truncation_length 24
        set -U tide_go_bg_color 00ACD7
        set -U tide_go_color 000000
        set -U tide_go_icon 
        set -U tide_java_bg_color ED8B00
        set -U tide_java_color 000000
        set -U tide_java_icon 
        set -U tide_jobs_bg_color 444444
        set -U tide_jobs_color 4E9A06
        set -U tide_jobs_icon 
        set -U tide_kubectl_bg_color 326CE5
        set -U tide_kubectl_color 000000
        set -U tide_kubectl_icon ⎈
        set -U tide_left_prompt_frame_enabled false
        set -U tide_left_prompt_items 'os'  'pwd'
        set -U tide_left_prompt_prefix
        set -U tide_left_prompt_separator_diff_color 
        set -U tide_left_prompt_separator_same_color 
        set -U tide_left_prompt_suffix 
        set -U tide_nix_shell_bg_color 7EBAE4
        set -U tide_nix_shell_color 000000
        set -U tide_nix_shell_icon 
        set -U tide_node_bg_color 44883E
        set -U tide_node_color 000000
        set -U tide_node_icon ⬢
        set -U tide_os_bg_color 35BF5C
        set -U tide_os_color FFFFFF
        set -U tide_os_icon 
        set -U tide_php_bg_color 617CBE
        set -U tide_php_color 000000
        set -U tide_php_icon 
        set -U tide_private_mode_bg_color F1F3F4
        set -U tide_private_mode_color 000000
        set -U tide_private_mode_icon 﫸
        set -U tide_prompt_add_newline_before false
        set -U tide_prompt_color_frame_and_connection 6C6C6C
        set -U tide_prompt_color_separator_same_color 949494
        set -U tide_prompt_icon_connection ' '
        set -U tide_prompt_min_cols 34
        set -U tide_prompt_pad_items true
        set -U tide_pwd_bg_color 3465A4
        set -U tide_pwd_color_anchors E4E4E4
        set -U tide_pwd_color_dirs E4E4E4
        set -U tide_pwd_color_truncated_dirs BCBCBC
        set -U tide_pwd_icon 
        set -U tide_pwd_icon_home 
        set -U tide_pwd_icon_unwritable 
        set -U tide_pwd_markers '.bzr .citc .git .hg .node-version .python-version .ruby-version .shorten_folder_marker .svn .terraform Cargo.toml composer.json CVS go.mod package.json'
        set -U tide_right_prompt_frame_enabled false
        set -U tide_right_prompt_items 'status'  'cmd_duration'  'git'  'context'  'jobs'  'node'  'virtual_env'  'rustc'  'go'  'vi_mode'
        set -U tide_right_prompt_prefix 
        set -U tide_right_prompt_separator_diff_color 
        set -U tide_right_prompt_separator_same_color 
        set -U tide_right_prompt_suffix
        set -U tide_rustc_bg_color F74C00
        set -U tide_rustc_color 000000
        set -U tide_rustc_icon 
        set -U tide_shlvl_bg_color 808000
        set -U tide_shlvl_color 000000
        set -U tide_shlvl_icon 
        set -U tide_shlvl_threshold 1
        set -U tide_status_bg_color 2E3436
        set -U tide_status_bg_color_failure CC0000
        set -U tide_status_color 4E9A06
        set -U tide_status_color_failure FFFF00
        set -U tide_status_icon ✔
        set -U tide_status_icon_failure ✘
        set -U tide_terraform_bg_color 800080
        set -U tide_terraform_color 000000
        set -U tide_terraform_icon
        set -U tide_time_bg_color D3D7CF
        set -U tide_time_color 000000
        set -U tide_time_format
        set -U tide_toolbox_bg_color 613583
        set -U tide_toolbox_color 000000
        set -U tide_toolbox_icon ⬢
        set -U tide_vi_mode_bg_color_default 949494
        set -U tide_vi_mode_bg_color_insert 87AFAF
        set -U tide_vi_mode_bg_color_replace 87AF87
        set -U tide_vi_mode_bg_color_visual FF8700
        set -U tide_vi_mode_color_default 000000
        set -U tide_vi_mode_color_insert 000000
        set -U tide_vi_mode_color_replace 000000
        set -U tide_vi_mode_color_visual 000000
        set -U tide_vi_mode_icon_default D
        set -U tide_vi_mode_icon_insert I
        set -U tide_vi_mode_icon_replace R
        set -U tide_vi_mode_icon_visual V
        set -U tide_virtual_env_bg_color 444444
        set -U tide_virtual_env_color 00AFAF
        set -U tide_virtual_env_icon 
    '';
    };
  };
}

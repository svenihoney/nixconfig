{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      scan_timeout = 30; # default = 30
      command_timeout = 500; # default = 500
      add_newline = false; # Don't print a new line before the start of the prompt
      continuation_prompt = "[](bg:color_background_base fg:color_base_orange)[](fg:color_background_base)";
      palette = lib.mkForce "dracula"; # select the color palette to be used

      # format = let
      #   git = "$git_branch$git_commit$git_state$git_status";
      #   cloud = "$aws$gcloud$openstack";
      # in ''
      #   $username$hostname($shlvl)($cmd_duration) $fill ($nix_shell)$custom
      #   $directory(${git})(- ${cloud}) $fill $time
      #   $jobs$character
      # '';
      format = let
        left = [
          "$os"
          "[](bg:color_background_base fg:color_os)"
          "([](bg:color_foreground_dark fg:color_background_base)$shell[](bg:color_background_base fg:color_foreground_dark))"
          "([](bg:color_sudo fg:color_background_base)$sudo[](bg:color_background_base fg:color_sudo))"
          "([](bg:color_root fg:color_background_base)\${custom.root}[](bg:color_background_base fg:color_root))"
          "([](bg:color_username fg:color_background_base)\${custom.ssh_user}[](bg:color_background_base fg:color_username))"
          "([](bg:color_root fg:color_background_base)\${custom.ssh_root}[](bg:color_background_base fg:color_root))"
          "([](bg:color_hostname fg:color_background_base)\${custom.ssh_host}[](bg:color_background_base fg:color_hostname))"
          "([](bg:color_username fg:color_background_base)$username[](bg:color_background_base fg:color_username))"
          "([](bg:color_hostname fg:color_background_base)$hostname[](bg:color_background_base fg:color_hostname))"
          "(↓ Styling of the directory module is handled in the module section ↓)"
          "($directory)"
          "(↓ Cloud provider modules ↓)"
          "([](bg:color_cloud fg:color_background_base)$aws[](bg:color_background_base fg:color_cloud))"
          "([](bg:color_cloud fg:color_background_base)$azure[](bg:color_background_base fg:color_cloud))"
          "([](bg:color_cloud fg:color_background_base)$gcloud[](bg:color_background_base fg:color_cloud))"
          "([](bg:color_cloud fg:color_background_base)$openstack[](bg:color_background_base fg:color_cloud))"
          "(↑ Cloud provider modules ↑)"
          "(↓ Container modules ↓)"
          "([](bg:color_container fg:color_background_base)$kubernetes[](bg:color_background_base fg:color_container))"
          "([](bg:color_container fg:color_background_base)$docker_context[](bg:color_background_base fg:color_container))"
          "([](bg:color_container fg:color_background_base)$container[](bg:color_background_base fg:color_container))"
          "([](bg:color_container fg:color_background_base)$opa[](bg:color_background_base fg:color_container))"
          "([](bg:color_container fg:color_background_base)$pulumi[](bg:color_background_base fg:color_container))"
          "([](bg:color_container fg:color_background_base)$singularity[](bg:color_background_base fg:color_container))"
          "([](bg:color_container fg:color_background_base)$terraform[](bg:color_background_base fg:color_container))"
          "([](bg:color_container fg:color_background_base)$vagrant[](bg:color_background_base fg:color_container))"
          "(↑ Container modules ↑)"
          "(↓ Source control ↓)"
          "(↑ Source control ↑)"
          "(↓ Toolchain version modules ↓)"
          "([](bg:color_toolchain fg:color_background_base)$bun[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$c[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$cobol[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$crystal[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$daml[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$dart[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$deno[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$dotnet[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$elixir[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$elm[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$erlang[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$fennel[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$golang[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$haskell[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$haxe[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$java[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$julia[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$kotlin[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$lua[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$nim[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$nodejs[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$ocaml[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$perl[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$php[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$purescript[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$python[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$raku[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$red[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$rlang[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$ruby[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$rust[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$scala[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$swift[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$vlang[](bg:color_background_base fg:color_toolchain))"
          "([](bg:color_toolchain fg:color_background_base)$zig[](bg:color_background_base fg:color_toolchain))"
          "(↑ Toolchain version modules ↑)"
          "(↓ Package modules ↓)"
          "([](bg:color_package fg:color_background_base)$package[](bg:color_background_base fg:color_package))"
          "([](bg:color_package fg:color_background_base)$buf[](bg:color_background_base fg:color_package))"
          "([](bg:color_package fg:color_background_base)$cmake[](bg:color_background_base fg:color_package))"
          "([](bg:color_package fg:color_background_base)$conda[](bg:color_background_base fg:color_package))"
          "([](bg:color_package fg:color_background_base)$gradle[](bg:color_background_base fg:color_package))"
          "([](bg:color_package fg:color_background_base)$helm[](bg:color_background_base fg:color_package))"
          "([](bg:color_package fg:color_background_base)$meson[](bg:color_background_base fg:color_package))"
          "([](bg:color_package fg:color_background_base)$spack[](bg:color_background_base fg:color_package))"
          "(↑ Package modules ↑)"
          "([](bg:color_memory fg:color_background_base)$memory_usage[](bg:color_background_base fg:color_memory))"
          "([](bg:color_env_var fg:color_background_base)\${env_var.FIRST}[](bg:color_background_base fg:color_env_var))"
          "(↑ above input line ↑)"
          "("
          "[](bg:none fg:color_background_base)"
          "$line_break"
          ")"
          "(↓ on input line ↓)"
          "($localip)"
          "($shlvl)"
          "($jobs)"
          "($status)"
          "[](bg:none fg:color_background_base) "
        ];
      in
        lib.concatStrings left;

      right_format = let
        right = [
          "("
          "[](bg:none fg:color_background_base)"
          "($character)"
          "($cmd_duration)"
          "([](bg:color_background_base fg:color_shellix)$guix_shell[](bg:color_shellix fg:color_background_base))"
          "([](bg:color_background_base fg:color_shellix)$nix_shell[](bg:color_shellix fg:color_background_base))"
          "([](bg:color_background_base fg:color_vcsh)$vcsh[](bg:color_vcsh fg:color_background_base))"
          "([](bg:color_background_base fg:color_sourcecontrol)$fossil_branch[](bg:color_sourcecontrol fg:color_background_base))"
          "([](bg:color_background_base fg:color_sourcecontrol)$hg_branch[](bg:color_sourcecontrol fg:color_background_base))"
          "([](bg:color_background_base fg:color_sourcecontrol)$pijul_channel[](bg:color_sourcecontrol fg:color_background_base))"
          "([](bg:color_background_base fg:color_sourcecontrol)\${custom.giturl})"
          "([ ](bg:color_sourcecontrol fg:color_foreground_dark)$git_branch[](bg:color_sourcecontrol fg:color_background_base))"
          "([](bg:color_sourcecontrol fg:color_git_commit)$git_commit[](bg:color_git_commit fg:color_background_base))"
          "([](bg:color_background_base fg:color_git_status)$git_status[](bg:color_git_status fg:color_background_base))"
          "([](bg:color_background_base fg:color_git_state)$git_state[](bg:color_git_state fg:color_background_base))"
          "([](bg:color_background_base fg:color_git_metrics)$git_metrics[](bg:color_git_metrics fg:color_background_base))"
          "([](bg:color_background_base fg:color_battery)$battery[](bg:color_battery fg:color_background_base))"
          # "([](bg:color_background_base fg:color_time)$time[](bg:color_time fg:color_background_base))"
          ")"
        ];
      in
        lib.concatStrings right;

      palettes = {
        dracula = {
          color_foreground_light = "#F8F8F8";
          color_foreground_dark = "#282828";
          color_background_base = "#383838";
          color_base_orange = "#FFA200";
          color_base_red = "#AB4642";
          color_base_red_light = "#FF620D";
          color_base_green = "#A1B56C";
          color_base_yellow = "#F7CA88";
          ## General colors
          color_os = "#8be9fd"; # color_base_green
          color_os_text = "#282828"; # color_foreground_dark
          color_sudo = "#AB4642"; # color_base_red
          color_sudo_text = "#F8F8F8"; # color_foreground_light
          color_hostname = "#22AA22";
          color_username = "#1988FF";
          color_root = "#AB4642"; # color_base_red_light
          color_directory = "#6272a4";
          color_directory_read_only = "#AB4642"; # color_base_red
          color_directory_repo_before = "#8A848B";
          color_memory = "#BBBBBB";
          color_memory_text = "#282828"; # color_foreground_dark
          color_env_var = "#BBBBBB"; # color_memory
          color_env_var_text = "#282828"; # color_foreground_dark
          color_shell_level = "#464347"; # color_background_base
          color_shell_level_text = "#FFD90D"; # color_base_yellow
          color_battery = "#AB4642"; # color_base_red_light
          color_battery_text = "#F8F8F8"; # color_foreground_light
          color_time = "#AB4642"; # color_base_red_light
          color_time_text = "#F8F8F8"; # color_foreground_light
          ## Cloud provider colors
          color_cloud = "#27385D";
          color_cloud_text = "#F8F8F8"; # color_foreground_light
          ## Container colors
          color_container = "#003E80";
          color_container_text = "#F8F8F8"; # color_foreground_light
          ## Source control colors
          color_sourcecontrol = "#4d4f68";
          color_sourcecontrol_text = "#00F769"; # color_foreground_dark
          color_git_commit = "#00F769";
          color_git_metrics = "#6F6A70"; # color_directory
          color_git_metrics_added = "#C6FF1A";
          color_git_metrics_deleted = "#AB4642"; # color_base_red
          color_git_state = "#00F769"; # color_git_commit
          color_git_status = "#EBFF87";
          color_vcsh = "#282828"; # color_foreground_dark
          color_vcsh_text = "#F8F8F8"; # color_foreground_light
          ## Toolchain version colors
          color_toolchain = "#FF7500";
          color_toolchain_text = "#F8F8F8"; # color_foreground_light
          ## Package colors
          color_package = "#4d4f68"; # color_directory
          color_package_text = "#F8F8F8"; # color_foreground_light
          ## Configuration shell modules
          color_shellix = "#27385D"; # color_cloud
          color_shellix_text = "#F8F8F8"; # color_foreground_light
        };
      };
      ## Generic prompt configurations
      character = {
        # success_symbol = "[](bg:color_base_green fg:color_background_base)[](fg:color_base_green)";
        # error_symbol = "[](bg:color_base_red fg:color_background_base)[](fg:color_base_red)";
        success_symbol = "";
        error_symbol = "[](fg:color_base_red bg:color_background_base)[](bg:color_base_red fg:color_background_base)";

        vicmd_symbol = "[](bg:color_background_base fg:color_base_green)[  ](bold bg:color_base_green fg:color_foreground_dark)[](bg:color_base_green fg:color_foreground_dark)";
        vimcmd_visual_symbol = "[](bg:color_background_base fg:color_base_yellow)[  ](bold bg:color_base_yellow fg:color_foreground_dark)[](bg:color_base_yellow fg:color_foreground_dark)";
        vimcmd_replace_symbol = "[](bg:color_background_base fg:color_base_orange)[  ](bold bg:color_base_orange fg:color_foreground_dark)[](bg:color_base_orange fg:color_foreground_dark)";
        vimcmd_replace_one_symbol = "[](bg:color_background_base fg:color_base_orange)[  ](bold bg:color_base_orange fg:color_foreground_light)[](bg:color_base_orange fg:color_foreground_dark)";
        format = "$symbol";
      };

      line_break = {
        disabled = true;
      };

      os = {
        disabled = false;
        style = "bg:color_os fg:color_os_text";
        # format = "[$symbol(v$version)(  $edition)(  $codename)(  $type)]($style)";
        ## uncomment the format above for all available information and comment out the line below
        format = "[ $symbol]($style)";
        ## other variables:
        ##   name = The current operating system name
        ##   type = The current operating system type
        ##   codename = The current operating system codename, if applicable
        ##   edition = The current operating system edition, if applicable
        ##   version = The current operating system version, if applicable
      };

      os.symbols = {
        Alpaquita = " "; # nf-fa-bell
        Alpine = " "; # nf-linux-alpine
        Amazon = " "; # nf-fa-amazon
        Android = " "; # nf-dev-android
        Arch = " "; # nf-linux-archlinux
        Artix = " "; # nf-linux-artix
        CentOS = " "; # nf-linux-centos
        Debian = " "; # nf-linux-debian
        DragonFly = " "; # nf-fae-butterfly
        Emscripten = " "; # nf-fa-toggle_on
        EndeavourOS = " "; # nf-linux-endeavour
        Fedora = " "; # nf-linux-fedora
        FreeBSD = " "; # nf-linux-freebsd
        Garuda = "󰛓 "; # nf-md-feather
        Gentoo = " "; # nf-linux-gentoo
        HardenedBSD = "󰔇  "; # nf-md-tennis_ball
        Illumos = " "; # nf-linux-illumos
        Linux = " "; # nf-linux-tux
        Mabox = "󰆦  "; # nf-fa-cube
        Macos = " "; # nf-linux-apple
        Manjaro = " "; # nf-linux-manjaro
        Mariner = " "; # nf-fa-life_saver
        MidnightBSD = " "; # nf-fa-moon_o
        Mint = "󰣭  "; # nf-md-linux_mint
        NetBSD = " "; # nf-fa-flag
        NixOS = " "; # nf-linux-nixos
        OpenBSD = " "; # nf-linux-openbsd
        OpenCloudOS = " "; # nf-fa-cloud
        openEuler = "󰏒  "; # nf-md-owl
        openSUSE = " "; # nf-linux-opensuse
        OracleLinux = "󰌷  "; # nf-md-link
        Pop = " "; # nf-linux-pop_os
        Raspbian = " "; # nf-linux-raspberry_pi
        Redhat = "󱄛 "; # nf-md-redhat
        RedHatEnterprise = " "; # nf-linux-redhat
        Redox = "󰀘  "; # nf-md-orbit
        Solus = " "; # nf-linux-solus
        SUSE = " "; # nf-linux-opensuse
        Ubuntu = " "; # nf-linux-ubuntu
        Unknown = " "; # nf-fa-question_circle
        Windows = " "; # nf-fa-windows
      };

      shell = {
        disabled = false;
        bash_indicator = "\$_";
        fish_indicator = ""; # Empty string as Fish Shell is my default shell
        # fish_indicator = "⋖⋗⋖"; # if Fish Shell is not the default shell
        zsh_indicator = "%_";
        powershell_indicator = ""; # nf-seti-powershell
        ion_indicator = "(\$_)";
        elvish_indicator = "󰘧"; # nf-md-lambda
        tcsh_indicator = "󰇥 "; # nf-md-duck
        nu_indicator = "[󰥭](fg:color_base_green)"; # nf-md-greater_than
        xonsh_indicator = "🐚"; # seashell emoji
        cmd_indicator = ""; # nf-cod-terminal_cmd
        unknown_indicator = " "; # nf-fa-question_circle
        style = "bg:color_foreground_dark fg:color_foreground_light";
        format = "[$indicator]($style)";
      };

      time = {
        disabled = false;
        ## color is set to dark orange, to get ones attention for e. g. R&R time, based on the configured time_range ;)
        style = "bg:color_time fg:color_time_text";
        # use_12hr = true;
        time_format = "%H:%M";
        time_range = "20:00:00-06:00:00";
        format = "[ $time]($style)"; #  = nf-oct-clock
      };

      custom.root = {
        # disabled = true;
        description = "Only display username, if sudo or different from standard user";
        style = "bold bg:color_root fg:color_foreground_light";
        command = "echo $USER";
        when = "[[ -z \"$SSH_CONNECTION\" ]] && ([[ -n \"$SUDO_USER\" ]] || [[ \"$USER\" != \"$LOGNAME\" ]])";
        shell = ["bash" "--noprofile" "--norc"];
        format = "[$output]($style)";
      };

      custom.ssh_user = {
        # disabled = true;
        description = "Display username, if on a ssh session, but not in tmux";
        style = "bg:color_username fg:color_foreground_light";
        command = "echo $USER";
        when = "([[ -n \"$SSH_CONNECTION\" ]] && [[ -z \"$TMUX\" ]]) && ([[ \"$USER\" != \"root\" ]] && [[ -z \"$SUDO_USER\" ]] && [[ \"$USER\" == \"$LOGNAME\" ]])";
        shell = ["bash" "--noprofile" "--norc"];
        format = "[$output]($style)";
      };

      custom.ssh_root = {
        # disabled = true;
        description = "Display username on a ssh session, if different from standard user";
        style = "bold bg:color_root fg:color_foreground_light";
        command = "echo $USER";
        when = "[[ -n \"$SSH_CONNECTION\" ]] && ([[ \"$USER\" == \"root\" ]] || [[ -n \"$SUDO_USER\" ]] || [[ \"$USER\" != \"$LOGNAME\" ]])";
        shell = ["bash" "--noprofile" "--norc"];
        format = "[$output]($style)";
      };

      custom.ssh_host = {
        # disabled = true;
        description = "Display hostname if on a ssh session, but not inside a tmux session";
        style = "bold bg:color_hostname fg:color_foreground_dark";
        command = "uname -n";
        when = "[[ -n \"$SSH_CONNECTION\" ]] && [[ -z \"$TMUX\" ]]";
        shell = ["bash" "--noprofile" "--norc"];
        format = "[$output]($style)";
      };

      username = {
        disabled = true;
        # show_always = true;
        style_root = "bold bg:color_username fg:color_base_red";
        style_user = "bg:color_username fg:color_foreground_light";
        format = "[$user]($style)";
      };

      hostname = {
        disabled = true;
        style = "bg:color_hostname fg:color_foreground_light";
        ssh_symbol = "󰱠 "; # nf-md-console_network_outline
        # ssh_only = false;
        trim_at = ".";
        format = "[($ssh_symbol)$hostname]($style)";
      };

      directory = {
        # disabled = true;
        ## If you change the home_symbol, you need the change the directory.substitutions below, as well
        home_symbol = " "; # nf-seti-home
        # home_symbol = "󰮧"; # nf-md-home_variant_outline
        # home_symbol = ""; # nf-oct-home
        # home_symbol = ""; # nf-cod-home
        read_only = " "; # nf-fa-lock
        style = "italic bg:color_directory fg:color_foreground_light";
        read_only_style = "bg:color_directory_read_only fg:color_foreground_light";
        # before_repo_root_style = "italic bg:color_directory_repo_before fg:color_foreground_light";
        repo_root_style = "italic bold bg:color_directory fg:color_foreground_light";
        # truncate_to_repo = false;
        truncation_length = 3; # default = 3
        truncation_symbol = "…/"; # default = "";
        # fish_style_pwd_dir_length = 3; # default = 0
        # use_logical_path = false;
        # use_os_path_sep = false;
        format = "([ ](bg:color_directory_read_only fg:color_background_base)[$read_only]($read_only_style)[](bg:color_background_base fg:color_directory_read_only))[ ](bg:color_directory fg:color_background_base)[$path]($style)[](bg:color_background_base fg:color_directory)";
        # repo_root_format = "([ ](bg:color_directory_read_only fg:color_background_base)[$read_only]($read_only_style)[](bg:color_background_base fg:color_directory_read_only))[ ](bg:color_directory fg:color_background_base)[$path]($style)[](bg:color_background_base fg:color_directory)";
        repo_root_format = lib.concatStrings [
          "([](bg:color_directory_read_only fg:color_background_base)[$read_only]($read_only_style)[](bg:color_background_base fg:color_directory_read_only))"
          "[](bg:color_directory fg:color_background_base)"
          "[$repo_root]($repo_root_style)"
          "[$path]($style)"
          "[](bg:color_background_base fg:color_directory)"
        ];
      };

      directory.substitutions = {
        " /Documents" = "󰈚 "; # nf-md-text_box
        " /Downloads" = " "; # nf-fa-download
        " /Music" = ""; # nf-fa-music
        # " /Music" = "󰝚 "; # nf-md-music
        " /Movies" = "󰿎 "; # nf-md-movie_open
        # " /Movies" = ""; # nf-fa-video_camera
        " /Pictures" = ""; # nf-fa-image
        # " /Pictures" = "󰔉 "; # nf-md-image_filter_hdr
        " /Sources" = "󰗀"; # nf-md-xml
        # " /Sources" = ""; # nf-dev-opensource
        # " /Sources" = ""; # nf-cod-code
        # "/" = "  ";
      };

      ###  Cloud provider section
      aws = {
        # disabled = true;
        symbol = "󰸏 "; # nf-md-aws
        # symbol = " "; # nf-weather-cloud
        style = "bg:color_cloud fg:color_cloud_text";
        expiration_symbol = " ";
        force_display = true;
        format = "[$symbol$profile(\($region\))(\[$duration\])]($style)";
      };

      # aws.region_aliases = {

      #   aws.profile_aliases = {

      azure = {
        # disabled = false;
        symbol = " "; # nf-cod-azure
        # symbol = "󰠅 "; # nf-md-microsoft_azure
        style = "bg:color_cloud fg:color_cloud_text";
        format = "[$symbol($subscription)]($style)";
      };

      gcloud = {
        # disabled = true;
        symbol = "󱇶 "; # nf-md-google_cloud
        style = "bg:color_cloud fg:color_cloud_text";
        format = "[$symbol$account(@$domain)(\($region\))]($style)";
        ## other variables:
        ##   active = The active config name written in ~/.config/gcloud/active_config
        ##   project = The current GCP project
      };

      # gcloud.region_aliases = {

      #   gcloud.project_aliases = {

      openstack = {
        # disabled = true;
        symbol = " "; # nf-weather-cloud
        style = "bg:color_cloud fg:color_cloud_text";
        format = "[$symbol$cloud(\($project\))]($style)";
      };

      ###  Container section
      kubernetes = {
        disabled = false;
        symbol = "󱃾 "; # nf-md-kubernetes
        style = "bg:color_container fg:color_container_text";
        format = "[$symbol$context(\($namespace\))]($style)";
        detect_env_vars = ["KUBECONFIG"];
        ## other variables:
        ##   cluster = contains the current kubernetes cluster
        ##   user = contains the current kubernetes user
      };

      # kubernetes.context_aliases = {

      #   kubernetes.user_aliases = {

      docker_context = {
        # disabled = true;
        symbol = " "; # nf-linux-docker
        # symbol = " "; # nf-seti-docker
        style = "bg:color_container fg:color_container_text";
        # only_with_files = false;
        format = "[$symbol$context]($style)";
      };

      container = {
        # disabled = true;
        symbol = "󰏖 "; # nf-md-package_variant
        style = "bg:color_package fg:color_container_text dimmed";
        format = "[$symbol\[$name\]]($style)";
      };

      opa = {
        # disabled = true;
        symbol = "󱅧 "; # nf-md-police_badge
        # symbol = "󱢼 "; # nf-md-shield_crown
        style = "bg:color_container fg:color_container_text";
        format = "[$symbol($version)]($style)";
      };

      pulumi = {
        # disabled = true;
        symbol = " "; # nf-fa-cube
        style = "bg:color_container fg:color_container_text";
        search_upwards = true;
        # format = "[$symbol($version) ($username@)$stack]($style)";
        ## uncomment the format above to also see the version and comment out the line below
        format = "[$symbol($username@)$stack]($style)";
      };

      singularity = {
        # now Apptainer
        # disabled = true;
        symbol = "󰰣 "; # nf-md-alpha_s_circle_outline
        style = "bg:color_container fg:color_container_text";
        format = "[$symbol\[$env\]]($style)";
      };

      terraform = {
        # disabled = true;
        symbol = "󱁢 "; # nf-md-terraform
        # symbol = " "; # nf-seti-terraform
        style = "bg:color_container fg:color_container_text";
        # format = "[$symbol($version)\($workspace\)]($style)";
        ## uncomment the format above to see the version and comment out the line below
        format = "[$symbol$workspace]($style)";
      };

      vagrant = {
        # disabled = true;
        symbol = "⍱ "; # apl functional symbol down caret tilde - U+2371
        style = "bg:color_container fg:color_container_text";
        format = "[$symbol($version)]($style)";
      };

      ###  Source control section
      vcsh = {
        # disabled = true;
        symbol = "󰳏 "; # nf-md-source_repository
        style = "bg:color_vcsh fg:color_vcsh_text";
        format = "[$symbol$repo]($style)";
      };

      fossil_branch = {
        # disabled = false;
        symbol = "󰘬"; # nf-md-source_branch
        style = "bg:color_sourcecontrol fg:color_sourcecontrol_text";
        # truncation_length = 4; # default = 9223372036854775807
        # truncation_symbol = ""; # default = "…";
        format = "[$symbol$branch]($style) ";
      };

      # Mercurial
      hg_branch = {
        disabled = false;
        symbol = "󰘬"; # nf-md-source_branch
        style = "bg:color_sourcecontrol fg:color_sourcecontrol_text";
        # truncation_length = 8; # default = 9223372036854775807
        # truncation_symbol = ""; # default = "…";
        format = "[$symbol$branch]($style)";
      };

      pijul_channel = {
        # disabled = false;
        symbol = "󰘬"; # nf-md-source_branch
        style = "bg:color_sourcecontrol fg:color_sourcecontrol_text";
        # truncation_length = 4; # default = 9223372036854775807
        # truncation_symbol = ""; # default = "…";
        format = "[$symbol$channel]($style) ";
      };

      custom.giturl = {
        # disabled = true;
        description = "Display icon for remote Git server";
        command = lib.concatMapStrings (s: s + ";") [
          "GIT_REMOTE=$(command git ls-remote --get-url 2> /dev/null)"
          "if [[ \"$GIT_REMOTE\" =~ \"github\" ]]; then"
          # "# GIT_REMOTE_SYMBOL=\"\" # nf-cod-github_inverted"
          "GIT_REMOTE_SYMBOL=\"\"; # nf-fa-github"
          "elif [[ \"$GIT_REMOTE\" =~ \"gitlab\" ]]; then"
          "GIT_REMOTE_SYMBOL=\"\"; # nf-fa-gitlab"
          "elif [[ \"$GIT_REMOTE\" =~ \"bitbucket\" ]]; then"
          "GIT_REMOTE_SYMBOL=\"\"; # nf-fa-bitbucket"
          "elif [[ \"$GIT_REMOTE\" =~ \"git\" ]]; then"
          "GIT_REMOTE_SYMBOL=\"\"; # nf-fa-git_square"
          "else"
          "GIT_REMOTE_SYMBOL=\"󰊢 \"; # nf-md-git"
          # "# GIT_REMOTE_SYMBOL=\"\" # nf-fa-unlink"
          # "# GIT_REMOTE_SYMBOL=\"󰜛\" # nf-md-source_commit_local"
          "fi"
          "echo \"$GIT_REMOTE_SYMBOL \";"
        ];
        require_repo = true;
        when = true;
        shell = ["bash" "--noprofile" "--norc"];
        format = "[$output ](bg:color_sourcecontrol fg:color_sourcecontrol_text)";
      };

      git_branch = {
        # disabled = true;
        symbol = ""; # nf-oct-git_branch
        # symbol = "󰊢 "; # nf-md-git
        style = "bg:color_sourcecontrol fg:color_sourcecontrol_text";
        # always_show_remote = true;
        # truncation_length = 4; # default = 9223372036854775807
        # truncation_symbol = ""; # default = "…";
        # only_attached = true;
        # ignore_branches = ["main", "master"]
        format = "[$symbol $branch(:$remote_name)]($style)";
        ## other variables:
        ##   remote_branch = The name of the branch tracked on remote_name
      };

      git_commit = {
        # disabled = true;
        style = "bg:color_git_commit fg:color_foreground_light";
        commit_hash_length = 4; # default = 7
        # only_detached = false;
        tag_disabled = false;
        tag_symbol = "󰓹 "; # nf-md-tag
        # tag_max_candidates = 0
        format = "[ $hash $tag]($style)"; #  = nf-fa-hashtag
      };

      git_status = {
        disabled = true;
        style = "bg:color_git_status fg:color_foreground_dark";
        staged = " \${count}"; # nf-fa-check
        modified = "  \${count}"; # nf-fa-edit
        # modified = "  ${count}"; # nf-fa-pencil
        renamed = "󰗧\${count}"; # nf-md-cursor_text
        untracked = " \${count}"; # nf-fa-question
        deleted = "  \${count}"; # nf-fa-remove
        conflicted = "\${count}"; # nf-fa-flag
        stashed = "  \${count}"; # nf-fa-bank
        # stashed = "  ${count}"; # nf-fa-inbox
        up_to_date = "";
        ahead = "󰞙 \${count}"; # nf-md-arrow_expand_up
        behind = "󰞖 \${count}"; # nf-md-arrow_expand_down
        diverged = "󰡏 \${ahead_count} \${behind_count}"; # nf-md-arrow_expand_vertical
        # diverged = "󰯎 ${ahead_count} ${behind_count}"; # nf-md-swap_vertical_bold
        # ignore_submodules = true;
        format = "[($staged$modified$renamed$untracked$deleted$conflicted$stashed$ahead_behind )]($style)";
      };

      git_state = {
        # disabled = true;
        style = "bg:color_git_state fg:color_foreground_dark";
        rebase = "rebasing";
        merge = "merging";
        revert = "reverting";
        cherry_pick = " picking"; # nf-fae-cherry
        bisect = "bisecting";
        am = "am'ing";
        am_or_rebase = "am/rebase";
        format = "[$state($progress_current/$progress_total)]($style)";
      };

      git_metrics = {
        disabled = true;
        added_style = "bg:color_git_metrics fg:color_foreground_light";
        deleted_style = "bg:color_git_metrics fg:color_foreground_light";
        # only_nonzero_diffs = false;
        # format = "([󰺪 $added]($added_style))([ 󰺨 $deleted]($deleted_style))"; # 󰺪 = nf-md-text_box_plus // 󰺨 = nf-md-text_box_minus
        format = "([󰺪 ](bg:color_git_metrics fg:color_git_metrics_added)[$added]($added_style))([ 󰺨 ](bg:color_git_metrics fg:color_git_metrics_deleted)[$deleted]($deleted_style))"; # 󰺪 = nf-md-text_box_plus // 󰺨 = nf-md-text_box_minus
      };

      ###  Toolchain version section
      bun = {
        # disabled = true;
        symbol = " "; # nf-oct-smiley
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      c = {
        # disabled = true;
        symbol = " "; # nf-custom-c
        # symbol = "󰙱 "; # nf-md-language_c
        # symbol = "C "; # plain character
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version(-$name))]($style)";
      };

      cobol = {
        # disabled = true;
        symbol = " "; # nf-fa-cog
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      crystal = {
        # disabled = true;
        symbol = " "; # nf-custom-crystal
        # symbol = "󰬯"; # nf-md-crystal_ball
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      daml = {
        # disabled = true;
        symbol = "𝜦 "; # Capital lambda - U+1D726
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      dart = {
        # disabled = true;
        symbol = " "; # nf-dev-dart
        # symbol = " "; # nf-seti-dart
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      deno = {
        # disabled = true;
        symbol = " "; # nf-dev-javascript_badge
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      dotnet = {
        # disabled = true;
        symbol = " "; # nf-dev-dotnet
        style = "bg:color_toolchain fg:color_toolchain_text";
        heuristic = true;
        format = "[$symbol($version)( 󰓾 $tfm)]($style)"; # 󰓾 = nf-md-target
      };

      elixir = {
        # disabled = true;
        symbol = " "; # nf-custom-elixir
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version) (\(OTP:$otp_version\))]($style)";
      };

      elm = {
        # disabled = true;
        symbol = " "; # nf-custom-elm
        # symbol = " "; # nf-fae-tree
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      erlang = {
        # disabled = true;
        symbol = " "; # nf-dev-erlang
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      fennel = {
        # disabled = false;
        symbol = "󰬍 "; # nf-md-alpha_f_box
        # symbol = " "; # nf-fa-smile_o
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      golang = {
        # disabled = true;
        symbol = " "; # nf-seti-go
        # symbol = "󰟓 "; # nf-md-language_go
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      haskell = {
        # disabled = true;
        symbol = " "; # nf-seti-haskell
        # symbol = "[λ](bold bg:color_toolchain fg:color_toolchain_text)"; # Small greek lambda - U+03BB
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
        ## other variables:
        ##   snapshot = Currently selected Stack snapshot
        ##   ghc_version = Currently installed GHC version
      };

      haxe = {
        # disabled = true;
        symbol = " "; # nf-seti-haxe
        # symbol = "󰐴 "; # nf-md-quadcopter
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      java = {
        # disabled = true;
        symbol = " "; # nf-fae-java
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      julia = {
        # disabled = true;
        symbol = " "; # nf-seti-julia
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      kotlin = {
        # disabled = true;
        symbol = "󱈙 "; # nf-md-language_kotlin
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      lua = {
        # disabled = true;
        symbol = "󰢱 "; # nf-md-language_lua
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      nim = {
        # disabled = true;
        symbol = ""; # nf-seti-nim
        # symbol = " "; # nf-fae-crown
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      nodejs = {
        # disabled = true;
        symbol = "󰎙 "; # nf-md-nodejs
        style = "bg:color_toolchain fg:color_toolchain_text";
        not_capable_style = "bg:color_toolchain fg:color_foreground_dark";
        format = "[$symbol($version)]($style)";
      };

      ocaml = {
        # disabled = true;
        symbol = " "; # nf-seti-ocaml
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)( \($switch_indicator$switch_name\))]($style)";
      };

      perl = {
        # disabled = true;
        symbol = ""; # nf-seti-perl
        # symbol = " "; # nf-dev-perl
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      php = {
        # disabled = true;
        symbol = " "; # nf-dev-php
        # symbol = "󰌟 "; # nf-md-language_php
        # symbol = ""; # nf-seti-php
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      purescript = {
        # disabled = true;
        symbol = ""; # nf-custom-purescript
        # symbol = "⇔ "; # left right double arrow - U+21D4
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      python = {
        # disabled = true;
        symbol = "󰌠 "; # nf-md-language_python
        # symbol = " "; # nf-fae-python
        style = "bg:color_toolchain fg:color_toolchain_text";
        python_binary = ["python3" "python" "python2"];
        # pyenv_version_name = true;
        # pyenv_prefix = "pyenv "; # default
        format = "[\${symbol}(\${pyenv_prefix}\${version})(\($virtualenv\))]($style)";
      };

      raku = {
        # disabled = true;
        symbol = " "; # nf-fae-butterfly
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)(-$vm_version)]($style)";
      };

      red = {
        # disabled = true;
        symbol = "󱥒 "; # nf-md-pyramid
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      rlang = {
        # disabled = true;
        symbol = "󰟔 "; # nf-md-language_r
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      ruby = {
        # disabled = true;
        symbol = "󰴭 "; # nf-md-language_ruby
        # symbol = " "; # nf-fae-ruby
        # symbol = " "; # nf-oct-ruby
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      rust = {
        # disabled = true;
        symbol = "󱘗 "; # nf-md-language_rust
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      scala = {
        # disabled = true;
        symbol = " "; # nf-dev-scala
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      swift = {
        # disabled = true;
        symbol = "󰛥 "; # nf-md-language_swift
        # symbol = ""; # nf-seti-swift
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      vlang = {
        # disabled = true;
        symbol = "󱑹 "; # nf-md-cosine_wave
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      zig = {
        # disabled = true;
        symbol = ""; # nf-seti-zig
        # symbol = "\[Z\] ";
        style = "bg:color_toolchain fg:color_toolchain_text";
        format = "[$symbol($version)]($style)";
      };

      ###  Package section
      package = {
        # disabled = true;
        symbol = " "; # nf-oct-package
        style = "bg:color_package fg:color_package_text";
        display_private = true;
        format = "[$symbol($version)]($style)";
      };
      buf = {
        # disabled = true;
        symbol = " "; # nf-fa-barcode
        style = "bg:color_package fg:color_package_text";
        format = "[$symbol($version)]($style)";
      };
      cmake = {
        # disabled = true;
        symbol = "󰔷 "; # nf-md-triangle_outline
        # symbol = "󰔶 "; # nf-md-triangle
        style = "bg:color_package fg:color_package_text";
        format = "[$symbol($version)]($style)";
      };
      conda = {
        # disabled = true;
        # symbol = " "; # nf-fa-circle_o
        symbol = "🅒 "; # Negative Circled Latin Capital Letter C
        style = "bg:color_package fg:color_package_text";
        # ignore_base = false;
        # truncation_length = 0; # no truncation
        format = "[$symbol$environment]($style)";
      };
      gradle = {
        # disabled = true;
        symbol = " "; # nf-seti-gradle
        # symbol = "󰟆 "; # nf-md-elephant
        style = "bg:color_package fg:color_package_text";
        # recursive = true;
        format = "[$symbol($version)]($style)";
      };
      helm = {
        # disabled = true;
        symbol = "󰠳 "; # nf-md-ship_wheel
        style = "bg:color_package fg:color_package_text";
        format = "[$symbol($version)]($style)";
      };
      meson = {
        # disabled = true;
        symbol = "󰔶 "; # nf-md-triangle
        # symbol = "▲"; # black up-pointing triangle
        style = "bg:color_package fg:color_package_text";
        # truncation_length = 20; # default = 4294967295
        # truncation_symbol = ""; # default = "…";
        format = "[$symbol$project]($style)";
      };
      spack = {
        # disabled = true;
        symbol = "󰦻 "; # nf-md-arrow_decision
        style = "bg:color_package fg:color_package_text";
        # truncation_length = 0; # default = 1
        format = "[$symbol$environment]($style)";
      };

      ###  Information section 1
      memory_usage = {
        # disabled = false;
        symbol = "󰍛 "; # nf-md-memory
        style = "bg:color_memory fg:color_memory_text";
        # threshold = 75; # default
        format = "[$symbol$ram(:$swap)]($style)";
        ## other variables:
        ##   ram_pct = The percentage of the current system memory
        ##   swap_pct = The swap memory percentage of the current system swap memory file
      };

      env_var.FIRST = {
        ## change to your likings
        disabled = true;
        symbol = ""; # nf-fa-dollar
        style = "bg:color_env_var fg:color_env_var_text";
        variable = "STARSHIP_CONFIG";
        default = " 󱃓 "; # shows if not defined - nf-md-circle_off_outline
        format = "[$symbol$env_value]($style)";
      };

      battery = {
        disabled = true;
        full_symbol = "󰁹 "; # nf-md-battery
        charging_symbol = "󱊥 "; # nf-md-battery_charging_medium
        discharging_symbol = "󱊡 "; # nf-md-battery_low
        unknown_symbol = "󰂑 "; # nf-md-battery_unknown
        empty_symbol = "󰂎 "; # nf-md-battery_outline
        format = "[$symbol$percentage]($style)";
        display = {
          # [[battery.display]]; # uncomment this section to always see your battery information
          # threshold = 100
          # style = "bg:color_battery fg:color_battery_text";
        };
      };

      ###  Configuration shell section
      guix_shell = {
        # disabled = true;
        symbol = " "; # nf-linux-gnu_guix
        # symbol = "󰆚 "; # nf-md-cow
        style = "bg:color_shellix fg:color_shellix_text";
        format = "[$symbol]($style)[shell]($style)";
      };

      nix_shell = {
        # disabled = true;
        symbol = " "; # nf-linux-nixos
        style = "bg:color_shellix fg:color_shellix_text";
        impure_msg = "[](bg:color_shellix fg:color_base_red_light)"; # nf-weather-gale_warning - personal setting
        pure_msg = "[ ](bg:color_shellix fg:color_base_green)"; # nf-weather-day_sunny - personal setting
        # impure_msg = "[\(impure\)](bg:color_shellix fg:color_base_red_light)";
        # pure_msg = "[\(pure\)](bg:color_shellix fg:color_base_green)";
        unknown_msg = "[ ](bg:color_shellix fg:color_base_red)"; # nf-weather-na
        # heuristic = true;
        format = "[$symbol$name]($style)[\($state\)](bg:color_shellix fg:color_directory_repo_before)";
      };

      ###  Information section 2
      localip = {
        disabled = true;
        style = "bg:color_background_base fg:color_base_orange";
        # ssh_only = false;
        format = "[ 󰩠 $localipv4]($style)"; # 󰩠 = nf-md-ip_network
      };

      cmd_duration = {
        disabled = false;
        style = "bg:color_background_base fg:color_base_yellow";
        show_milliseconds = true;
        # show_notifications = true;
        # notification_timeout = 60000
        format = "[ 󰔛 $duration]($style)";
      };

      shlvl = {
        disabled = false;
        symbol = " "; # nf-fa-level_up
        style = "bold bg:color_shell_level fg:color_shell_level_text";
        # repeat = true;
        # threshold = 3; # default = 2
        format = "[$symbol$shlvl]($style)";
      };

      jobs = {
        # disabled = true;
        symbol = "  "; # nf-fa-list
        style = "bold bg:color_background_base fg:color_base_orange";
        # symbol_threshold = 1; # default
        # number_threshold = 2; # default
        format = "[$symbol$number]($style)";
      };

      sudo = {
        disabled = true;
        symbol = " 󱫖 "; # nf-md-timer_lock_open_outline
        style = "bg:color_sudo fg:color_sudo_text";
        # allow_windows = true;
        format = "[$symbol]($style)";
      };

      status = {
        # disabled = false;
        symbol = ""; # nf-fa-exclamation
        success_symbol = "";
        not_executable_symbol = " "; # nf-fa-times_circle
        not_found_symbol = " "; # nf-fa-question_circle
        sigint_symbol = " "; # nf-fa-stop_circle
        signal_symbol = "󰉁 "; # nf-md-flash
        style = "bg:color_background_base fg:color_base_red";
        map_symbol = true;
        # recognize_signal_code = false;
        # pipestatus = true;
        pipestatus_separator = "|";
        pipestatus_format = "\[$pipestatus\] => [$symbol$common_meaning$signal_name$maybe_int]($style)";
        format = "[$symbol$status ]($style)";
      };

      fill = {
        # disabled = true;
        symbol = " ";
        # symbol = ""; # nf-cod-dash
        # symbol = ""; # nf-oct-dash
        # symbol = "━"; # box drawings heavy horizontal
        style = "none";
        # style = "fg:color_background_base";
      };

      #     fill = {
      #       symbol = " ";
      #       disabled = false;
      #     };

      #     # Core
      #     username = {
      #       format = "[$user]($style)";
      #       show_always = true;
      #     };
      #     hostname = {
      #       format = "[@$hostname]($style) ";
      #       ssh_only = false;
      #       style = "bold green";
      #     };
      #     shlvl = {
      #       format = "[$shlvl]($style) ";
      #       style = "bold cyan";
      #       threshold = 2;
      #       repeat = true;
      #       disabled = false;
      #     };
      #     cmd_duration = {
      #       format = "took [$duration]($style) ";
      #     };

      #     directory = {
      #       format = "[$path]($style)( [$read_only]($read_only_style)) ";
      #     };
      #     nix_shell = {
      #       format = "[($name \\(develop\\) <- )$symbol]($style) ";
      #       impure_msg = "";
      #       symbol = " ";
      #       style = "bold red";
      #     };
      #     custom = {
      #       nix_inspect = let
      #         excluded = [
      #           "kitty"
      #           "imagemagick"
      #           "ncurses"
      #           "user-environment"
      #           "pciutils"
      #           "binutils-wrapper"
      #         ];
      #       in {
      #         disabled = false;
      #         when = "test -z $IN_NIX_SHELL";
      #         command = "${(lib.getExe pkgs.nix-inspect)} ${(lib.concatStringsSep " " excluded)}";
      #         format = "[($output <- )$symbol]($style) ";
      #         symbol = " ";
      #         style = "bold blue";
      #       };
      #     };

      #     character = {
      #       error_symbol = "[~~>](bold red)";
      #       success_symbol = "[->>](bold green)";
      #       vimcmd_symbol = "[<<-](bold yellow)";
      #       vimcmd_visual_symbol = "[<<-](bold cyan)";
      #       vimcmd_replace_symbol = "[<<-](bold purple)";
      #       vimcmd_replace_one_symbol = "[<<-](bold purple)";
      #     };

      #     time = {
      #       format = "\\\[[$time]($style)\\\]";
      #       disabled = false;
      #     };

      #     # Cloud
      #     gcloud = {
      #       format = "on [$symbol$active(/$project)(\\($region\\))]($style)";
      #     };
      #     aws = {
      #       format = "on [$symbol$profile(\\($region\\))]($style)";
      #     };

      #     # Icon changes only \/
      #     aws.symbol = "  ";
      #     conda.symbol = " ";
      #     dart.symbol = " ";
      #     directory.read_only = " ";
      #     docker_context.symbol = " ";
      #     elixir.symbol = " ";
      #     elm.symbol = " ";
      #     gcloud.symbol = " ";
      #     git_branch.symbol = " ";
      #     golang.symbol = " ";
      #     hg_branch.symbol = " ";
      #     java.symbol = " ";
      #     julia.symbol = " ";
      #     memory_usage.symbol = "󰍛 ";
      #     nim.symbol = "󰆥 ";
      #     nodejs.symbol = " ";
      #     package.symbol = "󰏗 ";
      #     perl.symbol = " ";
      #     php.symbol = " ";
      #     python.symbol = " ";
      #     ruby.symbol = " ";
      #     rust.symbol = " ";
      #     scala.symbol = " ";
      #     shlvl.symbol = "";
      #     swift.symbol = "󰛥 ";
      #     terraform.symbol = "󱁢";
      #   };
      # };
    };
  };
}

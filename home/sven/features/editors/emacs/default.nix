{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # programs = {
  #   emacs = {
  #     enable = true;
  #     package = lib.mkDefault pkgs.emacs29-pgtk;
  #   };

  #   # doom-emacs = rec {
  #   #   enable = false;
  #   #   emacsPackage = pkgs.emacsNativeComp;

  #   #   doomPrivateDir = ./doom.d;
  #   #   # Only init/packages so we only rebuild when those change.
  #   #   doomPackageDir = pkgs.linkFarm "my-doom-packages" [
  #   #     # straight needs a (possibly empty) `config.el` file to build
  #   #     {
  #   #       name = "config.el";
  #   #       path = pkgs.emptyFile;
  #   #     }
  #   #     {
  #   #       name = "init.el";
  #   #       path = ./doom.d/init.el;
  #   #     }
  #   #     {
  #   #       name = "packages.el";
  #   #       path = pkgs.writeText "packages.el" ''
  #   #         (package! zeal-at-point)

  #   #         ;; The following is from https://tecosaur.github.io/emacs-config/config.html
  #   #         ;;(package! vlf :recipe (:host github :repo "m00natic/vlfi" :files ("*.el")) :pin "cc02f25337...")

  #   #         ;; (package! fira-code-mode :recipe (:host github :repo "jming422/fira-code-mode"))

  #   #         (package! robot-mode :recipe (:host github :repo "jstvz/robot-mode"))

  #   #         ;; (package! company-tabnine :recipe (:host github :repo "TommyX12/company-tabnine"))

  #   #         (package! fish-mode)

  #   #         ;; Live preview of HTML/Markdown files
  #   #         (package! impatient-mode)

  #   #         (package! adoc-mode)
  #   #         (package! just-mode)
  #   #       '';
  #   #     }
  #   #     # { name = "modules"; path = ./my-doom-module; }
  #   #   ];

  #   # };
  # };
  # # Until the doom emacs override is more or less up-to-date again
  # home.file.".doom.d" = {source = ./doom.d;};

  # Dependencies
  home.packages = with pkgs; [
    # Dash docs
    sqlite
    # Emacs vterm
    # libtool
    # libvterm
  ];

  imports = [
    inputs.nix-doom-emacs-unstraightened.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    emacs = pkgs.emacs30-pgtk;
    doomDir = ./doom.d;
    experimentalFetchTree = true; # Disable if there are fetcher issues
    extraPackages = epkgs:
      with epkgs; [
        vterm
        # treesit-grammars.with-all-grammars
      ];
  };

  # services = {
  #   emacs = {
  #     enable = true;
  #     client.enable = true;
  #     socketActivation.enable = true;
  #     package = lib.mkForce config.programs.doom-emacs.finalEmacsPackage;
  #   };
  # };
  programs.fish.shellAbbrs.ec = "emacsclient -t";

  wayland.windowManager.hyprland = {
    settings = {
      bind =
        [
          "SUPER, F4, exec, fish -c ${lib.getExe config.programs.doom-emacs.finalEmacsPackage}"
        ];
    };
  };
}

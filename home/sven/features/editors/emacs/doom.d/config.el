;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Sven Fischer"
      user-mail-address "sven@leiderfischer.de")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "JetBrainsMonoNerdFont" :size 10))
;; (setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 10))
;; (setq doom-big-font (font-spec :family "FuraCode Nerd Font Mono" :size 20))
;;(setq doom-variable-pitch-font (font-spec :family "Overpass" :size 10))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)
;; (setq doom-theme 'base16-stylix)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


(setq-default
 tab-width 4                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t                               ; Stretch cursor to the glyph width
 )

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t            ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…"               ; Unicode ellispis are nicer than "...", and also save /precious/ space
      +default-want-RET-continue-comments nil
      +evil-want-o/O-to-continue-comments nil
      )

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! tramp
  (setq tramp-sh-extra-args '(("/zsh\\'" . "-norc -noprofile")("/bash\\'" . "-norc -noprofile")))
  )

(setq confirm-kill-emacs 'nil)
(setq-default indent-tabs-mode nil)

;; Disable smartparens
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Widen up rg output to 160 chars
(setq counsel-grep-base-command "rg -i -M 160 --no-heading --line-number --color never '%s' %s")

;; The following is from https://tecosaur.github.io/emacs-config/config.html

;; Very large files
(use-package! vlf-setup
  :defer-incrementally vlf-tune vlf-base vlf-write vlf-search vlf-occur vlf-follow vlf-ediff vlf
  )

;; Company
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-quick-access t))

(after! magit
  (setq git-commit-summary-max-length 72)
  )
;; Magit force
;;(after! forge
  ;;(setcdr (last forge-alist) '(("git.deutaeit.de" "git.deutaeit.de/api/v4" "git.deutaeit.de" forge-gitlab-repository)))
  ;;(setq auth-sources '("secrets:keepassx"))
  ;;)


(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

(after! evil
  (evil-escape-mode nil)
  ;; (defalias #'forward-evil-word #'forward-evil-symbol)
  (setq-default evil-symbol-word-search t)
  )

(add-hook! (gfm-mode markdown-mode) #'mixed-pitch-mode)

;; #################### VERTICO

(after! vertico
  (setq vertico-grid-min-columns 1)
  ;; (setq vertico-multiform-commands
  ;;       '((grep buffer grid))
  ;;       )
  ;; (setq vertico-multiform-categories
  ;;        '((grep buffer grid)
  ;;          (imenu (:not indexed mouse))
  ;;          (symbol (vertico-sort-function . vertico-sort-alpha))))
  (setq vertico-multiform-categories
      '((consult-grep grid)))
  (map! :map vertico-map
        [backspace] #'delete-backward-char)
        ;; [?\t] #'minibuffer-complete)
  (vertico-multiform-mode)
  )

;; #################### PROGRAMMING

(map! [f7] 'recompile
      [S-f7] 'compile
      [f8] 'next-error
      :nv "K"   #'zeal-at-point
      [S-right] 'next-buffer
      [S-left] 'previous-buffer
      )

(define-key! [remap compile] nil)

(set-popup-rule! "^\\*Compilation" :side (if (> (frame-width) 300) 'right 'bottom) :width 150)
;; Wrap lines in compilation buffer
(add-hook 'compilation-mode-hook #'visual-line-mode)

(after! flycheck
  (setq flycheck-standard-error-navigation nil)
  )

;; #################### PROGRAMMING / C++
(after! cc-mode
  (c-add-style "svenihoney"
               '("linux"
                 (c-basic-offset . 4)
                 ))
  (add-to-list 'c-default-style '(other . "svenihoney"))
  )

(set-docsets! 'c++-mode :add "Qt_5")

(after! zeal-at-point
  (add-to-list 'zeal-at-point-mode-alist '(c++-mode . ("cpp" "qt")))
  )

;; #################### LSP
;; ccls / clangd
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--cross-file-rename"
                                "--header-insertion-decorators=0"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
(after! ccls
  (setq ccls-initialization-options '(:cache (:directory "~/.ccls-cache")))
  (set-lsp-priority! 'ccls 0))

(setq lsp-enable-file-watchers t)
(setq lsp-file-watch-threshold 50000)

(after! lsp-mode
  (require 'dap-cpptools)
  )

(after! dap-mode
  (setq dap-python-debugger 'debugpy)
  )
  ;; (defun dap-python--pyenv-executable-find (command)
  ;;   (with-venv (executable-find "python")))
  ;;   )

;; NIX
(set-formatter! 'alejandra '("alejandra" "--quiet") :modes '(nix-mode))

(after! apheleia
  (push '(alejandra . ("alejandra" "-")) apheleia-formatters)
  (setf (alist-get 'nix apheleia-mode-alist) 'alejandra))

;; QML
(defun my-qml-setup ()
  "Correct QML comments"
  (setq comment-start "// ")
  (setq comment-end "")
  )
(add-hook 'qml-mode-hook 'my-qml-setup)
(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration
    '(qml-mode . "qml"))

  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection "/home/sven/DEUTA/Qt/6.3.1/gcc_64/bin/qmlls")
                     :activation-fn (lsp-activate-on "qml")
                     :server-id 'qmlls))
  )

;; #################### PROGRAMMING / Rust

(after! rustic
  (map! :map rustic-mode-map
        ;; [f7] 'rustic-recompile
        [f7] (lambda () (interactive) (projectile-save-project-buffers) (rustic-recompile))
        [S-f7] 'rustic-compile
        [f6] 'rustic-cargo-run
        )
  )

;; #################### XML

(after! lsp-mode
(setq lsp-xml-catalogs [
                        "/home/sven/DEUTA/msgdb/deutamessagedatabase/catalog.xml"
                        "/home/sven/DEUTA/qhitachi/modules/qdmi/messagedb/msgdb2cpp-customize.xsd"
                        ])
)
(after! nxml-mode
  (setq nxml-child-indent 4)
)

;; #################### org -> koma -> letter

(after! ox
  '(require 'ox-koma-letter))

(after! ox-koma-letter
  '(progn
     (add-to-list 'org-latex-classes
                  '("svenbrief"
                    "\\documentclass\{scrlttr2\}
     \\usepackage[english]{babel}
     \\setkomavar{frombank}{(1234)\\,567\\,890}
     \[DEFAULT-PACKAGES]
     \[PACKAGES]
     \[EXTRA]"))

     (setq org-koma-letter-default-class "svenbrief")))

(after! ox-latex
  '(add-to-list 'org-latex-packages-alist '("AUTO" "babel" t) t))

;; #################### DIVERSE MODES

(setq shfmt-arguments "-i 4 -ci")

(use-package! robot-mode)

;; deft
(after! deft
  (setq deft-directory "~/cloud/joplin"
        deft-default-extension "md"
        deft-extensions '("txt" "md" "org")
        deft-recursive t)
  )

(after! impatient-mode
  (defun markdown-html (buffer)
    (princ (with-current-buffer buffer
      (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
    (current-buffer)))
  )

;; Shell recommendation from doom doctor
(setq shell-file-name (executable-find "bash"))

(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))

;; (if (string= "wayland" (getenv "XDG_SESSION_TYPE"))
;;     (progn
;;       (setq wl-copy-process nil)
;;       (defun wl-copy (text)
;;         (setq wl-copy-process (make-process :name "wl-copy"
;;                                             :buffer nil
;;                                             :command '("wl-copy" "-f" "-n")
;;                                             :connection-type 'pipe))
;;         (process-send-string wl-copy-process text)
;;         (process-send-eof wl-copy-process))
;;       (defun wl-paste ()
;;         (if (and wl-copy-process (process-live-p wl-copy-process))
;;             nil ; should return nil if we're the current paste owner
;;           (shell-command-to-string "wl-paste -n | tr -d '\r'")
;;           ))
;;       (setq interprogram-cut-function #'wl-copy)
;;       (setq interprogram-paste-function #'wl-paste))
;;   )


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
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 10))
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
(setq lsp-clangd-binary-path "/home/sven/.nix-profile/bin/clangd")
(setq lsp-clients-clangd-args '("--background-index"
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

;; (after! lsp-mode
;;   (require 'dap-cpptools)
;;   )

(after! dap-mode
  (setq dap-python-debugger 'debugpy)
  )
;; (defun dap-python--pyenv-executable-find (command)
;;   (with-venv (executable-find "python")))
;;   )
;; (after! lsp-pyright
;;   (setq lsp-pyright-langserver-command-args '("--stdio")
;;         lsp-pyright-python-executable-cmd "python3"))

;; ;; Basedpyright als Command setzen
;; (setq lsp-pyright-server-command '("basedpyright-langserver" "--stdio"))

;; (after! lsp-mode
;;   (lsp-register-client
;;    (make-lsp-client
;;     :new-connection (lsp-stdio-connection '("basedpyright-langserver" "--stdio"))
;;     :activation-fn (lsp-activate-on "python")
;;     :server-id 'basedpyright
;;     :priority 1))) ; Höhere Priorität als pyright

;; ;; Basedpyright als Standard für Python setzen
;; (after! python
;;   (setq lsp-disabled-clients '(pyright pylsp ruff))
;;   (add-hook 'python-mode-hook
;;             (lambda () (setq lsp-enabled-clients '(basedpyright)))))

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

;; deft
(setq deft-directory "~/cloud/Notizen")
(after! deft
  (setq deft-default-extension "md"
        deft-extensions '("txt" "md" "org")
        deft-recursive t)
  )

;; (after! impatient-mode
;;   (defun markdown-html (buffer)
;;     (princ (with-current-buffer buffer
;;              (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
;;            (current-buffer)))
;;   )

;; Shell recommendation from doom doctor
(setq shell-file-name (executable-find "bash"))

(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))

;; (use-package! ellama
;;   :defer
;;   :config
;;   (setopt ellama-keymap-prefix "C-c e")  ;; keymap for all ellama functions
;;   (setopt ellama-language "English")     ;; language ellama should translate to
;;   (require 'llm-ollama)
;;   (setopt ellama-provider
;;           (make-llm-ollama
;;            ;; this model should be pulled to use it
;;            ;; value should be the same as you print in terminal during pull
;;            :chat-model "llama3.2"
;;            :embedding-model "nomic-embed-text"
;;            :default-chat-non-standard-params '(("num_ctx" . 8192))))
;;   ;; Predefined llm providers for interactive switching.
;;   (setopt ellama-providers
;;           '(
;;             ("llama3.2" . (make-llm-ollama
;;                            :chat-model "llama3.2"
;;                            :embedding-model "llama3.2"))
;;             ("mixtral" . (make-llm-ollama
;;                           :chat-model "mixtral"
;;                           :embedding-model "mixtral"))))
;;   (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
;;   ;; Translation llm provider
;;   (setopt ellama-translation-provider (make-llm-ollama
;;                                        :chat-model "mixtral"
;;                                        :embedding-model "nomic-embed-text"))

;;   (setq
;;    ellama-sessions-directory "~/.config/emacs/ellama-sessions/"
;;    ellama-sessions-auto-save nil)
;;   )

(use-package! secrets
  :config
  (secrets-open-session)
  )

(use-package! gptel
  :config
  (setq gptel-default-mode 'org-mode
        gptel-post-response-functions #'gptel-end-of-response
        gptel-expert-commands t)
  (setq gptel-backend
        (gptel-make-ollama "Ollama"
          :host "localhost:11434"
          :stream t
          :models '(deepseek-coder-v2
                    qwen2.5-coder
                    deepseek-r1:7b))
        )
  (gptel-make-gemini "Gemini" :key (secrets-get-secret "keepassx" "Gemini API key") :stream t :models
                     '(gemini-2.5-flash-lite-preview-06-17))
  (gptel-make-gh-copilot "Copilot")
  )

;; (use-package! gptel
;;   :defer
;;   :config
;;   (setq gptel-default-mode 'org-mode
;;         gptel-post-response-functions #'gptel-end-of-response
;;         gptel-expert-commands t)


;;   ;; ----------------------------------------------------------------------------------
;;   ;; ollama
;;   ;; ----------------------------------------------------------------------------------

;;   (setq gptel-model 'qwen2.5-coder)
;;   (setq gptel-model 'deepseek-coder)
;;   (setq gptel-model 'deepseek-r1:7b)
;;   (setq gptel-backend (gptel-make-ollama "Ollama"
;;                         :host "localhost:11434"
;;                         :stream t
;;                         :models '(qwen2.5-coder
;;                                   deepseek-coder
;;                                   deepseek-r1:7b)))

;;   )
;; :key can be a function that returns the API key.

(use-package! aidermacs
  ;; :defer
  :config
  (setenv "OLLAMA_API_BASE" "http://127.0.0.1:11434")
  :custom
  (aidermacs-use-architect-mode t)
  (aidermacs-architect-model "ollama_chat/deepseek-r1:14b")
  (aidermacs-default-model "ollama_chat/deepseek-r1:14b")
  (aidermacs-editor-model "ollama_chat/deepseek-coder-v2")
  )

(map! :leader
      (:prefix-map ("k" . "AI tools")
       :desc "Aidermacs" "a" #'aidermacs-transient-menu
       :desc "GPtel menu" "m" #'gptel-menu
       :desc "GPtel Aibo" "i" #'gptel-aibo
       :desc "GPtel Aibo send" "s" #'gptel-aibo-send
       :desc "GPtel Aibo summon" "S" #'gptel-aibo-summon
       )
      )

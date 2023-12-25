;; Create a variable to indicate where emacs's configuration is installed
(setq EMACS_DIR "~/.emacs.d/")

;; Avoid garbage collection at statup
(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)

;; All the settings and package installation is set in configuration.org
(org-babel-load-file "~/.emacs.d/emacs-configuration.org")

(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold 300000000 ; 300mb	
          gc-cons-percentage 0.1)))

;; (use-package apropospriate-theme :ensure :defer)
;; (use-package nord-theme :ensure :defer)

(use-package circadian
  :ensure t
  :config
  (setq calendar-latitude 12.922993)
  (setq calendar-longitude 80.188290)
  ;; (setq circadian-themes '((:sunrise . apropospriate-light)
  ;;                          (:sunset  . doom-palenight)))
  ;; (setq circadian-themes '((:sunrise . ef-summer)
  ;;                          (:sunset  . ef-winter)))
  (setq circadian-themes '((:sunrise . ef-maris-light)
                           (:sunset  . ef-maris-dark)))
  (circadian-setup))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#292D3E" "#ff5370" "#c3e88d" "#ffcb6b" "#82aaff" "#c792ea" "#89DDFF" "#EEFFFF"])
 '(chart-face-color-list
   '("#b52c2c" "#0fed00" "#f1e00a" "#2fafef" "#bf94fe" "#47dfea" "#702020" "#007800" "#b08940" "#1f2f8f" "#5f509f" "#00808f"))
 '(display-time-mode t)
 '(exwm-floating-border-color "#232635")
 '(fci-rule-color "#676E95")
 '(flymake-error-bitmap '(flymake-double-exclamation-mark ef-themes-mark-delete))
 '(flymake-note-bitmap '(exclamation-mark ef-themes-mark-select))
 '(flymake-warning-bitmap '(exclamation-mark ef-themes-mark-other))
 '(highlight-tail-colors ((("#383f45") . 0) (("#323e51") . 20)))
 '(ibuffer-deletion-face 'ef-themes-mark-delete)
 '(ibuffer-filter-group-name-face 'bold)
 '(ibuffer-marked-face 'ef-themes-mark-select)
 '(ibuffer-title-face 'default)
 '(jdee-db-active-breakpoint-face-colors (cons "#1c1f2b" "#c792ea"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1c1f2b" "#c3e88d"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1c1f2b" "#676E95"))
 '(objed-cursor-color "#ff5370")
 '(org-agenda-files
   '("~/Documents/org/work-june-23.org" "~/Documents/org/personal.org"))
 '(package-selected-packages
   '(add-hooks ef-themes circadian shell-maker chatgpt-shell java-imports clomacs color-theme-modern kubernetes transient-dwim wgrep-ag projectile-ripgrep ripgrep rg magit lsp-metals sbt-mode scala-mode wgrep ivy-hydra ivy-rich multi-vterm vterm helm-descbinds helm-ls-git helm helm-config counsel-projectile projectile ## lsp use-package lsp-mode auto-compile))
 '(pdf-view-midnight-colors (cons "#EEFFFF" "#292D3E"))
 '(rustic-ansi-faces
   ["#292D3E" "#ff5370" "#c3e88d" "#ffcb6b" "#82aaff" "#c792ea" "#89DDFF" "#EEFFFF"])
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#292D3E")
 '(vc-annotate-color-map
   (list
	(cons 20 "#c3e88d")
	(cons 40 "#d7de81")
	(cons 60 "#ebd476")
	(cons 80 "#ffcb6b")
	(cons 100 "#fcb66b")
	(cons 120 "#f9a16b")
	(cons 140 "#f78c6c")
	(cons 160 "#e78e96")
	(cons 180 "#d690c0")
	(cons 200 "#c792ea")
	(cons 220 "#d97dc1")
	(cons 240 "#ec6898")
	(cons 260 "#ff5370")
	(cons 280 "#d95979")
	(cons 300 "#b36082")
	(cons 320 "#8d678b")
	(cons 340 "#676E95")
	(cons 360 "#676E95")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Menlo" :foundry "nil" :slant normal :weight normal :height 140 :width normal)))))

;; Font size is set to 14
(set-frame-font "Menlo 14" nil t)

(add-hook 'vterm-mode-hook (lambda () (text-scale-decrease 1)))

;; Display time on mode
(display-time-mode 1)

;; Bind C-# to comment or uncomment
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))

(global-set-key (kbd "C-#") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-x F") 'magit-file-checkout)
(global-set-key (kbd "C-x S") 'avy-goto-char-timer)
(global-set-key (kbd "C-x T") 'treemacs)


(defalias 'yes-or-no-p 'y-or-n-p)


;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)


;; Set PYTHONPATH
(setenv "PYTHONPATH"
        (concat
         (if (getenv "PYTHONPATH") path-separator "")
         (getenv "PYTHONPATH")))


;; lsp-mode for python - code navigation
(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil  ;; Not supported by company capf, which is the recommended company backend
        lsp-pylsp-configuration-sources "flake8"
        lsp-pylsp-plugins-flake8-enabled t
        lsp-pylsp-plugins-pycodestyle-enabled nil
        lsp-pylsp-plugins-mccabe-enabled nil)
  (lsp-register-custom-settings
   '(
     ;; Disable these as they're duplicated by flake8
     ("pylsp.plugins.pycodestyle.enabled" nil t)
     ("pylsp.plugins.mccabe.enabled" nil t)
     ("pylsp.plugins.pyflakes.enabled" nil t)))
  (define-key lsp-mode-map (kbd "C-c s") lsp-command-map)
  (require 'dap-python)
  (defun dap-python--pyenv-executable-find (command)
    (executable-find "python"))

  :hook
  ((python-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration)))

(use-package pyvenv
  :commands pyvenv-activate
  :config
  (setq pyvenv-mode-line-indicator
        '(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
  (pyvenv-mode +1))

(use-package dap-mode
  :after lsp-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode)
  )

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions]
    #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references]
    #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-enable nil))



(put 'erase-buffer 'disabled nil)


;; projectile setup - project level find
(use-package projectile
  :ensure t
  :diminish
  :defer 5
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (setq projectile-cache-file "~/.emacs.d/data/projectile.cache")
  (setq projectile-known-projects-file "~/.emacs.d/data/projectile-bookmarks.eld")
  :config
  (setq projectile-enable-caching t)
  (setq projectile-globally-ignored-files (quote ("TAGS" "GPATH" "GRTAGS" "GTAGS" "ID")))
  (setq projectile-use-git-grep t)
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :disabled t
  :config
  (setq projectile-completion-system 'helm)
  (setq projectile-switch-project-action (quote helm-projectile))
  (helm-projectile-on))

(use-package helm-ag
  :disabled t
  :ensure t)

(use-package counsel-projectile
  :after (counsel projectile)
  :config
  (counsel-projectile-mode 1))

(use-package wgrep
  :ensure t)

;; imenu to access location in document
;; describe variable
;; git grep
(use-package counsel
  :ensure t
  :bind (("M-i" . counsel-imenu)
         ("C-h v". counsel-describe-variable)
         ("C-c o" . counsel-git-grep)))

(use-package winner
  :defer t)

(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (setq helm-delete-minibuffer-contents-from-point t)
    (setq helm-ff-file-name-history-use-recentf t)
    (setq helm-ff-search-library-in-sexp t)
    (setq helm-ff-skip-boring-files t)
    (setq helm-ls-git-show-abs-or-relative (quote relative))
    (setq helm-quick-update t)
    (setq helm-recentf-fuzzy-match t)
    (setq helm-M-x-fuzzy-match t)
    (setq helm-for-files-preferred-list
          (quote
           (helm-source-files-in-current-dir helm-source-recentf helm-source-bookmarks helm-source-file-cache helm-source-buffers-list helm-source-locate helm-source-ls-git))))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ;; ("C-x C-b" . helm-buffers-list)
         ;; ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x f" . counsel-recentf)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings))
  :config
  (use-package helm-ls-git
    :ensure t))
(ido-mode -1) ;; Turn off ido mode incase enabled accidentally

(use-package helm-descbinds
  :ensure t
  :bind ("C-h b" . helm-descbinds)
  :init
  (fset 'describe-bindings 'helm-descbinds)
  :config
  (require 'helm-config))

(show-paren-mode 1)

;; vterm
(use-package vterm
    :ensure t)
(use-package multi-vterm :ensure t)



;; swiper - incremental search in minibuffer
(use-package swiper
  :ensure t
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  :bind (("C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x C-b" . ivy-switch-buffer)
         ("C-x b" . ivy-switch-buffer)))


;; Ivy - code completion
(use-package ivy-rich
  :ensure t
  :config
  (setq ivy-virtual-abbreviate 'full
        ivy-rich-switch-buffer-align-virtual-buffer t
        ivy-rich-abbreviate-paths t)
  (ivy-rich-mode))
  ;; (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer))

(use-package ivy-hydra
  :ensure t)


;; scala 

(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :commands lsp
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
  :config (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals
  :after lsp-mode
  )

;; Enable nice rendering of documentation on hover
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions]
    #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references]
    #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-enable nil))

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation

(use-package yasnippet
  :disabled t
  :demand t
  :diminish yas-minor-mode
  :bind (("C-c y d" . yas-load-directory)
         ("C-c y i" . yas-insert-snippet)
         ("C-c y f" . yas-visit-snippet-file)
         ("C-c y n" . yas-new-snippet)
         ("C-c y t" . yas-tryout-snippet)
         ("C-c y l" . yas-describe-tables)
         ("C-c y g" . yas/global-mode)
         ("C-c y m" . yas/minor-mode)
         ("C-c y r" . yas-reload-all)
         ("C-c y x" . yas-expand))
  :bind (:map yas-keymap
              ("C-i" . yas-next-field-or-maybe-expand))
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :disabled t
  :after yasnippet)

;; Use the Debug Adapter Protocol for running tests and debugging
(require 'posframe)
(use-package posframe
  :disabled
  ;; Posframe is a pop-up tool that must be manually installed for dap-mode
  )
(use-package dap-mode
  :after lsp-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode)
  )
(setq dap-java-use-testng t)

;; Use the Tree View Protocol for viewing the project structure and triggering compilation
(use-package lsp-treemacs
  :after lsp-mode
  :config
  (setq lsp-metals-treeview-show-when-views-received t)
  )

(use-package chatgpt-shell
  :ensure t
  :custom
  ((chatgpt-shell-openai-key
    (lambda ()
      (auth-source-pass-get 'secret "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")))))

(setq chatgpt-shell-openai-key "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")

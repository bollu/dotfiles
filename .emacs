(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; (cua-mode)


(require 'selectrum)
(require 'selectrum-prescient)
(selectrum-mode)
(selectrum-prescient-mode)
(prescient-persist-mode +1)

(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
(setq projectile-completion-system 'default)

;; tab for completion
(setq tab-always-indent 'complete)



;; LSP stuff
(require 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.3)


(require 'lsp-mode)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)

(require 'dash) ;; library needed by lsp mode
(require 'ccls)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'cpp-mode-hook 'lsp)

;; LSP-mode
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1 ;; clangd is fast
      lsp-headerline-breadcrumb-enable t)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  ; (require 'dap-cpptools)
  (yas-global-mode))

;; evil
;; (setq evil-want-C-u-scroll t)
;; (setq evil-want-keybinding nil)
;; (require 'evil)
;; (evil-mode 1)
;; (global-set-key (kbd "C-c C-c") 'evil-normal-state)
;; (turn-on-evil-mode)
;; ;; (define-key global-map (kbd "C-x C-x") 'suspend-emacs)
;; (require 'evil-collection)
;; (evil-collection-init)

;; no startup screen
(setq inhibit-startup-screen t)

;; spin up clj by default
(setq initial-major-mode 'clojure-mode)

;; make latex only monospace font.
(setq font-latex-fontify-sectioning 'color)
(advice-add 'face-spec-set-2 :around
            (lambda (f face frame attrs)
              (funcall f face frame (plist-put attrs :height 1.0))))

;; always follow symlinks
(setq vc-follow-symlinks t)

;; color scheme

;; font for agda
(set-face-attribute 'default nil
                    :family "mononoki"
                    :height 120
                    :weight 'normal
                    :width  'normal)

;; company-mode
(global-company-mode) ;; maybe?

;;# Commented since after I switched to fish this dies.
;;# ;; agda
;;# (load-file (let ((coding-system-for-read 'utf-8))
;;#              (shell-command-to-string "agda-mode locate")))
;; https://github.com/agda/agda/issues/2837
(add-to-list 'auto-mode-alist '("\\.lagda.md\\'" . agda2-mode))

;; geiser for racket
;; (require 'smartparens)
(require 'paredit)
(require 'geiser)
(require 'smartparens-config)

;; (add-to-list 'evil-emacs-state-modes 'racket-mode)
;; (add-hook 'racket-mode-hook 'paredit-mode)
;; (add-hook 'racket-mode-hook 'company-mode)
;; (add-hook 'racket-mode-hook 'racket-xp-mode)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-o") 'other-window)

(setq clojure-indent-style 'always-indent) 
(add-hook 'clojure-mode-hook 'parinfer-rust-mode)
(add-hook 'clojure-mode-hook 'show-paren-mode)
(add-hook 'cider-repl-mode-hook 'parinfer-rust-mode)
(add-hook 'cider-repl-mode-hook 'show-paren-mode)

(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))
(add-hook 'racket-mode-hook 'parinfer-rust-mode)
(add-hook 'racket-mode-hook 'show-paren-mode)


;; org-mode: tangle right after each save.
;; (add-hook 'after-save-hook (lambda ()(org-babel-tangle)) nil t)

;; scroll to first error when using compile
(setq compilation-scroll-output 'first-error)

;; evil multi-edit
(require 'evil-multiedit)
(evil-multiedit-default-keybinds)

(require 'nasm-mode)
(add-hook 'asm-mode-hook 'nasm-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "16ab866312f1bd47d1304b303145f339eac46bbc8d655c9bfa423b957aa23cc9" "ae88c445c558b7632fc2d72b7d4b8dfb9427ac06aa82faab8d760fff8b8f243c" "77df8c957aea72f8d0f9710609163e0c957a477f95219b69a1a2b00b3f7f62ed" default))
 '(package-selected-packages
   '(spacemacs-theme ycmd x86-lookup writegood-mode which-key use-package syntax-subword smartparens selectrum-prescient racket-mode parinfer-rust-mode parinfer paredit nasm-mode molokai-theme macrostep llvm-mode lispy liso-theme leuven-theme key-chord julia-mode jedi irony intero ido-vertical-mode helm-projectile helm-ag gruvbox-theme gnu-apl-mode github-theme github-modern-theme geiser flx-isearch flx-ido flatui-theme flatui-dark-theme flatland-theme fill-column-indicator expand-region evil-multiedit evil-magit evil-collection elpy dyalog-mode dtrt-indent deft counsel-projectile company-jedi company-coq color-theme-sanityinc-solarized color-theme cider ccls badwolf-theme backward-forward auctex ag)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

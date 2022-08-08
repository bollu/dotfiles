(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)

(setq visible-bell 't)

(straight-use-package 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.1)

;; (straight-use-package 'projectile)
;; (projectile-mode 1)
;; (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)

(straight-use-package 'dash)
(straight-use-package 'f)
(straight-use-package 'flycheck)
(straight-use-package 'lsp-mode)
(straight-use-package 'magit-section)
(straight-use-package 's)
(straight-use-package 'lsp-ui)
(setq load-path (cons "/home/bollu/software/lean4-mode" load-path))
(require 'lean4-mode)
(setenv "PATH" (concat (getenv "PATH") ":/home/bollu/.elan/bin"))
(setq exec-path (append exec-path '("/home/bollu/.elan/bin")))
(setq lean4-delete-trailing-whitespace t)


(with-eval-after-load 'lsp-mode (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))
(global-set-key (kbd "C-\\") 'completion-at-point)
(global-set-key (kbd "C-c p p") 'lsp-find-definition)
(global-set-key (kbd "C-c p r") 'lsp-find-references)
(global-set-key (kbd "C-c p d") 'lsp-find-declaration)

(setq inhibit-startup-screen t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq vc-follow-symlinks t)
(setq font-latex-fontify-sectioning 'color)

(global-unset-key (kbd "C-v"))
(global-unset-key (kbd "C-x p"))
(global-unset-key (kbd "C-x C-p"))
;; goto-line
(global-set-key (kbd "C-c :") 'goto-line)
(global-set-key (kbd "C-x :") 'goto-line)
(global-set-key (kbd "C-:") 'goto-line)

(global-auto-revert-mode t) ;; auto load changed buffers on disk that don't have local unsaved data
(recentf-mode 1)
;; (straight-use-package 'rg)

;; emacs temp files
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(set-frame-font "mononoki Nerd Font 12" nil t)

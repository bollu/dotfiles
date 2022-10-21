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

(straight-use-package 'corfu)
(global-corfu-mode)
(setq visible-bell 't)

(straight-use-package 'which-key)
(which-key-mode)
(setq which-key-idle-delay 5)

(straight-use-package 'dash)
(straight-use-package 'f)
(straight-use-package 'flycheck)
(straight-use-package 'lsp-mode)
(straight-use-package 'magit-section)
(straight-use-package 's)
(straight-use-package 'lsp-ui)
(setq load-path (cons "/home/bollu/software/lean4-mode" load-path))
(require 'lean4-mode)
(add-hook 'lean4-mode-hook 'lean4-disable-final-newline-hook)
(defun lean4-disable-final-newline-hook () (setq-local require-final-newline nil))
;(setenv "PATH" concat (getenv "PATH") ":/home/bollu/.elan/bin"))
(setq exec-path (append exec-path '("/home/bollu/.elan/bin")))
(setq lean4-delete-trailing-whitespace t)

(with-eval-after-load 'lsp-mode (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))
(global-set-key (kbd "C-\\") 'completion-at-point)

(setq inhibit-startup-screen t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq vc-follow-symlinks t)
(setq font-latex-fontify-sectioning 'color)

(global-set-key (kbd "C-c :") 'goto-line)
(global-set-key (kbd "C-x :") 'goto-line)
(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "C-9") 'compile)
(global-set-key (kbd "M-n") 'next-line)
(global-set-key (kbd "M-p") 'previous-line)
(global-set-key (kbd "C-S-s") 'occur)

(straight-use-package 'iedit) ;; press `C-;` in `isearch` for multiple cursors. Use with narrow.
(require 'iedit)

(global-auto-revert-mode t) ;; auto load changed buffers on disk that don't have local unsaved data

(global-set-key (kbd "C-c C->") 'indent-rigidly-right)
(global-set-key (kbd "C-c C-<") 'indent-rigidly-left)

(straight-use-package 'clang-format+) (add-hook 'c-mode-common-hook #'clang-format+-mode)
(setq clang-format+-context 'buffer)
;; emacs temp files: store all backup and autosave files in the tmp dir
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(load-theme 'wheatgrass)
(set-frame-font "mononoki Nerd Font 8" nil t)

;; (icomplete-vertical-mode) ;; icomplete will show up vertical bar.
(straight-use-package 'magit)

(put 'narrow-to-region 'disabled nil)

;; org-mode clocking
(org-mode)
(setq org-clock-report-include-clocking-task 1)
(setq org-clock-history-length 23) ;; show lots of tasks in clock history
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-agenda-files '("~/play/phd-logbook/README.org"))

;; (defun bollu/clock-in-to-current (kw)
;;   "Switch a task from TODO to CURRENT when clocking in.
;; Skips capture tasks, projects, and subprojects.
;; Switch projects and subprojects from NEXT back to TODO"
;;   (when (not (and (boundp 'org-capture-mode) org-capture-mode))
;;     (cond
;;      ((member (org-get-todo-state) (list "TODO"))
;;       "CURRENT")
;;      ((member (org-get-todo-state) (list "CURRENT"))
;;       "TODO"))))
;; ;; Change tasks to CURRENT when clocking in. This shows the task on the agenda.
;; (setq org-clock-in-switch-to-state 'bollu/clock-in-to-current)


;;aucted
(straight-use-package 'auctex)
(require 'tex-site)

(straight-use-package 'proof-general)


;; Show lot of clocking history
;; so it's easy to pick items off the `C-c I` list
(setq org-clock-history-length 23)
(defun bollu/org-clock-in () (interactive) (org-clock-in '(4)))
(global-set-key (kbd "C-c C-o C-i") #'bollu/org-clock-in)
(global-set-key (kbd "C-c C-o C-o") #'org-clock-out)
(global-set-key (kbd "C-c C-o C-a") #'org-agenda)
(global-set-key (kbd "C-c a") (lambda () (interactive) (org-agenda nil "n")))
(global-set-key (kbd "C-c C-a") (lambda () (interactive) (org-agenda nil "n")))
(global-set-key
 (kbd "C-c C-o l")
 (lambda ()
   (interactive)
   (xref-push-marker-stack)
   (push-mark)
   (find-file (car org-agenda-files))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ))

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

;; TODO: write a new shell for yourself using comint-mode
(straight-use-package 'ctrlf)
(straight-use-package 'parinfer)
(straight-use-package 'prescient)
(straight-use-package 'selectrum)
(straight-use-package 'selectrum-prescient)
(straight-use-package 'projectile)
(straight-use-package 'magit)
(straight-use-package 'which-key)
(straight-use-package 'dash)
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)
(straight-use-package 'cider)
(straight-use-package 'exec-path-from-shell)
(straight-use-package 'auctex)


(add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
(add-hook 'clojure-mode-hook #'parinfer-mode)
(setq parinfer-auto-switch-indent-mode t) 



(load-theme 'wheatgrass)
(selectrum-mode)
(selectrum-prescient-mode)
(prescient-persist-mode +1)
(projectile-mode +1)
(ctrlf-mode +1)
(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
(setq projectile-completion-system 'default)
(setq tab-always-indent 'complete)
(which-key-mode)
(setq which-key-idle-delay 0.3)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(global-set-key (kbd "C-\\") 'completion-at-point)
(global-set-key (kbd "C-9") 'compile)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'cpp-mode-hook 'lsp)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1 ;; clangd is fast
      lsp-headerline-breadcrumb-enable t)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))
(setq inhibit-startup-screen t)
;;  (setq initial-major-mode 'clojure-mode)
;; make latex only monospace font.
(setq font-latex-fontify-sectioning 'color)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq vc-follow-symlinks t)
(set-face-attribute 'default nil
                    :family "mononoki"
                    :height 140
                    :weight 'normal
                    :width  'normal)
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-iso-lefttab>") 'previous-buffer)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-o") 'other-window)
(setq compilation-scroll-output 'first-error)
(add-to-list 'auto-mode-alist '("\\.md\\'" . text-mode))

;;auctex config
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))
(setq TeX-PDF-mode t) 

 ;; If there is more than one, they won't work right.
(setq TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Okular")
     (output-html "xdg-open")))

;; (setq-default TeX-master nil) ;; enable if we want multi file project




;; wipe all keybinds
;; (use-global-map (make-sparse-keymap))
;; (global-set-key [t] #'self-insert-command)
;; (let ((c ?\s))
;;   (while (< c ?\d)
;;     (global-set-key (vector c) #'self-insert-command)
;;     (setq c (1+ c)))
;;   (when (eq system-type 'ms-dos)
;;     (setq c 128)
;;     (while (< c 160)
;;       (global-set-key (vector c) #'self-insert-command)
;;       (setq c (1+ c))))
;;   (setq c 160)
;;   (while (< c 256)
;;     (global-set-key (vector c) #'self-insert-command)
;;     (setq c (1+ c))))
;; (global-set-key (kbd "C-x C-f") 'find-file)
;; (global-set-key (kbd "C-x C-f") 'find-file)
;; (global-set-key (kbd "ENTER") 'ret)
(custom-set-variables)
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
(custom-set-faces)
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 

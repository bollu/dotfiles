;; eshell set paths



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

(setq visible-bell 't)
(straight-use-package 'package-lint)

;; unbind EVERYTHING ===
;; unbind EVERYTHING ===
;; unbind EVERYTHING ===
;; https://emacs.stackexchange.com/questions/3870/how-to-truly-unbind-all-global-keybinds
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
;; 
;; (global-set-key [deletechar] #'backward-delete-char-untabify)
;; (global-set-key (kbd "<backspace>") #'backward-delete-char-untabify)
;; (global-set-key (kbd "M-x") #'execute-extended-command)
;; (global-set-key (kbd "C-x o") #'other-window)
;; (global-set-key (kbd "C-x 0") #'delete-window)
;; (global-set-key (kbd "C-x 1") #'delete-other-windows)
;; (global-set-key (kbd "C-x 2") #'split-window-below)
;; (global-set-key (kbd "C-x 3") #'split-window-right)
;; (global-set-key (kbd "C-x C-c") #'save-buffers-kill-terminal)
;; (global-set-key (kbd "C-x C-f") #'find-file)
;; (global-set-key (kbd "C-x C-s") #'save-buffer)
;; (global-set-key (kbd "C-g") #'keyboard-quit)
;; (global-set-key (kbd "<up>") #'previous-line)
;; (global-set-key (kbd "<down>") #'next-line)
;; (global-set-key (kbd "<left>") #'left-char)
;; (global-set-key (kbd "<right>") #'right-char)
;; (global-set-key (kbd "<return>") #'newline)
;; (global-set-key (kbd "<tab>") #'forward-button)
;; (global-set-key (kbd "C-a") #'move-beginning-of-line)
;; (global-set-key (kbd "C-e") #'move-end-of-line)
;; (global-set-key (kbd "C-k") #'kill-line)
;; (global-set-key (kbd "C-b") #'switch-buffer)
;; 
;; ;; go back/forward
;; (straight-use-package 'back-button)
;; (back-button-mode 1)
;; (global-set-key (kbd "C-<") #'back-button-global-backward)
;; (global-set-key (kbd "C->") #'back-button-global-forward)
;; (global-set-key (kbd "C-x <") #'back-button-global-backward)
;; (global-set-key (kbd "C-x C-<") #'back-button-global-backward)
;; (global-set-key (kbd "C-x >") #'back-button-global-forward)
;; (global-set-key (kbd "C-x >") #'back-button-global-forward)
;; (global-set-key (kbd "C-x C->") #'back-button-global-forward)
;; 
;; 
;; (define-key minibuffer-local-map (kbd "<tab>") #'minibuffer-complete)
;; (define-key minibuffer-local-map (kbd "<return>") #'exit-minibuffer)
;; ;; (define-key minibuffer-local-map (kbd "<return>") #'minibuffer-complete-and-exit)
;; (define-key minibuffer-local-map (kbd "C-j") #'minibuffer-complete-and-exit)
;; (define- -local-map (kbd "C-g") #'abort-recursive-edit)

;; ^^^^^


(defun bollu/backward-kill-word ()
  "Remove all whitespace if the
   character behind the cursor is whitespace, otherwise remove a word."
  (interactive)
  (if (looking-back "[ \n]")
      ;; delete horizontal space before us and then check to see if we
      ;; are looking at a newline
      (progn (delete-horizontal-space 't)
             (while (looking-back "[ \n]")
               (backward-delete-char 1)))
    ;; otherwise, just do the normal kill word.
    (backward-kill-word 1)))
(global-set-key (kbd "C-<backspace>") 'bollu/backward-kill-word)

(straight-use-package 'exec-path-from-shell)
(exec-path-from-shell-copy-env "PATH")
(defalias 'ff 'find-file) ;; nice for use within


(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))

(straight-use-package 'use-package)

;; sublime text control d
(global-set-key (kbd "C-d") 'rectangle-next-line)

;; HASKELL
(straight-use-package 'haskell-mode)
;; (add-hook ’haskell-mode-hook ’interactive-haskell-mode)

;; LONG LINES: https://emacs.stackexchange.com/questions/598/how-do-i-prevent-extremely-long-lines-making-emacs-slow
(global-so-long-mode)

;; HELP
(global-set-key [f1]   'help-command)


;; proof general
(straight-use-package 'proof-general)


;; RAINBOW DELIMITER
(straight-use-package 'rainbow-delimiters)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "slate gray"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "goldenrod"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "olive"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))



;; SLY
(straight-use-package 'slime)
(setq inferior-lisp-program "sbcl")
(setq slime-load-failed-fasl nil)
(add-hook 'lisp-mode-hook
	  (lambda () (lispy-mode)
	    (rainbow-delimiters-mode)))
(add-hook 'emacs-lisp-mode-hook
	  (lambda () (lispy-mode) (rainbow-delimiters-mode)))


;; LISPY
(straight-use-package 'lispy)
(straight-use-package 'paredit)

;; ELISP MODE
(add-hook 'elisp-mode-hook
      (lambda ()
          (lispy-mode)
          (rainbow-delimiters-mode)
          (local-set-key "C-c C-k" 'eval-buffer)
          (local-set-key "C-c C-e" 'eval-last-sexp)
          (local-set-key "C-x C-e" 'eval-last-sexp)
          (local-set-key "C-x C-k" 'eval-buffer)))



;; LEAN packages
(straight-use-package 'dash)
(straight-use-package 'flycheck)
(straight-use-package 's)
;;  enables writing into rgrep results
(straight-use-package 'wgrep)


(straight-use-package 'projectile)
(straight-use-package 'ripgrep)
(straight-use-package 'magit)
(straight-use-package 'which-key)
(straight-use-package 'dash)
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)
(straight-use-package 'auctex)


(setq clang-format-style-option "llvm")
(setq clang-format+-always-enable "llvm")

;; AGDA
 (load-file (let ((coding-system-for-read 'utf-8))
                 (shell-command-to-string "agda-mode locate 2>/dev/null")))

;; auto-load agda-mode for .agda and .lagda.md
(setq auto-mode-alist
   (append
     '(("\\.agda\\'" . agda2-mode)
       ("\\.lagda.md\\'" . agda2-mode))
     auto-mode-alist))
;; LEAN4
(setq load-path (cons "/home/bollu/work/lean4-mode" load-path))
(setq lean-rootdir "/home/bollu/work/lean4/build/stage1")
(straight-use-package 'dash)
(straight-use-package 'flycheck)
(straight-use-package 'f)
(straight-use-package 'lsp-mode)
(straight-use-package 'magit-section)
(straight-use-package 's)
(require 'lean4-mode)


(load-theme 'wombat t)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
(setq projectile-system 'default)
(setq tab-always-indent 'complete)
(which-key-mode)
(setq which-key-idle-delay 0.3)

(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

(global-set-key (kbd "C-c p p") 'lsp-find-definition)
(global-set-key (kbd "C-c p r") 'lsp-find-references)
(global-set-key (kbd "C-c p d") 'lsp-find-declaration)


(global-set-key (kbd "C-9") 'compile)
(global-set-key (kbd "C-x C-9") 'compile)
(global-set-key (kbd "C-c C-9") 'compile)
(global-set-key (kbd "C-c 9") 'compile)
(global-set-key (kbd "C-x 9") 'compile)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'cpp-mode-hook 'lsp) 

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1 ;; clangd is fast
      lsp-headerline-breadcrumb-enable t)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))


(setq inhibit-startup-screen t)
(setq font-latex-fontify-sectioning 'color)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq vc-follow-symlinks t)

(set-frame-font "mononoki Nerd Font 14" nil t)
(setq compilation-scroll-output 'first-error)
(add-to-list 'auto-mode-alist '("\\.md\\'" . text-mode))

;;auctex config
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))
(setq TeX-PDF-mode t) 
(eval-after-load "tex"
  '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular"))

;; (setq TeX-view-program-selection
;;       '(((output-dvi has-no-display-manager)))
;;    "dvi2tty"
;;   ((output-dvi style-pstricks)
;;    "dvips and gv")
;;   (output-dvi "xdvi")
;;   (output-pdf "Okular")
;;   (output-html "xdg-open"))


(global-unset-key (kbd "C-v"))
(global-unset-key (kbd "C-x p"))
(global-unset-key (kbd "C-x C-p"))


;; goto-line
(global-set-key (kbd "C-c :") 'goto-line)
(global-set-key (kbd "C-x :") 'goto-line)
(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c /") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c C-/") 'comment-or-uncomment-region)

(global-auto-revert-mode t) ;; auto load changed buffers on disk that don't have local unsaved data

;;  orderless: sorting style 
(straight-use-package 'orderless)
(setq completion-styles '(orderless))

;; vertico: better ido, overwrite completing-read
(straight-use-package 'vertico)
(vertico-mode 1)
(setq enable-recursive-minibuffers t)

;; corfu: better company, overwrite completion-at-point
(straight-use-package 'corfu)
(corfu-mode)

;;  TODO: find a way to make corfu use basic, but
;;  everyone else use orderless?
(setq corfu-auto t
      corfu-auto-delay 0
      corfu-auto-prefix 0
      completion-styles '(orderless basic))
(global-corfu-mode)
(global-set-key (kbd "C-\\") 'completion-at-point)

(straight-use-package 'swiper)
(global-set-key (kbd "C-r") 'swiper-isearch-backward)
(global-set-key (kbd "C-s") 'swiper-isearch)

(straight-use-package 'rg)

;; better UI for ripgrep that shows completions as we invoke it.
(straight-use-package 'consult)
(global-set-key (kbd "C-c C-r") 'consult-ripgrep)
(global-set-key (kbd "C-c r") 'consult-ripgrep)
(global-set-key (kbd "C-x b") 'consult-buffer)

;; select all
(global-set-key (kbd "C-x C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-c C-a") 'mark-whole-buffer)

(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(show-paren-mode 1) ;; matching parens highlight

(global-set-key (kbd "C-c g") 'magit) ;; magit: C-c g

(straight-use-package 'vterm)
(global-set-key (kbd "C-c C-c") 'vterm)

;; emacs temp files
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(defun htmlize-with-line-numbers ()
  (interactive)
  (goto-char (point-min))
  (let ((n 1))
    (while (not (eobp))
      (htmlize-make-tmp-overlay (point) (point) `(before-string ,(format "%4d " n)))
      (setq n (1+ n))
      (forward-line 1)))
  (switch-to-buffer (htmlize-buffer)))

(defun mechanics ()
  (interactive)
  (run-scheme  "mit-scheme --band /home/bollu/work/sicm/scmutils-20200810/mechanics.com --library /home/bollu/.local/lib/mit-scheme-x86-64/")
  (set-input-method 'TeX))


;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values '((eval turn-off-auto-fill))))

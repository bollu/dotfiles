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

(straight-use-package 'exec-path-from-shell)
(exec-path-from-shell-copy-env "PATH")
(defalias 'ff 'find-file) ;; nice for use within eshell

;; HASKELL
(straight-use-package 'haskell-mode)

;; LONG LINES: https://emacs.stackexchange.com/questions/598/how-do-i-prevent-extremely-long-lines-making-emacs-slow
(global-so-long-mode)

;; HELP
(global-set-key [f1]   'help-command)

;; GEISER FOR SCHEME
;; (straight-use-package 'geiser)

;; EXPAND REGION
(straight-use-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region) 
;; (global-set-key (kbd "C-c C-=") 'er/expand-region)
;; (global-set-key (kbd "C-c C--") 'er/contract-region)



;; RAINBOW DELIMITER
(straight-use-package 'rainbow-delimiters)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))


;; SBCL / COMMON LISP
;; (straight-use-package 'slime)
;; (add-hook 'slime-mode-hook
;;   (lambda ()
;;      (local-set-key (kbd "C-c C-?") 'slime-documentation-lookup)
;;      (local-set-key (kbd "C-c ?") 'slime-documentation-lookup)
;;      (local-set-key (kbd "C-\\") 'slime-fuzzy-complete-symbol)
;;      (local-set-key (kbd "C-c p") 'slime-selector)
;;      (local-set-key (kbd "C-c C-p") 'slime-selector)
;;      (local-set-key (kbd "C-c P") 'slime-selector)
;;      (local-set-key (kbd "C-c C-p") 'slime-selector)
;;      (local-set-key (kbd "C-c o") 'slime-selector)
;;      (local-set-key (kbd "C-c O") 'slime-selector)
;;      (local-set-key (kbd "C-c C-O") 'slime-selector)
;;      (local-set-key (kbd "C-c o") 'slime-selector)
;;      (local-set-key (kbd "C-c C-o") 'slime-selector)
;;      (local-set-key (kbd "C-x C-r") 'slime-eval-defun)
;;      (rainbow-delimiters-mode)
;;      (lispy-mode)))
;; (defun bollu/lispenv ()  (interactive)
;;    (unless (get-process "SLIME Lisp")
;;      (progn (lispy-mode) (slime) (slime-sync-package-and-default-directory))))
;; (setq slime-net-coding-system 'utf-8-unix)
;; (setq inferior-lisp-program "sbcl")
;; (setq initial-major-mode 'lisp-mode)

;; SLY
(straight-use-package 'sly)
(defun sly-add-keys ()
    (local-set-key (kbd "C-p") sly-selector-map))
(add-hook 'sly-mode-hook 'sly-add-keys)
(add-hook 'sly-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-x C-k") 'sly-compile-file)
	    (local-set-key (kbd "C-x k") 'sly-compile-file)))
(add-hook 'sly-mode-hook
          (lambda ()
            (unless (sly-connected-p)
              (save-excursion (sly)))))
(setq inferior-lisp-program "sbcl")


(add-hook 'lisp-mode-hook (lambda ()
			    (progn (lispy-mode)
				   (rainbow-delimiters-mode))))
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


;; TODO: write a new shell for yourself using comint-mode
(straight-use-package 'ctrlf)
(straight-use-package 'htmlize)
(straight-use-package 'almost-mono-themes)
(straight-use-package 'borland-blue-theme)

(straight-use-package 'prescient)
(straight-use-package 'selectrum)
(straight-use-package 'selectrum-prescient)
(straight-use-package 'projectile)
;; (straight-use-package 'company-mode)
(straight-use-package 'magit)
(straight-use-package 'which-key)
(straight-use-package 'dash)
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)
(straight-use-package 'cider)
(straight-use-package 'auctex)
;; (straight-use-package 'lean-mode)
(straight-use-package 'bury-successful-compilation) ;; close compile window on success
(straight-use-package 'popwin)
(straight-use-package 'monokai-theme)
(straight-use-package 'clang-format+)
(straight-use-package 'selectric-mode)
(straight-use-package 'zig-mode)

;; AGDA
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

;; CLANG
(add-hook 'c-mode-common-hook #'clang-format+-mode)


;; LEAN
(setq load-path (cons "/home/bollu/work/lean4/lean4-mode" load-path))
(require 'lean4-mode)

;; https://github.com/minad/consult
;; https://github.com/oantolin/embark/
;; https://github.com/kyagi/shell-pop-el
;; (straight-use-package 'auto-complete) ;; TODO: write custom source for completion-at-point.
;; (straight-use-package 'company-lean)

;; (add-hook 'text-mode-hook 'foo-mode bury-successful-compilation)
(straight-use-package 'undo-tree)
(global-undo-tree-mode) ;; undo-tree

;; PARINFER
;; (straight-use-package 'parinfer)
;; (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
;; (add-hook 'clojure-mode-hook #'parinfer-mode)
;; (add-hook 'lisp-mode-hook #'parinfer-mode)
;; ;; (setq parinfer-auto-switch-indent-mode t) 

;; (load-theme 'almost-mono-white t)
(load-theme 'wombat t)
;; (load-theme 'borland-blue t)
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

(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))
;; (define-key lsp-mode-map (kbd "C-x l") lsp-command-map)

(setq lsp-zig-zls-executable "/usr/bin/zls")



;; mnemonic: C-p is to find stuff. d is for definition
(global-set-key (kbd "C-c p p") 'lsp-find-definition)
(global-set-key (kbd "C-c p r") 'lsp-find-references)
(global-set-key (kbd "C-c p d") 'lsp-find-declaration)


;; rectangle selection: poor man's sublime text!
;; https://www.emacswiki.org/emacs/CuaMode
;; https://emacs.stackexchange.com/questions/16897/kill-rectangle-with-cua-mode-support
;; find-library RET cua-base for hep
(cua-mode)
(cua-selection-mode t)
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour



(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(global-set-key (kbd "C-\\") 'completion-at-point)

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
;;  (setq initial-major-mode 'clojure-mode)
;; make latex only monospace font.
(setq font-latex-fontify-sectioning 'color)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq vc-follow-symlinks t)
;; (set-face-attribute 'default nil
;;                     :family "Mx437 Nix8810 M15"
;;                     :height 180
;;                     :weight 'normal
;;                    :width  'normal)
(set-face-attribute 'default nil
                    :family "mononoki"
                    :height 130
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



(eval-after-load "tex"
  '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular"))

;; If there is more than one, they won't work right.
;; (setq TeX-view-program-selection
;;       '(((output-dvi has-no-display-manager)))
;;    "dvi2tty"
;;   ((output-dvi style-pstricks)
;;    "dvips and gv")
;;   (output-dvi "xdvi")
;;   (output-pdf "Okular")
;;   (output-html "xdg-open"))

(setq lean-rootdir "/home/bollu/work/lean4/build/stage1")
;; (setq-default TeX-master nil) ;; enable if we want multi file project
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

;; (global-set-key (kbd "C-u") 'undo-tree-undo)

(global-auto-revert-mode t) ;; auto load changed buffers on disk that don't have local unsaved data

;; global subword mode, so backspace and stuff globs less
(global-subword-mode t)

;; close current window
(global-set-key (kbd "C-x C-x") 'delete-window)


;; select all
(global-set-key (kbd "C-x C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-c C-a") 'mark-whole-buffer)

(defun my-ansi-term ()
  "Open an ansi-term if it doesn't already exist, otherwise switch to current one.
   Stolen from: https://old.reddit.com/r/emacs/comments/46l1mu/how_to_make_ansiterm_go_to_the_same_buffer"
  (interactive)
  (if (get-buffer "*eshell*")
      (switch-to-buffer "*eshell*")
    (eshell)))
(global-set-key (kbd "C-c \\") 'my-ansi-term)
(global-set-key (kbd "C-c C-\\") 'my-ansi-term)
(global-set-key (kbd "C-x C-\\") 'my-ansi-term)
(global-set-key (kbd "C-x \\") 'my-ansi-term)

(require 'term)
(defun jnm/term-toggle-mode ()
  "Toggles term between line mode and char mode.
   Found from: http://joelmccracken.github.io/entries/switching-between-term-mode-and-line-mode-in-emacs-term/"
  (interactive)
  (if (term-in-line-mode)
      (progn ;; line -> char
          (term-char-mode)
          (read-only-mode -1)
          (setq-local cursor-type 'bar))
      (progn ;; char -> line)
          (term-line-mode)
          (read-only-mode 1)
          (setq-local cursor-type 'box))))



(define-key term-mode-map (kbd "C-j") 'jnm/term-toggle-mode)
(define-key term-mode-map (kbd "C-k") 'kill-line)

(define-key term-raw-map (kbd "C-j") 'jnm/term-toggle-mode)
(define-key term-raw-map (kbd "C-k") 'kill-line)


(defun bollu/smarter-cut ()
    "try to cut selection. If cannot cut, then copy"
    (interactive)
    (if (buffer-local-value 'buffer-read-only (current-buffer))
        ;; then
        (kill-ring-save (region-beginning) (region-end))
        ;; else
        (kill-region (region-beginning) (region-end))))
(define-key term-mode-map (kbd "C-w") 'bollu/smarter-cut)

;; (defun bollu/smarter-kill-end-of-line ()
;;     "If text selected, cut it. If no text selected, kill till end of line.
;;      TODO: adapt to kill till end of line smartly; ie, copy if cannot cut."
;;     (interactive)
;;     (if (mark-active) (bollu/smarter-cut) (kill-line)))

        


(define-key term-mode-map (kbd "C-w") 'bollu/smarter-cut)

;; TODO: teach C-y to copy if bufferis read-only
;; TODO: teach C-k to kill region if region is selected
;; TODO: teach C-s (ctrlf-mode) to search whatever is selected under cursor
;; TODO: make C-backspace eat whitespace backwards


;; load back.el
;; (load-file "/home/bollu/.emacs.d/back.el")

;; go to previous location
(defun xah-pop-local-mark-ring ()
  "Move cursor to last mark position of current buffer.
Call this repeatedly will cycle all positions in `mark-ring'.
URL `http://ergoemacs.org/emacs/emacs_jump_to_previous_position.html'
Version 2016-04-04"
  (interactive)
  (set-mark-command t))

(setq show-paren-delay 0)
(show-paren-mode 1) ;; matching parens highlight

(global-set-key (kbd "C-c g") 'magit) ;; magit: C-c g

;; emacs temp files
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; remove destructive commands
(global-set-key (kbd "C-x h") 'nil)
(global-set-key (kbd "C-l") 'nil)


;; backward kill word that is not super dumb.
;; https://stackoverflow.com/questions/28221079/ctrl-backspace-in-emacs-deletes-too-much
(defun bollu/backward-kill-word ()
  "Remove all whitespace if the character behind the cursor is whitespace, otherwise remove a word."
  (interactive)
  (if (looking-back "[ \n]")
      ;; delete horizontal space before us and then check to see if we
      ;; are looking at a newline
      (progn (delete-horizontal-space 't)
             (while (looking-back "[ \n]")
               (backward-delete-char 1)))
    ;; otherwise, just do the normal kill word.
    (backward-kill-word 1)))
(global-set-key (kbd "<C-backspace>") 'bollu/backward-kill-word)



(defun htmlize-with-line-numbers ()
  (interactive)
  (goto-char (point-min))
  (let ((n 1))
    (while (not (eobp))
      (htmlize-make-tmp-overlay (point) (point) `(before-string ,(format "%4d " n)))
      (setq n (1+ n))
      (forward-line 1)))
  (switch-to-buffer (htmlize-buffer)))

;; https://emacs.stackexchange.com/a/24758/28600
(setq org-plus-line-capture (number-to-string (line-number-at-pos)))

;; org
(setq org-capture-templates
    `(;; Note the backtick here, it's required so that the defvar based tempaltes will work!
      ;;http://comments.gmane.org/gmane.emacs.orgmode/106890
      ("c" "code" entry (file+headline "~/dotfiles/code-notes.org" "code")
       "* [[file://%F::%(with-current-buffer (org-capture-get :original-buffer) (number-to-string (line-number-at-pos)))][%F - %^{Link Text}]]\nCreated On: %U\n#+BEGIN_SRC\n%i\n#+END_SRC\n" :prepend true)))


(define-key global-map (kbd "C-c c")
  (lambda () (interactive) (org-capture nil "c")))

(define-key global-map (kbd "C-c C-c")
  (lambda () (interactive) (org-capture nil "c")))

(define-key global-map (kbd "C-c C-d")
  (lambda () (interactive) (find-file "~/dotfiles/code-notes.org")))


;; wipe all keybinds
;; (Use-global-map (make-sparse-keymap))
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   '("cbd85ab34afb47003fa7f814a462c24affb1de81ebf172b78cb4e65186ba59d2" "80d5a22931c15756b00fb258b80c93b8bc5096bb698dadfb6155ef3550e1c8fb" default)))
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.

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

(straight-use-package 'use-package)

;; sublime text control d
(global-set-key (kbd "C-d") 'rectangle-mark-mode)

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
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))



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

;; HELP (BROKEN ON PURPOSE
(straight-use-package 'helpful)
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)

(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;;
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)

;; Look up *C*ommands.
;;
;; By default, C-h C is bound to describe `describe-coding-system'. I
;; don't find this very useful, but it's frequently useful to only
;; look at interactive functions.
(global-set-key (kbd "C-h C") #'helpful-command)

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
(straight-use-package 'dash)


;; TODO: write a new shell for yourself using comint-mode
(straight-use-package 'ctrlf)


(straight-use-package 'prescient)


;; (straight-use-package 'vertico)
;; Enable vertico
(use-package vertico
  :straight (vertico :includes vertico-directory
                     :files (:defaults "extensions/vertico-directory.el"))
  :init
  (vertico-mode))

;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
  
(straight-use-package 'projectile)
(straight-use-package 'rg)
(straight-use-package 'ripgrep)
(straight-use-package 'company-mode)
(global-company-mode)

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
(straight-use-package 'selectric-mode)
(straight-use-package 'zig-mode)
(straight-use-package 'merlin)
(straight-use-package 'tuareg)
(straight-use-package 'vterm)

(global-set-key (kbd "C-c C-c") 'vterm)

;; clang-format
(setq clang-format-style-option "llvm")
(setq clang-format+-always-enable "llvm")

;; AGDA
;; (load-file (let ((coding-system-for-read 'utf-8))
;;                 (shell-command-to-string "agda-mode locate 2>/dev/null"))
;; (load-file "/home/bollu/.cabal/store/ghc-9.0.1/Agda-2.6.2-e4d39c2fc71c7d3a88b69b0a8dc1d4f53f9585135d37d2c8bf5962dd4ed1182c/share/emacs-mode/agda2.el")

;; LEAN4
(setq load-path (cons "/home/siddu_druid/work/lean4-mode" load-path))
(straight-use-package 'dash)
(straight-use-package 'flycheck)
(straight-use-package 'f)
(straight-use-package 'lsp-mode)
(straight-use-package 'magit-section)
(straight-use-package 's)
(require 'lean4-mode)

;; OCAML
(require 'tuareg)
(require 'merlin)
(add-hook 'tuareg-mode-hook #'merlin-mode)
(add-hook 'caml-mode-hook #'merlin-mode)


;; LEAN
;; (setq load-path (cons "/home/bollu/work/lean4/lean4-mode" load-path))
;; (setq load-path (cons "/home/bollu/work/lean4-contrib/lean4-mode" load-path))
;; (require 'lean4-mode)

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
;; (load-theme 'borland-blue t)
(load-theme 'wombat t)


(vertico-mode +1)


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

(set-face-attribute 'default nil
                    :family "Mx437 Nix8810 M15"
                    :height 100
                    :weight 'normal)



(set-face-attribute 'default nil
                    :family "mononoki"
                    :height 130
                    :weight 'bold
                    :width  'normal)

(set-face-attribute 'default nil
                    :family "Meslo LG S DZ for Powerline"
                    :height 130
                    :weight 'normal
                    :width  'normal)


(global-set-key (kbd "<C-tab>") 'switch-to-buffer)
(global-set-key (kbd "<C-iso-lefttab>") 'switch-to-buffer)
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

;; global subword mode, so backspace and stuff globs less
(global-subword-mode t)

;; close current window
(global-set-key (kbd "C-x C-x") 'delete-window)


;; select all
(global-set-key (kbd "C-x C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-c C-a") 'mark-whole-buffer)



(defun bollu/smarter-cut ()
    "try to cut selection. If cannot cut, then copy"
    (interactive)
    (if (buffer-local-value 'buffer-read-only (current-buffer))
        ;; then
        (kill-ring-save (region-beginning) (region-end))
        ;; else
        (kill-region (region-beginning) (region-end))))

(global-set-key (kbd "C-w") 'bollu/smarter-cut)




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



(define-key global-map (kbd "C-c c")
  (lambda () (interactive) (org-capture nil "c")))

(define-key global-map (kbd "C-c C-c")
  (lambda () (interactive) (org-capture nil "c")))

(define-key global-map (kbd "C-c C-d")
  (lambda () (interactive) (find-file "~/dotfiles/code-notes.org")))

;; SAGE config
(add-to-list 'auto-mode-alist '("\\.sage\\'" . python-mode))
;; CUBICALTT
;; (load-file "/home/bollu/work/cubicaltt/cubicaltt.el")
;; (load-file "/home/bollu/work/minitt/stlc.el")

;; LLVM
;; (setq load-path
;;  (cons (expand-file-name "/home/bollu/work/llvm-project/llvm/utils/emacs") load-path))
;; (require 'llvm-mode)

;; disable ALL KEYS
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
;; (global-set-key (kbd "C-x C-f") 'find-file)
;; (global-set-key (kbd "C-x C-s") 'save-buffer)
;; (global-set-key (kbd "<return>") 'newline)
;; (global-set-key (kbd "<RET>") 'newline)
;; (global-set-key (kbd "C-x C-c") 'save-buffers-kill-terminal)
;; (global-set-key (kbd "<backspace>") 'backward-delete-char-untabify)
;; (global-set-key (kbd "<up>") 'previous-line)
;; (global-set-key (kbd "<down>") 'next-line)
;; (global-set-key (kbd "<left>") 'left-char)
;; (global-set-key (kbd "<right>") 'right-char)
;; (global-set-key (kbd "C-w") 'kill-region)
;; (global-set-key (kbd "C-s") 'isearch-forward)
;; (global-set-key (kbd "C-r") 'isearch-backward)
;; (global-set-key (kbd "M-x") 'execute-extended-command)
;; 
;; (global-set-key (kbd "C-x b") 'switch-to-buffer)
;; (global-set-key (kbd "M-<") 'beginning-of-buffer)
;; (global-set-key (kbd "M-<") 'end-of-buffer)
;; (global-set-key (kbd "M-x") 'execute-extended-command)
;; (global-set-key (kbd "C-y") 'yank)
;; (global-set-key (kbd "M-y") 'yank-pop)
;; (global-set-key (kbd "C-a") 'beginning-of-line)
;; (global-set-key (kbd "C-e") 'end-of-line)
;; (global-set-key (kbd "C-k") 'kill-line)
;; (global-set-key (kbd "C-h k") 'describe-key)
;; (global-set-key (kbd "C-h m") 'describe-mode)
;; (global-set-key (kbd "C-h f") 'describe-function)
;; 
;; ;; C-x o
;; ;; click selection of windows
;; ;; C-s-up,down-left-right
;; 
;; 
;; ;; https://github.com/raxod502/selectrum/pull/186/files
;; (setq selectrum-minibuffer-map
;;       (let ((m (make-sparse-keymap)))
;;         (define-key m (kbd "C-g") #'abort-recursive-edit)
;;         (define-key m (kbd "TAB") #'selectrum-insert-current-candidate)
;;         (define-key m (kbd "<return>") #'selectrum-select-current-candidate)
;;         (define-key m (kbd "TAB") #'selectrum-select-current-candidate)
;;         (define-key m (kbd "p") #'selectrum-previous-candidate)
;;         (define-key m (kbd "n") #'selectrum-next-candidate)
;;         m))

(defgroup thoth nil
  "Project workbench, fueled by magic and mathematics."
  :group 'tools
  :group 'convenience)

(defcustom thoth-folders nil
  "A list of folders to index. Final output is from thoth-folders which are NOT in thoth-ignored-folders"
  :group 'thoth
  :type '(repeat string))

(defcustom thoth-ignored-folders nil
  "A list of folders to ignore. Final output is from thoth-folders which are NOT in thoth-ignored-folders"
  :group 'thoth
  :type '(repeat string))

(defcustom thoth-project-name nil
  "project name."
  :group 'thoth
  :type 'string)

(defvar thoth-known-projects nil
  "List of locations where we have previously seen projects")


(defun thoth-root-path ()
    (locate-dominating-file default-directory ".dir-locals.el"))

(defun thoth-info ()
  (interactive)
  (let ((rootpath (locate-dominating-file default-directory ".dir-locals.el")))
     (message "%s | +  %s | - %s" thoth-project-name
           (s-join ";" thoth-folders)
          (s-join ";" thoth-ignored-folders))))

(defun thoth-search-regex (regex)
  (interactive)
  (message "regex: %s" regex))

(defun thoth-search-literal ())

(defun thoth-find-file  ()
  (interactive)
  (setq debug-on-error t)
  (let*
      ((prompt-str thoth-project-name)
       (find-not-folders-str (s-join " " (mapcar (lambda (x) (s-concat " -not -path " x)) thoth-ignored-folders)))
       (find-folders-str (s-join " " thoth-folders))
       (cmd (s-concat "find  " find-folders-str " " find-not-folders-str))
       (out (s-split "\n" (shell-command-to-string cmd)))
       (initial-input ""))
   (find-file (completing-read prompt-str out nil nil initial-input))))


(define-minor-mode thoth-mode
  "Minor mode to assist project management and navigation."
  ;; :lighter projectile--mode-line
  ;; :keymap projectile-mode-map
  :group 'thoth
  ;; :require 'projectile
  :global t
  (cond
   (thoth-mode)))
    ;; setup the commander bindings
    ;; (projectile-commander-bindings)
    ;; initialize the projects cache if needed
  

;; (define-globalized-minor-mode global-thoth-mode thoth-mode thoth-on)
;; (defun thoth-on () (thoth-mode 1))



;; selectrum-select-current-candidate (found in selectrum-minibuffer-map)
;; (define-key selectrum-minibuffer-map (kbd "<RET>") 'selectrum-select-current-candidate) 

(defun mechanics ()
  (interactive)
  (run-scheme  "mit-scheme --band /home/bollu/work/sicm/scmutils-20200810/mechanics.com --library /home/bollu/.local/lib/mit-scheme-x86-64/")
  (set-input-method 'TeX))

;; start emacs server
;; (server-start)

;; use swiper for search
(global-set-key (kbd "C-s") 'swiper-isearch)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   '("1b780020c8fe8c91829c06d2a9d5c7d8a182216e479c5b24e787fb1712ffb176" "c1284dd4c650d6d74cfaf0106b8ae42270cab6c58f78efc5b7c825b6a4580417" "03f28a4e25d3ce7e8826b0a67441826c744cbf47077fb5bc9ddb18afe115005f" "be73fbde027b9df15a98a044bcfff4d46906b653cb6eef0d98ebccb7f8425dc9" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "c335adbb7d7cb79bc34de77a16e12d28e6b927115b992bccc109fb752a365c72" "cbd85ab34afb47003fa7f814a462c24affb1de81ebf172b78cb4e65186ba59d2" "80d5a22931c15756b00fb258b80c93b8bc5096bb698dadfb6155ef3550e1c8fb" default))
 '(fci-rule-color "#f1c40f")
 '(hl-paren-background-colors '("#2492db" "#95a5a6" nil))
 '(hl-paren-colors '("#ecf0f1" "#ecf0f1" "#c0392b"))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#32302f"))
 '(safe-local-variable-values
   '((checkdoc-package-keywords-flag)
     (thoth-ignored-folders "~/work/lz/.git" "~/work/lz/.idea" "~/work/lz/.vscode")
     (thoth-folders "~/work/lz/")
     (thoth-project-name . "lizzy")
     (thoth-folders ".")
     (thoth-folders list ".")
     (thoth-folders quote
            ("."))
     (thoth-project-name . lizzy)))
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(vc-annotate-background "#ecf0f1")
 '(vc-annotate-color-map
   '((30 . "#e74c3c")
     (60 . "#c0392b")
     (90 . "#e67e22")
     (120 . "#d35400")
     (150 . "#f1c40f")
     (180 . "#d98c10")
     (210 . "#2ecc71")
     (240 . "#27ae60")
     (270 . "#1abc9c")
     (300 . "#16a085")
     (330 . "#2492db")
     (360 . "#0a74b9")))
 '(vc-annotate-very-old-color "#0a74b9"))
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.

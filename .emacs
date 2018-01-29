:q!; (load "server")
;; (unless (server-running-p) (server-start))

;;(setq url-proxy-services
;;      '(("http" .  "http://proxy.iiit.ac.in:8080")
;;        ("https" .  "http://proxy.iiit.ac.in:8080")))

;;(setq url-proxy-services
;;   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;;     ("http" . "proxy.iiit.ac.in:8080")
;;     ("https" . "proxy.iiit.ac.in:8080")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; don't need to refresh and annoy the world each time you launch.
;; (package-refresh-contents)
(package-initialize)

(require 'cl)

;;allow GC to use memory
(setq gc-cons-threshold 20000000)

;; spell check
(if (eq system-type 'darwin)
    (setq-default ispell-program-name "/usr/local/bin/aspell")
  (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-list-command "list")


;;parens niceness
(electric-pair-mode 1)
(show-paren-mode t)


;;hide cruft
;; (tool-bar-mode -1)
(setq inhibit-startup-screen t)

;;save files
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq backup-by-copying t)


;;disable tabs
(setq-default indent-tabs-mode nil)
;;(infer-indentation-style)

;;indentation
(define-key global-map (kbd "RET") 'newline-and-indent)

;;font
(add-to-list 'default-frame-alist '(font . "Hack-17"))

;; line  by line scrolling
(setq scroll-step 1)
;; spaces for tab
(setq-default indent-tabs-mode nil) 

;; ========== Enable Line and Column Numbering ==========

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)


;;SMEXV over M-x
;; (setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
;; (smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)


(defun install-all-packages ()
  "install / update all packages I care about"
  (interactive)
  (package-initialize)
  (package-refresh-contents)
  (let ((ps '(ivy
              evil
              key-chord
              powerline
              company
              projectile
              leuven-theme)))
    (dolist (p ps)
      (when (not (package-installed-p p))
        (package-install p))))
)



;;IDO > usual mode
;; (require 'flx-ido)
;;( ido-mode 1)
;; (ido-everywhere 1)
;; (flx-ido-mode 1)
;; disable ido faces to see flx highlights.
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-faces nil)
;;vertical display
;;(require 'ido-vertical-mode)
;;(ido-mode 1)
;;(ido-vertical-mode 1)
;;(setq ido-vertical-define-keys 'C-n-and-C-p-only)
;;(setq ido-vertical-show-count t)
;;(setq ido-use-faces t)
;;(set-face-attribute 'ido-vertical-first-match-face nil
;;                    :background nil
;;                    :foreground "orange")

;;(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)


;;disallow org from reformatting source blocks
(setq org-src-preserve-indentation t)


(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is enough
(defalias 'list-buffers 'ibuffer) ; always use ibuffer

;;org-mode
(global-set-key (kbd "C-c a") 'org-agenda)

;; evil
;; Disable weird evil shit for proof general
;; https://github.com/syl20bnr/spacemacs/issues/8853
(setq evil-want-abbrev-expand-on-insert-exit nil)
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

;; powerline
(require 'powerline)
(powerline-default-theme)

;;jk for evil with key-chord
;;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.3)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

;; company - autocomplete
(require 'company)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(setq company-idle-delay 0.0)
(global-set-key (kbd "C-/") 'company-complete)
(evil-declare-change-repeat 'company-complete)
(evil-declare-change-repeat 'company-complete-common)

;;gitconfig
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))


;;markdown
;; (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
;; (add-hook 'markdown-mode-hook
;;           (lambda ()
;;             (visual-line-mode t)
;;             (writegood-mode t)))
;; 
;; (setq markdown-command "pandoc --smart -f markdown -t html")

;; ivy, swiper
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)


;;projectile
(projectile-mode)
(setq projectile-enable-caching t)

;; sublime text like bindings
(global-set-key (kbd "C-c @") 'swiper)



;;proof general
;;(load "~/.emacs.d/lisp/PG/generic/proof-site")

;;flyspell
;; (require 'flyspell)
;; (flyspell-mode +1)
;; ;; spell checking in comments
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; 
;; ;; make sure spell checking works
;; (setq-default ispell-program-name "aspell")
;; (ispell-change-dictionary "en_GB" t)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coq-prog-name "/usr/local/bin/coqtop")
 '(custom-safe-themes (quote ("d5f17ae86464ef63c46ed4cb322703d91e8ed5e718bf5a7beb69dd63352b26b2" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "d29231b2550e0d30b7d0d7fc54a7fb2aa7f47d1b110ee625c1a56b30fea3be0f" "10e231624707d46f7b2059cc9280c332f7c7a530ebc17dba7e506df34c5332c4" "604648621aebec024d47c352b8e3411e63bdb384367c3dd2e8db39df81b475f5" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(delete-selection-mode nil)
 '(ivy-height 40)
 '(package-selected-packages
   (quote
    (intero company-irony haskell-mode haskell-emacs web-mode solarized-theme smex racket-mode racer projectile material-theme markdown-preview-mode magit key-chord js2-mode ido-vertical-mode flx-ido evil company badwolf-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; colorscheme
(require 'leuven-theme)
(load-theme 'leuven)


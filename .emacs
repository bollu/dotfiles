(load "server")
(unless (server-running-p) (server-start))

(setq url-proxy-services
      '(("http" .  "http://proxy.iiit.ac.in:8080")
        ("https" .  "http://proxy.iiit.ac.in:8080")))

(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "proxy.iiit.ac.in:8080")
     ("https" . "proxy.iiit.ac.in:8080")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
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
(add-to-list 'default-frame-alist '(font . "Hack-11"))

;; line  by line scrolling
(setq scroll-step 1)
;; spaces for tab
(setq-default indent-tabs-mode nil) 

; ========== Enable Line and Column Numbering ==========

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
  (let ((ps '(llvm-mode ivy evil key-chord
              powerline company racer projectile
              counsel-projectile leuven-theme tuareg company-coq)))
    (dolist (p ps)
      (when (not (package-installed-p p))
        (package-install p))))
)



;;IDO > usual mode
;; (Require 'Flx-Ido)
;;( Ido-mode 1)
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

;;llvm-mode
(setq load-path (cons (expand-file-name "/Users/bollu/work/LLVM-all/polly/llvm/utils/emacs") load-path))
(require 'llvm-mode)

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
(global-set-key (kbd "C-\\") 'company-complete)
(evil-declare-change-repeat 'company-complete)
(evil-declare-change-repeat 'company-complete-common)

;; make first tab pick, next tabs cycle
;;https://github.com/company-mode/company-mode/wiki/Switching-from-AC
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

(setq company-frontends
      '(company-pseudo-tooltip-unless-just-one-frontend
        company-preview-frontend
        company-echo-metadata-frontend))

;; space key finishes completion
(setq company-auto-complete t)

;;gitconfig
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))

;; DISABLE IRONY TILL WE CAN BUILD IT
;;C/C++ (1/4 of my life)
(require 'irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)



;; Rust (1/4 of my life)
(require 'racer)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

(add-hook 'racer-mode-hook #'company-mode)
(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)


;;markdown
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-line-mode t)
            (writegood-mode t)))

(setq markdown-command "pandoc --smart -f markdown -t html")

;; ivy, swiper
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)


;;projectile
(projectile-mode)
(setq projectile-enable-caching t)
;; counsel for projectile
;; (Counsel-projectile-on)

;; sublime text like bindings
(global-set-key (kbd "C-c @") 'swiper)

;;proof general
(load "~/.emacs.d/lisp/PG/generic/proof-site")

;;flyspell
(require 'flyspell)
(flyspell-mode +1)
;; spell checking in comments
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; make sure spell checking works
(setq-default ispell-program-name "aspell")
(ispell-change-dictionary "en_GB" t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coq-compiler "/home/bollu/.opam/4.05.0/bin/coqc")
 '(coq-prog-name "/home/bollu/.opam/4.05.0/bin/coqtop")
 '(custom-safe-themes
   (quote
    ("9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "d5f17ae86464ef63c46ed4cb322703d91e8ed5e718bf5a7beb69dd63352b26b2" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "d29231b2550e0d30b7d0d7fc54a7fb2aa7f47d1b110ee625c1a56b30fea3be0f" "10e231624707d46f7b2059cc9280c332f7c7a530ebc17dba7e506df34c5332c4" "604648621aebec024d47c352b8e3411e63bdb384367c3dd2e8db39df81b475f5" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(delete-selection-mode nil)
 '(ivy-height 40)
 '(package-selected-packages
   (quote
    (intero company-irony haskell-mode haskell-emacs web-mode solarized-theme smex racket-mode racer projectile material-theme markdown-preview-mode magit key-chord js2-mode ido-vertical-mode flx-ido evil company badwolf-theme)))
 '(safe-local-variable-values
   (quote
    ((eval progn
           (let
               ((coq-root-directory
                 (when buffer-file-name
                   (locate-dominating-file buffer-file-name ".dir-locals.el")))
                (coq-project-find-file
                 (and
                  (boundp
                   (quote coq-project-find-file))
                  coq-project-find-file)))
             (set
              (make-local-variable
               (quote tags-file-name))
              (concat coq-root-directory "TAGS"))
             (setq camldebug-command-name
                   (concat coq-root-directory "dev/ocamldebug-coq"))
             (unless coq-project-find-file
               (set
                (make-local-variable
                 (quote compile-command))
                (concat "make -C " coq-root-directory))
               (set
                (make-local-variable
                 (quote compilation-search-path))
                (cons coq-root-directory nil)))
             (when coq-project-find-file
               (setq default-directory coq-root-directory))))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; colorscheme
(require 'leuven-theme)
(load-theme 'leuven)

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line


;; ===============
;; MERLIN (for OCAML)
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
 (when (and opam-share (file-directory-p opam-share))
  (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
  (autoload 'merlin-mode "merlin" nil t nil)
  (add-hook 'tuareg-mode-hook 'merlin-mode t)
  (add-hook 'caml-mode-hook 'merlin-mode t)))



;; ===============
;; MERLIN + COMPANY
; Make company aware of merlin
(with-eval-after-load 'company
 (add-to-list 'company-backends 'merlin-company-backend))
; Enable company on merlin managed buffers
(add-hook 'merlin-mode-hook 'company-mode)
; Or enable it globally:
; (add-hook 'after-init-hook 'global-company-mode)


;; ===============
;; Load company-coq when opening Coq files
(add-hook 'coq-mode-hook #'company-coq-mode)

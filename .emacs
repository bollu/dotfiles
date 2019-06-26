(load "server")
(unless (server-running-p) (server-start))

;;(setq url-proxy-services
;;      '(("http" .  "http://proxy.iiit.ac.in:8080")
;;        ("https" .  "http://proxy.iiit.ac.in:8080")))
;;
;;(setq url-proxy-services
;;   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;;     ("http" . "proxy.iiit.ac.in:8080")
;;     ("https" . "proxy.iiit.ac.in:8080")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; don't need to refresh and annoy the world each time you launch.
;; (package-refresh-contents)
(package-initialize)

;; suspend emcas
(define-key global-map (kbd "C-c C-z") 'suspend-emacs)

;; LLVM-mode
(setq load-path (cons (expand-file-name "path-to-llvm/utils/emacs") load-path))
(require 'llvm-mode)


;; emacs go back and forth between marks
;; (require 'back-button)
;; (back-button-mode 1)
;; (global-set-key (kbd "C-x p") 'helm-global-mark-ring)
;; (global-set-key (kbd "C-x C-p") 'helm-global-mark-ring)
(require 'backward-forward)
(backward-forward-mode)
;; unbind default keys
(define-key backward-forward-mode-map (kbd "<C-left>") nil)
(define-key backward-forward-mode-map (kbd "<C-right>") nil)

(global-set-key (kbd "C-x <left>") 'backward-forward-previous-location)
(global-set-key (kbd "C-x <C-left>") 'backward-forward-previous-location)
(global-set-key (kbd "C-x <right>") 'backward-forward-next-location)
(global-set-key (kbd "C-x <C-right>") 'backward-forward-next-location)
(global-set-key (kbd "C-x p") 'helm-global-mark-ring)
(global-set-key (kbd "C-x C-p") 'helm-global-mark-ring)

;; buffer naviation with C-tab
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-S-iso-lefttab>") 'previous-buffer)

;; guess indent
(require 'dtrt-indent)
(dtrt-indent-global-mode t)

(require 'smartparens)
(smartparens-global-mode)

(require 'cl)
;; hide menubar and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)

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

;; CUA-mode
(cua-mode)
;; (global-set-key (kbd "C-a") 'mark-whole-buffer)
(define-key cua-global-keymap (kbd "<C-return>") nil)

;; always follow symlinks
(setq vc-follow-symlinks t)

;; splits
(global-set-key (kbd "C-x |") 'evil-window-vsplit)
(global-set-key (kbd "C-x -") 'evil-window-split)


;; map C-/ to toggle comment
(global-set-key (kbd "C-x C-/") 'comment-or-uncomment-region)

;;hide cruft
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

;;save files
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "/tmp/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; store all backup and autosave files in the tmp dir
;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))
;; (setq backup-by-copying t)


;;disable tabs
(setq-default indent-tabs-mode nil)
;;(infer-indentation-style)

;;indentation
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Buffer stuff
;; IBuffer > Buffer
;; (define-key global-map (kbd "C-x b") 'ibuffer)
(require 'ido)
(ido-mode t)
;; (define-key global-map (kbd "C-x b") 'ido-bu)

(define-key global-map (kbd "C-x n") 'next-buffer)
(define-key global-map (kbd "C-x C-n") 'next-buffer)
(define-key global-map (kbd "M-n") 'next-buffer)

(define-key global-map (kbd "M-p") 'previous-buffer)
(define-key global-map (kbd "C-x p") 'previous-buffer)

;;font
(add-to-list 'default-frame-alist '(font . "Fira Code Medium-14"))

;; line  by line scrolling
(setq scroll-step 1)
;; spaces for tab
(setq-default indent-tabs-mode nil) 

(defun install-all-packages ()
  "install / update all packages I care about"
  (interactive)
  (package-initialize)
  (package-refresh-contents)
  (let ((ps '(ivy evil key-chord powerline company racer projectile tabbar
                   irony intero counsel-projectile leuven-theme tuareg
                   company-coq writegood-mode merlin syntax-subword auto-complete molokai
                   expand-region evil-surround dumb-jump dtrt-indent backward-forward)))
    (dolist (p ps)
      (when (not (package-installed-p p))
        (package-install p))))
  )

;; Use expand-region
(require 'expand-region)
(global-set-key (kbd "<C-return>") 'er/expand-region)
(global-set-key (kbd "<C-S-return>") 'er/contract-region)
;; (global-set-key (kbd "<C-S-up>") 'er/expand-region)
;; (global-set-key (kbd "<C-S-down>") 'er/contract-region)

;; add mjs to javascript
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . javscript-mode))

;; Treat syntactic characters as subwords so that C-backspace does not kill too much
(require 'syntax-subword)
(global-syntax-subword-mode)
(setq syntax-subword-skip-spaces t)


(require 'multiple-cursors)
(global-set-key (kbd "C-x C-l") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-l") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "<C-S-up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "<C-S-down>") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<ret>") 'mc/mark-all-like-this)

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
;; (setq load-path (cons (expand-file-name "/Users/bollu/work/LLVM-all/polly/llvm/utils/emacs") load-path))
;; (require 'llvm-mode)

;; evil
;; Evil interferes with too much. disable it.
;; Disable weird evil shit for proof general
;; https://github.com/syl20bnr/spacemacs/issues/8853
;; (setq evil-want-abbrev-expand-on-insert-exit nil)
;; (setq evil-want-C-u-scroll t)
(require 'evil)
;; (evil-mode 1)
;;jk for evil with key-chord
;;Exit insert mode by pressing j and then j quickly
;;(setq key-chord-two-keys-delay 0.3)
;;(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;;(key-chord-mode 1)

;; Scroll up and down with C-d, C-u
(global-set-key (kbd "C-d") 'evil-scroll-down)
(global-set-key (kbd "C-u") 'evil-scroll-up)


(defalias 'vsplit 'evil-split-vertical)
(defalias 'split 'evil-split-horizontal)
(global-set-key (kbd "M-<left>") 'evil-window-left)
(global-set-key (kbd "M-<right>") 'evil-window-right)
(global-set-key (kbd "M-<up>") 'evil-window-up)
(global-set-key (kbd "M-<down>") 'evil-window-down)
(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "C-=") 'indent-region)

;; dumb-jump: go to definition using regex / patterns.
(global-set-key (kbd "C-]") 'dumb-jump-go)
(setq dumb-jump-selector 'ivy)


(defun multi-cursor-in-region ()
    "if text is selected, create multicursor, otherwise scroll down"
  (interactive)
  (if (use-region-p)
      (mc/mark-all-in-region
       (region-beginning)
       (region-end)
       (read-string "multi-selection: "))
    (mc/mark-next-like-this)))


 
;; overwrite selected
(delete-selection-mode 1)

;; powerline
;; (require 'powerline)
;; (powerline-default-theme)


;; evil-surround


;; company - autocomplete
;; (require 'company)
;; (add-hook 'c++-mode-hook 'company-mode)
;; (add-hook 'c-mode-hook 'company-mode)
;; (add-hook 'c-mode-hook 'counsel-projectile-mode)
;; (setq company-idle-delay 0.0)
;; (global-set-key (kbd "C-/") 'company-complete-common-or-cycle)
;; (global-set-key (kbd "C-\\") 'company-complete-common-or-cycle)
;; (global-set-key (kbd "C-<tab>") 'company-complete-common-or-cycle)
;; (evil-declare-change-repeat 'company-complete)
;; (evil-declare-change-repeat 'company-complete-common)



;; make first tab pick, next tabs cycle
;;https://github.com/company-mode/company-mode/wiki/Switching-from-AC
;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
;;      (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))
;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
;;     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))
;; (setq company-frontends
;;       '(company-pseudo-tooltip-unless-just-one-frontend
;;         company-preview-frontend
;;         company-echo-metadata-frontend))
;; 
;; space key finishes completion
;; (setq company-auto-complete t)

;;gitconfig
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))

;; DISABLE IRONY TILL WE CAN BUILD IT
;;C/C++ (1/4 of my life)
;; (require 'irony)
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(require 'ycmd)
(add-hook 'c++-mode-hook 'ycmd-mode)



;; Rust (1/4 of my life)
;; (require 'racer)
;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'racer-mode-hook #'eldoc-mode)

;; (add-hook 'racer-mode-hook #'company-mode)
;; (require 'rust-mode)
;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
;; (setq company-tooltip-align-annotations t)


;;markdown
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-line-mode t)
            (writegood-mode t)))

(setq markdown-command "pandoc --smart -f markdown -t html")

;; ivy, swiper
(require 'projectile)
(require 'ivy)
(require 'counsel)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x C-o") 'counsel-rg)
(global-set-key (kbd "M-x") 'counsel-M-x)
;;don't let ivy start with ^, kills the damn point of having fuzzy search
(setq ivy-initial-inputs-alist nil)


;;projectile
(projectile-mode)
(setq projectile-enable-caching t)
;; counsel for projectile
(counsel-projectile-mode)
  

;; sublime text like bindings
;; (global-set-key (kbd "C-p @") 'swiper)


;;proof general
;; (load "~/.emacs.d/lisp/PG/generic/proof-site")
;; (coq-prefer-top-of-conclusion t)

;; sane line numbers
(global-display-line-numbers-mode)

;;flyspell
(require 'flyspell)
(flyspell-mode +1)
;; spell checking in comments
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; make sure spell checking works
(setq-default ispell-program-name "aspell")
(ispell-change-dictionary "en_GB" t)


;;tabbar (pimped from here:  http://amitp.blogspot.com/2007/04/emacs-buffer-tabs.html)
(defvar my/tabbar-left "/" "Separator on left side of tab")
(defvar my/tabbar-right "\\" "Separator on right side of tab")
(defun my/tabbar-tab-label-function (tab)
  (powerline-render (list my/tabbar-left
                          (format " %s  " (car tab))
                          my/tabbar-right)))
;; (with-eval-after-load 'powerline
;; (setq my/tabbar-left (powerline-wave-right 'tabbar-default nil 24))
;; (setq my/tabbar-right (powerline-wave-left nil 'tabbar-default 24))
;; (setq tabbar-tab-label-function #'my/tabbar-tab-label-function))
;; ;; Note: for tabbar 2.0 use 
;; ;; tabbar-default not tabbar-default-face,
;; ;; tabbar-selected not tabbar-selected-face,
;; ;; tabbar-button not tabbar-button-face,
;; ;; tabbar-separator not tabbar-separator-face
;; (set-face-attribute
;; 'tabbar-default nil
;; :background "gray60")
;; (set-face-attribute
;; 'tabbar-unselected nil
;; :background "gray85"
;; :foreground "gray30"
;; :box nil)
;; (set-face-attribute
;; 'tabbar-selected nil
;; :background "#f2f2f6"
;; :foreground "black"
;; :box nil)
;; (set-face-attribute
;; 'tabbar-button nil
;; :box '(:line-width 1 :color "gray72" :style released-button))
;; (set-face-attribute
;; 'tabbar-separator-face nil
;; :height 0.7)


;;enable tabbar
;; (tabbar-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face (quote default))
 '(coq-compiler "/home/bollu/.opam/4.05.0/bin/coqc")
 '(coq-prog-name "/home/bollu/.opam/4.05.0/bin/coqtop")
 '(custom-safe-themes
   (quote
    ("11e57648ab04915568e558b77541d0e94e69d09c9c54c06075938b6abc0189d8" "54f2d1fcc9bcadedd50398697618f7c34aceb9966a6cbaa99829eb64c0c1f3ca" "174502267725776b47bdd2d220f035cae2c00c818765b138fea376b2cdc15eb6" "3448e3f5d01b39ce75962328a5310438e4a19e76e4b691c21c8e04ca318a5f62" "e4859645a914c748b966a1fe53244ff9e043e00f21c5989c4a664d649838f6a3" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "75c5c39809c52d48cb9dcbf1694bf2d27d5f6fd053777c194e0b69d8e49031c0" "54e08527b4f4b127ebf7359acbbbecfab55152da01716c4809682eb71937fd33" "81db42d019a738d388596533bd1b5d66aef3663842172f3696733c0aab05a150" "718fb4e505b6134cc0eafb7dad709be5ec1ba7a7e8102617d87d3109f56d9615" "c90fd1c669f260120d32ddd20168343f5c717ca69e95d2f805e42e88430c340e" "15348febfa2266c4def59a08ef2846f6032c0797f001d7b9148f30ace0d08bcf" "3b5ce826b9c9f455b7c4c8bff22c020779383a12f2f57bf2eb25139244bb7290" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "ad109c1ad8115573f40e22ac2b996693b5d48052fa37b5919f70ea37c62a965e" "d3a406c5905923546d8a3ad0164a266deaf451856eca5f21b36594ffcb08413a" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "d5f17ae86464ef63c46ed4cb322703d91e8ed5e718bf5a7beb69dd63352b26b2" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "d29231b2550e0d30b7d0d7fc54a7fb2aa7f47d1b110ee625c1a56b30fea3be0f" "10e231624707d46f7b2059cc9280c332f7c7a530ebc17dba7e506df34c5332c4" "604648621aebec024d47c352b8e3411e63bdb384367c3dd2e8db39df81b475f5" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(delete-selection-mode nil)
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(ivy-height 40)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (dumb-jump evil-surround torus helm expand-region molokai-theme monokai-theme zenburn-theme zenburn auto-complete ## syntax-subword smart-hungry-delete merlin ycmd writegood-mode clang-format proof-general markdown-mode intero company-irony haskell-mode haskell-emacs web-mode solarized-theme smex racket-mode racer projectile material-theme markdown-preview-mode magit key-chord js2-mode ido-vertical-mode flx-ido evil company badwolf-theme)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(safe-local-variable-values
   (quote
    ((coq-prog-args "-R" "/home/bollu/work/cpdt/src" "Cpdt")
     (coq-prog-args "-emacs-U" "-R" "/home/bollu/work/cpdt/src" "Cpdt")
     (eval progn
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
               (setq default-directory coq-root-directory)))))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; colorscheme
;; (require 'leuven-theme)
(require 'zenburn-theme)
;; (load-theme 'zenburn)
;; (load-theme 'flatui)
;; (load-theme 'tango)
;; (load-theme 'monokai)
;; (load-theme 'peacock)



;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;; (require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
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
;; (with-eval-after-load 'company
;;   (add-to-list 'company-backends 'merlin-company-backend))
;; ; Enable company on merlin managed buffers
;; (add-hook 'merlin-mode-hook 'company-mode)
;; ; Or enable it globally:
;; ;; (add-hook 'after-init-hook 'global-company-mode)
;; 
;; auto-complete seems to work out of the box, company _does not work_ at all.
(require 'auto-complete)
(ac-config-default)
(add-hook 'after-init-hook 'global-auto-complete-mode)
(setq tab-always-indent 'complete)
(global-set-key (kbd "C-SPC") 'auto-complete)



;; ===============
;; Load company-coq when opening Coq files
;; (add-hook 'coq-mode-hook #'company-coq-mode)

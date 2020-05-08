;; (load "server")
;; (unless (server-running-p) (server-start))

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
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; don't need to refresh and annoy the world each time you launch.
;; (package-refresh-contents)
;; (package-initialize)
;; suspend emcas
(menu-bar-mode -1)
(tool-bar-mode -1)
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
;; Buffer stuff
(require 'ido)
(ido-mode t)
;; overwrite selected
(delete-selection-mode 1)
;; mixal
(setq load-path (cons "/usr/local/share/mdk" load-path)) 
(autoload 'mixal-mode "mixal-mode" t)
(add-to-list 'auto-mode-alist '("\\.mixal\\'" . mixal-mode))
(autoload 'mixvm "mixvm" "mixvm/gud interaction" t)
;; buffer switching
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-S-iso-lefttab>") 'previous-buffer)

;; copy; we can't use M-w because of some i3 issue.
(global-set-key (kbd "C-q") 'kill-ring-save)

;; always follow symlinks
(setq vc-follow-symlinks t)
;; don't ask to kill pricesses
(setq confirm-kill-processes nil)
;; https://emacs.stackexchange.com/questions/28647/how-do-i-change-the-default-shell-for-shell-command
(setq explicit-shell-file-name "/bin/bash")
;; https://emacs.stackexchange.com/questions/27698/how-can-i-scroll-a-half-page-on-c-v-and-m-v

(defun zz-scroll-half-page (direction)
  "Scrolls half page up if `direction' is non-nil, otherwise will scroll half page down."
  (let ((opos (cdr (nth 6 (posn-at-point)))))
    ;; opos = original position line relative to window
    (move-to-window-line nil)  ;; Move cursor to middle line
    (if direction
	(recenter-top-bottom -1)  ;; Current line becomes last
      (recenter-top-bottom 0))  ;; Current line becomes first
    (move-to-window-line opos)))  ;; Restore cursor/point position

(defun zz-scroll-half-page-down ()
  "Scrolls exactly half page down keeping cursor/point position."
  (interactive)
  (zz-scroll-half-page nil))

(defun zz-scroll-half-page-up ()
  "Scrolls exactly half page up keeping cursor/point position."
  (interactive)
  (zz-scroll-half-page t))


(autoload 'View-scroll-half-page-forward "view") (autoload 'View-scroll-half-page-backward "view")
(global-set-key (kbd "C-d") 'View-scroll-half-page-forward)
(global-set-key (kbd "C-u") 'View-scroll-half-page-backward)

(set-language-environment "UTF-8")

;; set tab to 4 spaces.
(setq-default
  indent-tabs-mode t
  tab-stop-list (number-sequence 4 200 4)
  tab-width 4
  indent-line-function 'insert-tab)

;; move windows.
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; enter mark rectangle.
(global-set-key (kbd "<C-return>") 'rectangle-mark-mode)

;; disable the weird shit emacs does to make fonts smaller
;; and whatnot.
(setq font-latex-fontify-script nil)

;; agda
;; (load-file (let ((coding-system-for-read 'utf-8))
;;                (shell-command-to-string "agda-mode locate")))
(load-file "/home/bollu/.cabal/store/ghc-8.2.2/Agda-2.5.4.1-e96df39fc928344919dcb29b8ea71db7295de4a757c8a777ac2758e9eed1274a/share/emacs-mode/agda2.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(zenburn-theme ycmd writegood-mode twilight-bright-theme tuareg tabbar syntax-subword solarized-theme smartparens sage-shell-mode rainbow-mode rainbow-delimiters racket-mode racer proof-general projectile-codesearch powerline plan9-theme peacock-theme parinfer paredit ox-twbs nlinum multiple-cursors monokai-theme molokai-theme merlin macrostep llvm-mode lispy liso-theme leuven-theme key-chord julia-mode jedi irony intero ido-vertical-mode helm-projectile helm-ag gruvbox-theme gnu-apl-mode github-theme github-modern-theme geiser flx-isearch flx-ido flatui-theme flatui-dark-theme flatland-theme fill-column-indicator expand-region evil-magit elpy dyalog-mode dtrt-indent deft counsel-projectile company-jedi company-coq color-theme-sanityinc-solarized color-theme badwolf-theme backward-forward auctex ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

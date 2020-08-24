(require 'package)
(package-initialize)
(evil-mode 1)
(setq inhibit-startup-screen t)
(global-set-key (kbd "C-c C-c") 'evil-normal-state)
;; (global-set-key (kbd "C-c") 'evil-normal-state)
(define-key global-map (kbd "C-x C-x") 'suspend-emacs)

;; make latex only monospace font.
(setq font-latex-fontify-sectioning 'color)
(advice-add 'face-spec-set-2 :around
            (lambda (f face frame attrs)
              (funcall f face frame (plist-put attrs :height 1.0))))

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

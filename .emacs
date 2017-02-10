(setq url-proxy-services
      '(("http" .  "http://proxy.iiit.ac.in:8080")
        ("https" .  "http://proxy.iiit.ac.in:8080")))

(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "proxy.iiit.ac.in:8080")
     ("https" . "proxy.iiit.ac.in:8080")))


(require 'package)
(require 'cl)

(add-to-list 'package-archives '("melpa-stable" . "http://melpa.org/packages/") t)
(package-initialize)



(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)




(defvar required-packages
  '(
    ivy
    projectile
    smartparens
    counsel
    company
    company-coq
    company-c-headers
    indent-guide
    ag
    intero
    irony
   ;;colorschemes
    monokai-theme
    gruvbox-theme
    robe
    markdown-mode 
    ) "a list of packages to ensure are installed at launch.")

;;proof gegenral
(load "~/.emacs.d/lisp/PG/generic/proof-site")

;;hide cruft
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

;;save files
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;disable tabs
(setq-default indent-tabs-mode nil)
;;(infer-indentation-style)

;;indentation
(define-key global-map (kbd "RET") 'newline-and-indent)


;;font
(add-to-list 'default-frame-alist '(font . "Hack-17"))


;; method to check if all packages are installed
;;(async-bytecomp-package-mode 1)

(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;themehe
(load-theme 'monokai t)



;;indent-guide
(require 'indent-guide)
(indent-guide-global-mode)

;;smartparens
(require 'smartparens-config)
(smartparens-global-mode)

;;Ivy
(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))
(setq ivy-initial-inputs-alist nil)


(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-x p") 'projectile-find-file)


(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is enough
(defalias 'list-buffers 'ibuffer) ; always use ibuffer


(defun markdown-latex-symbols () (set-input-method 'TeX))

(setq ivy-use-virtual-buffers t)

;;robe
(add-hook 'ruby-mode-hook 'robe-mode)


;;projectile
(setq projectile-completion-system 'ivy)

;;company
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'coq-mode-hook #'company-coq-mode)

;; === from http://tuhdo.github.io/c-ide.html#sec-2 ===
(setq company-default-lighter " com")

(eval-after-load 'company
  '(progn
    (setq
     ;; never start auto-completion unless I ask for it
     company-idle-delay nil
     ;; autocomplete right after '.'
     company-minimum-prefix-length 0
     ;; remove echo delay
     company-echo-delay 0
     ;; don't complete in certain modes
     company-global-modes '(not git-commit-mode)))
  )


(show-smartparens-global-mode)



;;Intero
(add-hook 'haskell-mode-hook 'intero-mode)


;;org-mode
(global-set-key (kbd "C-c a") 'org-agenda)
;;automatically launch agenda
(org-agenda nil "a")

;;tex
;;(setq TeX-auto-save t)
;;(setq TeX-parse-self t)
;;(setq TeX-save-query nil)
;;(setq TeX-PDF-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/get-things-done.org")))
 '(package-selected-packages
   (quote
    (markdown-mode+ markdown-mode robe smartparens projectile monokai-theme intero indent-guide helm gruvbox-theme counsel company-coq ag 0blayout))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

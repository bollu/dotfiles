(setq url-proxy-services
      '(("http" .  "http://proxy.iiit.ac.in:8080")
        ("https" .  "http://proxy.iiit.ac.in:8080")))

(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "proxy.iiit.ac.in:8080")
     ("https" . "proxy.iiit.ac.in:8080")))

;;(setq url-http-proxy-basic-auth-storage
;;    (list (list "proxy.iiit.ac.in:8080"
;;                (cons "siddharth.bhat"
;;                      (base64-encode-string "siddharth.bhat:Blademaster1!x")))))


(require 'package)
(require 'cl)

(add-to-list 'package-archives '("melpa-stable" . "http://melpa.org/packages/") t)
(package-initialize)


(defvar required-packages
  '(
    ivy
    projectile
    smartparens
    counsel
    company
    company-coq
    indent-guide
    ag
    intero
   ;;colorschemes
    monokai-theme
    gruvbox-theme
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


;;font
(add-to-list 'default-frame-alist '(font . "Hack-14"))


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

;;theme
(load-theme 'wombat t)



;;indent-guide
;;(require 'indent-guide)
;;(indent-guide-global-mode)

;;smartparens
;;(require 'smartparens-config)
;;(smartparens-global-mode)

;;Ivy
(global-set-key (kbd "C-s") 'swiper)
;;(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-x p") 'projectile-find-file)
(setq ivy-use-virtual-buffers t)

;;projectile
(setq projectile-completion-system 'ivy)

;;company
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'coq-mode-hook #'company-coq-mode)

;;intero
(add-hook 'haskell-mode-hook 'intero-mode)


;;tex
;;(setq TeX-auto-save t)
;;(setq TeX-parse-self t)
;;(setq TeX-save-query nil)
;;(setq TeX-PDF-mode t)

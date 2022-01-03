(setq inhibit-startup-screen t)


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

;; (straight-use-package 'evil)
;; (straight-use-package 'gruvbox-theme)
(straight-use-package 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
(setq projectile-completion-system 'default)

(straight-use-package 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.3)

(setq gc-cons-threshold (* 100 1024 1024))
			   
(load-theme 'wombat t)
(defalias 'yes-or-no-p 'y-or-n-p)


(straight-use-package 'golden-ratio)
(straight-use-package 'golden-ratio-scroll-screen)
(golden-ratio-mode +1)


;; LSP :(
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)


;; vertical auto complete
(straight-use-package 'vertico)
(vertico-mode +1)


;; keep these at the end.
(defun bollu-toggle-modal () (interactive)
  (read-only-mode 'toggle)
  (modalka-mode 'toggle))


(defun bollu-normal-mode-advice (f)
  (interactive)
  "Run function f that can mutate the buffer in normal mode."
  (read-only-mode -1)
  (f)
  (read-only-mode +1))
   

;; bindings that stick on top of other major modes.
;; (straight-use-package 'bind-key)
;; (bind-keys*
;;  ("C-x C-p" . switch-to-buffer)
;;  ("C-x C-x" . completion-at-point)
;;  ("C-\\" . completion-at-point)
;;  ("C-d" . golden-ratio-scroll-screen-up)
;;  ("C-u" . golden-ratio-scroll-screen-down)
;;  ("C-c p p" . lsp-find-definition)
;;  ("C-c p r" . lsp-find-references)
;;  ("C-c p d" . lsp-find-declaration)
;;  ("C-c :" . goto-line)
;;  ("C-x :" . goto-line)
;;  ("C-:" . goto-line)
;;  ("C-c ;" . comment-or-uncomment-region)
;;  ("C-c C-;" . comment-or-uncomment-region) 
;;  ("C-x C-a" . mark-whole-buffer)
;;  ("C-c C-a" . mark-whole-buffer)
;;  ("<return>" . modalka-mode)
;;  ("C-c C-c" . bollu-toggle-modal)
;;  )



;;(straight-use-package 'modalka)
;; (modalka-define-kbd "W" "M-w")
;; (modalka-define-kbd "Y" "M-y")
;; (modalka-define-kbd "a" "C-a")
;; (modalka-define-kbd "b" "C-b")
;; (modalka-define-kbd "e" "C-e")
;; (modalka-define-kbd "f" "C-f")
;; (modalka-define-kbd "g" "C-g")
;; (modalka-define-kbd "n" "C-n")
;; (modalka-define-kbd "p" "C-p")
;; (modalka-define-kbd "w" "C-w")
;; (modalka-define-kbd "y" "C-y")

;; (modalka-mode +1)
;; (define-key modalka-mode-map (kbd "<enter>") #'set-mark-command)
;; (define-key modalka-mode-map (kbd "<space>") #'set-mark-command)
;; (define-key modalka-mode-map (kbd "v") #'set-mark-command)
;; (define-key modalka-mode-map (kbd "w") #'forward-sexp)
;; (define-key modalka-mode-map (kbd "b") #'backward-sexp)
;; (define-key modalka-mode-map (kbd "W") #'forward-sentence)
;; (define-key modalka-mode-map (kbd "B") #'backward-sentence)
;; (define-key modalka-mode-map (kbd "<") #'beginning-of-buffer)
;; (define-key modalka-mode-map (kbd ">") #'end-of-buffer)
;; (define-key modalka-mode-map (kbd ":") #'goto-line)
;; (define-key modalka-mode-map (kbd "j") #'next-line)
;; (define-key modalka-mode-map (kbd "k") #'previous-line)
;; (define-key modalka-mode-map (kbd "h") #'left-char)
;; (define-key modalka-mode-map (kbd "l") #'right-char)
;; (define-key modalka-mode-map (kbd ";") #'comment-or-uncomment-region)
;; (define-key modalka-mode-map (kbd "u") #'undo)
;; (define-key modalka-mode-map (kbd "d") #'kill-region)
;; (define-key modalka-mode-map (kbd "D") #'kill-line)
;; (define-key modalka-mode-map (kbd "y") #'kill-ring-save)
;; (define-key modalka-mode-map (kbd "x") #'execute-extended-command)
;; (define-key modalka-mode-map (kbd "s") #'save-buffer)

;; (define-key modalka-mode-map (kbd "p") #'yank)
;; (define-key modalka-mode-map (kbd "P") #'yank-pop)
;; (define-key modalka-mode-map (kbd "o") #'open-line)

;; (define-key modalka-mode-map (kbd "^") #'beginning-of-line)
;; (define-key modalka-mode-map (kbd "$") #'end-of-line)

;; (straight-use-package 'jumplist)
;; (require 'jumplist)
;; (custom-set-variables
;;  '(jumplist-hook-commands
;;    '(dired-jump
;;      isearch-forward
;;      isearch-backward
;;      end-of-buffer beginning-of-buffer
;;      find-file switch-to-buffer
;;      backward-word forward-word
;;      beginning-of-line end-of-line
;;      foward-sexp
;;      backward-sexp
;;      forward-sentence
;;      backward-sentence
;;      golden-ratio-scroll-screen-up
;;      golden-ratio-scroll-screen-down)))

;; (define-key modalka-mode-map (kbd "C-<left>") #'backward-kill-word)
;; (define-key modalka-mode-map (kbd "C-o") #'jumplist-previous)
;; (define-key modalka-mode-map (kbd "C-i") #'jumplist-next)
;; (define-key modalka-mode-map (kbd "<Tab>") #'indent-region)


;; (define-key modalka-mode-map (kbd "/") #'isearch-forward)
;; (define-key modalka-mode-map (kbd "?") #'isearch-backward)

;; (define-key modalka-mode-map (kbd "n") #'isearch-ring-advance)
;; (define-key modalka-mode-map (kbd "N") #'isearch-ring-retreat)

;; (add-hook 'text-mode-hook #'bollu-toggle-modal)
;; (add-hook 'prog-mode-hook #'bollu-toggle-modal)
;; (add-hook 'isearch-mode-hook #'bollu-toggle-modal)



(add-to-list 'auto-mode-alist '("\\.md\\'" . text-mode))
;; nix
(straight-use-package 'nix-mode)

;; dear god no bell prize
(setq visible-bell 1)

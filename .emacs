(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" default))
 '(package-selected-packages
   '(racer flycheck flutter centered-cursor-mode indent-guide vline dumb-jump slime-company slime counsel request all-the-icons lua-mode ranger web-mode evil-collection avy gruvbox-theme evil-org org-bullets emmet-mode rainbow-delimiters company evil-surround projectile evil-magit magit helm linum-relative evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 16777215)) (:background "#282828" :foreground "#fdf4c1")) (((class color) (min-colors 255)) (:background "#262626" :foreground "#ffffaf")))))

;; get rid of the stupid startup screen
(setq inhibit-startup-screen t)
;; fix undo-tree package not found error
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-check-signature nil)
;; install use-package if not installed
;; package archives
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/")
             '("gnu" . "http://elpa.gnu.org/packages/"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; set tabs to 4 spaces
(setq-default tab-width 4)
(setq js-indent-level 4)
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
;; set line numbers
(global-linum-mode 1)
;; overwrite highlighted text
(delete-selection-mode 1)
;; show matching parenthases
(show-paren-mode 1)
;; disable upper bars and scrollbar
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
;; always follow symlinks
(setq vc-follow-symlinks t)
;; y-or-n instead of yes-or-no
(defalias 'yes-or-no-p 'y-or-n-p)
;; all backups to one folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
;; kill current buffer without prompt
(global-set-key (kbd "C-x k") 'kill-this-buffer)
;; disable cursor blink
(blink-cursor-mode 0)
;; treat underscore as part of word
(defun underscore-part-of-word-hook ()
  (modify-syntax-entry ?_ "w"))
(add-hook 'prog-mode-hook 'underscore-part-of-word-hook)
;; kill buffer and window shortcut
(global-set-key (kbd "C-x K") 'kill-buffer-and-window)
;; highlight current line
(global-hl-line-mode)
;; try awesomewm config
(defun try-awesome-config ()
  (interactive)
  (shell-command "Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome"))
(defun try-qtile-config ()
  (interactive)
  (shell-command "/home/mahmooz/workspace/dotfiles/.config/qtile/xephyr.sh 2>&1 > /dev/null"))
;; shortcut to open new eshell buffer
(global-set-key (kbd "C-c s") 'eshell)
;; zap-up-to-char not zap-to-char
(global-set-key (kbd "M-z") 'zap-up-to-char)
;; reload file automatically
(global-auto-revert-mode t)
;; enable all disabled commands
(setq disabled-command-function nil)
;; initial frame size
(when window-system (set-frame-size (selected-frame) 160 48))

;; general keys
(global-set-key (kbd "C-M-S-x") 'eval-region)
(global-set-key (kbd "C-c g") 'counsel-git-grep)

;; no damn fringes dude!
(set-fringe-style 0)

;; js2-mode as major mode for javascript - disabled some keybindings idk why
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-hook 'js2-mode-hook 'js2-mode-hide-warnings-and-errors)
;; (add-hook 'js2-mode-hook 'define-window-switching-keys)

;; shortcuts
(defun open-config-file ()
  (interactive)
  (find-file user-init-file))
(global-set-key (kbd "C-c e") 'open-config-file)

;; handling large files, not very helpful tbh, still slow when loading images

;; evil-mode
(setq evil-want-keybinding nil)
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don"t accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;; relative numbering
(use-package linum-relative
  :ensure t
  :config
  (linum-relative-mode)
  ;; show current line number not '0'
  (setq linum-relative-current-symbol ""))

;; helm
(use-package helm
  :ensure t
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files))

;; magit
(use-package magit
  :ensure t)
(use-package evil-magit
  :ensure t
  :config
  (require 'evil-magit))

;; projectile
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-project-search-path '("~/workspace/" "~/"))
  (projectile-mode +1)
  ;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-globally-ignored-files (append '("*.py" "*.o" "*.so") projectile-globally-ignored-files)))

;; ivy for projectile
;; (use-package ivy
;;   :ensure t)

;; evil-surround for evil mode
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
  (setq company-idle-delay 0)
  (setq company-require-match nil)
  (eval-after-load 'company
    '(progn
       (define-key company-active-map (kbd "TAB") 'company-complete-selection)
       (define-key company-active-map [tab] 'company-complete-selection))))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode)) ;; enable Emmet's css abbreviation.

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(use-package evil-org
  :ensure t)

;; (use-package lsp-mode
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook #'lsp)
;;   (remove-hook 'html-mode-hook #'lsp))

;; (use-package company-lsp
;;  :ensure t)

;; ====== gruvbox
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox))
;; ====== spacemacs
;;(setq spacemacs-theme-comment-bg nil)
;;(setq spacemacs-theme-comment-italic t)
;;(use-package spacemacs-theme
;;  :defer t
;;  :init (load-theme 'spacemacs-dark t))

(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-;") 'avy-goto-char))

(use-package evil-collection
  :ensure t)

;; (use-package ein
;;   :ensure t)

(use-package dart-mode
  :ensure t)

;; (use-package indent-guide
;;   :ensure t
;;   :config
;;   (indent-guide-global-mode)
;;   (setq indent-guide-recursive t))

(use-package web-mode
  :ensure t
  :config
  (setq web-mode-enable-auto-quoting nil)
  (setq web-mode-enable-auto-closing nil)
  (setq web-mode-enable-auto-expanding nil)
  (setq web-mode-enable-auto-pairing nil)
  (setq web-mode-enable-auto-indentation nil)
  (setq web-mode-enable-auto-opening nil)
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

(use-package ranger
  :ensure t)

(use-package lua-mode
  :ensure t
  :config
  (setq lua-indent-level 4))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :config
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))

(use-package request
  :ensure t)

(use-package counsel
  :ensure t
  :config (ivy-mode t))

(use-package slime-company
  :ensure t)

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "sbcl")
  (slime-setup '(slime-company)))

(use-package dumb-jump
  :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package mmm-mode
  :ensure t)

(use-package indent-guide
  :ensure t
  :config
  (indent-guide-global-mode))

(use-package vterm
  :ensure t)

(use-package rust-mode
  :ensure t)

;;(use-package racer
;;  :ensure t
;;  :config
;;  (add-hook 'rust-mode-hook #'racer-mode)
;;  (add-hook 'racer-mode-hook #'eldoc-mode))

;; function to refactor json files
(defun beautify-json ()
  "Function to beautify current buffer considering it is in json format."
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))

;; change region highlight color, set it to black,
;; makes things more visible
(set-face-attribute 'region nil :background "#000")
(set-frame-font "fantasque sans mono 14" nil t)

;; start server
(server-start)

;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
(transparency 95)

;; function to make printing easier for many languages
(defun current-line-to-empty-class ()
  (interactive)
  (if (string= major-mode "python-mode")
      (progn
        (back-to-indentation)
        (insert "class ")
        (end-of-line)
        (insert ":")
        (newline-and-indent)
        (insert "def __init__(self):")
        (newline-and-indent))))
(defun current-line-to-print-statement ()
    (interactive)
    (if (string= major-mode "python-mode")
        (progn
          (back-to-indentation)
          (insert "print(")
          (end-of-line)
          (insert ")")))
    (if (string= major-mode "c-mode")
        (progn
          (back-to-indentation)
          (insert "printf(")
          (end-of-line)
          (insert ");")))
    (if (string= major-mode "emacs-lisp-mode")
        (progn
          (back-to-indentation)
          (insert "(message ")
          (end-of-line)
          (insert ")"))))
(global-set-key (kbd "C-x p") 'current-line-to-print-statement)
(if (string= major-mode "python-mode")
    (message "hi"))

;; c-x c-l to complete line like vim
(defun my-expand-lines ()
  (interactive)
  (let ((hippie-expand-try-functions-list
         '(try-expand-line)))
    (call-interactively 'hippie-expand)))
(define-key evil-insert-state-map (kbd "C-x C-l") 'my-expand-lines)

;; org mode configs
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-log-done 'time)

;; functions for working with images
(defun insert-image-from-file (filepath)
  "insert image from the given filepath"
  (interactive "f")
  (insert-image (create-image filepath 'imagemagick nil :width 200)))

(defun insert-image-from-url (url width height)
  (interactive)
  (unless url (setq url (url-get-url-at-point)))
  (unless url
    (error "Couldn't find URL."))
  (let ((buffer (url-retrieve-synchronously url)))
    (unwind-protect
         (let ((data (with-current-buffer buffer
                       (goto-char (point-min))
                       (search-forward "\n\n")
                       (buffer-substring (point) (point-max)))))
           (insert-image (create-image data 'imagemagick t
                                       :max-width width :max-height height) "i"))
      (kill-buffer buffer))))

(defun insert-image-from-url-no-predefined-size (url)
  (interactive)
  (unless url (setq url (url-get-url-at-point)))
  (unless url
    (error "Couldn't find URL."))
  (let ((buffer (url-retrieve-synchronously url)))
    (unwind-protect
         (let ((data (with-current-buffer buffer
                       (goto-char (point-min))
                       (search-forward "\n\n")
                       (buffer-substring (point) (point-max)))))
           (insert-image (create-image data 'imagemagick t) "i"))
      (kill-buffer buffer))))

;; mouse scroll behavior
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

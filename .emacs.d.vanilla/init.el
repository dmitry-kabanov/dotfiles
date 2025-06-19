;; Initialize `use-package` for automatic package installation.
(require 'package)
(setq package-enable-at-startup nil)

;; Package repositories.
;; Melpa - biggest repository for Emacs.
;; Org-mode has its own repository.
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/")
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Set up the color scheme.
(load-theme 'leuven)

;; Set font.
(set-frame-font "Intel One Mono 16" nil t)

;; Set initial window settings.
(add-to-list 'default-frame-alist '(width . 86))
(add-to-list 'default-frame-alist '(height . 86))

;; Display a vertical line.
(global-display-fill-column-indicator-mode t)
;; Turn on Global Auto Revert minor mode that reverts any buffer
;; associated with a file when the file changes on disk.
(global-auto-revert-mode t)

;; Org-mode configuration.
(use-package org
  ;; set the key for org-mode agenda
  :bind
  (("C-c a" . org-agenda))
  :init
  (add-hook 'org-mode-hook 'fci-mode)
  :config
  ;;file to save todo items
  (setq org-agenda-files (quote ("~/Documents/Notes/todo.org")))
  (setq org-cycle-separator-lines 1)
  )

;(unless (package-installed-p 'evil)
;  (package-install 'evil))
;
;(require 'evil)
 ;(evil-mode 1)

(unless (package-installed-p 'yasnippet)
  (package-install 'yasnippet))
(require 'yasnippet)
(yas-global-mode 1)

(unless (package-installed-p 'projectile)
  (package-install 'projectile))

(require 'projectile)
(projectile-mode 1)

(setq projectile-switch-project-method 'projectile-dired)

(desktop-save-mode 1)

(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(projectile yasnippet-snippets yasnippet org use-package fill-column-indicator)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

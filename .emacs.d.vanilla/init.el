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
(set-default-font "Cousine 14")

;; Set initial window settings.
(setq initial-frame-alist '((width . 86)))

;; Add the melpa package repository
;; Remember to always use HTTPS
;;
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://stable.melpa.org/packages/"))

;; Display a vertical line.
(require 'fill-column-indicator)

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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (org use-package fill-column-indicator))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

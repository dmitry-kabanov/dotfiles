;; Set the color scheme.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load-theme 'leuven)

;; Set font.
(set-default-font "Cousine 18")

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

;; *** Org mode configuration {
;; set the key for org-mode agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;;file to save todo items
(setq org-agenda-files (quote ("~/Documents/Notes/todo.org")))

(add-hook 'org-mode-hook 'fci-mode)
;; }

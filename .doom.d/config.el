;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(if (string-match-p "^keldysh" (system-name))
	(setq user-full-name "Dmitry Kabanov"
		  user-mail-address "dmitry.kabanov@uni-muenster.de")
	(setq user-full-name "Dmitry Kabanov"
		  user-mail-address "kabanov.dmitry@gmail.com"))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

(if (string-match-p "^keldysh" (system-name))
	;; (setq doom-font (font-spec :family "Source Code Pro for Powerline" :size 20 :weight 'medium)
	;;       doom-variable-pitch-font (font-spec :family "Source Code Pro for Powerline" :size 20 :weight 'medium))
	(setq doom-font (font-spec :family "Geist Mono" :size 20 :weight 'medium)
		  doom-variable-pitch-font (font-spec :family "Alegreya" :size 20 :weight 'medium))
	(setq doom-font (font-spec :family "Menlo" :size 16 :weight 'semi-light)
		  doom-variable-pitch-font (font-spec :family "ETBembo" :size 16)))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'leuven)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(if (string-match-p "^keldysh" (system-name))
    (setq org-directory "~/pCloud Drive/Documents/Notes/")
    (setq org-directory "~/Documents/Notes/"))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq doc-view-resolution 400)

(add-to-list 'default-frame-alist '(width . 96))
(add-to-list 'default-frame-alist '(height . 53))
(set-input-method "cyrillic-jcuken")

(after! org
  (setq org-hide-leading-stars nil
        org-startup-indented nil
        org-tags-column -65
        ;; Do not allow org-mode swallow empty lines.
        ;; Docs on org-cycle-separator-lines:
        ;; If the number is negative, and the number of empty lines is at least -N,
        ;; all empty lines are shown.
        org-cycle-separator-lines -1))

(global-display-fill-column-indicator-mode t)
(setq +latex-viewers '(pdf-tools))

;;(setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
;;(setq TeX-view-program-selection '((output-pdf "Evince")))
                                        ; (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
                                        ; (setq TeX-source-correlate-start-server t)

;; (add-hook 'pdf-misc-minor-mode-hook 'pdf-view-roll-minor-mode)

                                        ; (add-hook LaTeX-mode-hook #'xenops-mode)


;; Move by visual lines not logical ones (ending with '\n').
(global-visual-line-mode t)


;; Zen mode settings (centered buffer without any distrations for writing).
(setq writeroom-width 24)

;; Automatically reload files changed on disk.
(global-auto-revert-mode t)

;; Use `shell-escape-mode' for LaTeX Preview Pane minor mode.
;; This variables accepts `nil' or `shell-escape-mode' values.
(after! latex
  (add-hook 'latex-preview-pane-mode-hook
    (lambda()
      (setq-local shell-escape-mode "-shell-escape")
      (setq-local pdf-latex-command "latexmk"))))

(setq org-roam-directory (file-truename "~/pCloud Drive/Documents/Notes/zettelkasten"))

(map! :map cdlatex-mode-map
      :i "TAB" #'cdlatex-tab)

(when (version< emacs-version "30.0")
  (setq major-mode-remap-alist major-mode-remap-defaults))

(flycheck-define-checker vale
  "A checker for prose"
  :command ("vale" "--output" "line"
            source)
  :standard-input nil
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
  :modes (markdown-mode org-mode text-mode)
  )
(add-to-list 'flycheck-checkers 'vale 'append)

(setq ispell-personal-dictionary "~/.aspell.en.pws")

;; For Doom Emacs users - add to your config.el
(defun copy-without-semantic-line-breaks ()
  "Copy the current region (or entire buffer if no region) to clipboard,
removing semantic line breaks while preserving paragraph breaks and Markdown structure."
  (interactive)
  (let* ((text (if (use-region-p)
                   (buffer-substring-no-properties (region-beginning) (region-end))
                 (buffer-substring-no-properties (point-min) (point-max))))
         (processed-text
          (with-temp-buffer
            (insert text)
            (goto-char (point-min))
            ;; Don't join lines that start with Markdown syntax
            (while (re-search-forward "\\([^\n]\\)\n\\([^ \n#*-+>|`]\\)" nil t)
              (replace-match "\\1 \\2"))
            ;; Clean up multiple spaces
            (goto-char (point-min))
            (while (re-search-forward "  +" nil t)
              (replace-match " "))
            ;; Remove trailing spaces
            (goto-char (point-min))
            (while (re-search-forward " +$" nil t)
              (replace-match ""))
            (buffer-string))))
    (kill-new processed-text)
    (message "Copied text without semantic line breaks to clipboard")))

;; Bind globally under SPC (leader key)
;; (map! :leader
;;       :desc "Copy without line breaks" "c w" #'copy-without-semantic-line-breaks)

;; Or bind specifically in markdown mode
(map! :after markdown-mode
      :map markdown-mode-map
      :localleader
      :desc "Copy without line breaks" "c w" #'copy-without-semantic-line-breaks)

(add-hook 'focus-out-hook 'save-buffer)

;; Alternative: bind both globally and in markdown mode
;; (map! :leader
;;       :desc "Copy without line breaks" "c w" #'copy-without-semantic-line-breaks

;;       :after markdown-mode
;;       :map markdown-mode-map
;;       :localleader
;;       :desc "Copy without line breaks" "c w" #'copy-without-semantic-line-breaks)

(use-package! fountain-mode
  :mode "\\.fountain\\'"  ;; Automatically load for .fountain files
  :config
  (add-hook 'fountain-mode-hook (lambda () (display-line-numbers-mode -1) ))
  )
(after! fountain-mode
  (setq fountain-export-scene-heading-format '(bold double-space))
  (setq fountain-export-scene-numbers t)
  (setq fountain-export-title-page t))


(defun my/auto-adjust-visual-fill-column-extra-width (&rest _)
  "Automatically adjust `visual-fill-column-extra-text-width` based on line numbers."
  (if (bound-and-true-p display-line-numbers-mode)
      ;; Get the dynamic width of the line number margin (in columns)
      (setq-local visual-fill-column-width
                  (+ fill-column (line-number-display-width 'columns)))
    ;; Reset if line numbers are toggled off
    (setq-local visual-fill-column-extra-text-width nil)))

;; Run this hook immediately before visual-fill-column adjusts the window margins
(advice-add 'visual-fill-column--adjust-window :before #'my/auto-adjust-visual-fill-column-extra-width)


(add-to-list 'exec-path "/home/dima/sw/miniforge3/envs/jupyter/bin/")

(use-package visual-fill-column
  :ensure t
  :config
  (add-hook 'visual-line-mode-hook #'visual-fill-column-for-vline)
  (setq visual-fill-column-toggle-center-text t)
)

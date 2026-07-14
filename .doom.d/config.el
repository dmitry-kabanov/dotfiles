;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Dmitry Kabanov"
      user-mail-address "kabanov.dmitry@gmail.com")

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
(setq doom-font (font-spec :family "Menlo" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "ETBembo" :size 16))
;;
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
(setq org-directory "~/Documents/Notes/")


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
(after! org
  (setq org-tags-column -65)
  ;; Do not allow org-mode swallow empty lines.
  ;; Docs on org-cycle-separator-lines:
  ;; If the number is negative, and the number of empty lines is at least -N,
  ;; all empty lines are shown.
  (setq org-cycle-separator-lines -1)
)

(add-to-list 'default-frame-alist '(width . 96))
(add-to-list 'default-frame-alist '(height . 53))
(set-input-method "cyrillic-jcuken")

;; (use-package spookfox
;;   :straight
;;   (spookfox :type git
;;             :host github
;;             :repo "bitspook/spookfox"
;;             :files ("lisp/*.el" "lisp/apps/*.el"))
;;   :config
;;   (spookfox-init))
;; (require 'spookfox-org-tabs)
;; (require 'spookfox-tabs)
;; (require 'spookfox-js-injection)
;; (setq spookfox-enabled-apps (list spookfox-org-tabs spookfox-tabs spookfox-js-injection))
;; (setq spookfox-debug t)
;; (setq spookfox-debug t)
;; (spookfox-init)
;; (defun my-org-babel-execute:js-spookfox (old-fn body params)
;;   "Maybe execute Spookfox."
;;   (if (assq :spookfox params)
;;       (spookfox-js-injection-eval-in-active-tab
;;        body t)
;;     (funcall old-fn body params)))
;; (with-eval-after-load 'ob-js
;;   (advice-add 'org-babel-execute:js :around #'my-org-babel-execute:js-spookfox))

;; (use-package spookfox
;;   :straight
;;   (spookfox :type git
;;             :host github
;;             :repo "bitspook/spookfox"
;;             :files ("lisp/*.el" "lisp/apps/*.el"))
;;   :config
;;   (spookfox-init))

;; (require 'spookfox-tabs)
;; (setq spookfox-enabled-apps '(spookfox-org-tabs))
;; (spookfox-init)

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

(add-hook 'visual-line-mode-hook #'visual-fill-column-for-vline)

;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
;;;
(setq user-full-name "Saulo Toshiichi Furuta" user-email-address "hi@saulo.dev")

;;; Go to window on vsplit
(setq evil-split-window-below t evil-vsplit-window-right t)

;; Theme
(setq doom-theme 'doom-vibrant
      doom-font (font-spec :family "Iosevka SS03" :size 14)
      doom-variable-pitch-font (font-spec :family "Iosevka SS03"))


(after! org
  (load! "+my-org"))

;; Custom fn for pasting image
;;

(defun sxd/toggle-message-popup()
  "Toggle buffer with messages."
  (interactive)
  (cond ((+popup-windows) (+popup/close-all t))
        ((display-buffer (get-buffer "*Messages*")))))

(defvar sxd/kustom-keymap (make-sparse-keymap))

(map! :map sxd/kustom-keymap
      "a" '+fold/toggle
      "m" 'sxd/toggle-message-popup
)

(map! :leader
      :desc "Kustom" "k" sxd/kustom-keymap)

;; Packages
;;; Evil mode
(setq backward-delete-char-untabify-method 'hungry custom-tab-width 2)
;;
;; moves to set tab width value
(setq-default evil-shift-width custom-tab-width)
(setq-default evil-shift-round custom-tab-width)
(setq-default tab-width 2 standard-indent 2)

(after! evil
  (map! :n "j" #'evil-next-visual-line
        :n "k" #'evil-previous-visual-line))

;; _ as part of word_
(add-hook 'after-change-major-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

;; Company
;;
(setq company-idle-delay 0.3
      company-minimum-prefix-length 3
      company-tooltip-limit 10)

(after! robe (set-company-backend! 'ruby-mode '(company-dabbrev company-robe)))
(after! org (set-company-backend! 'org-mode '(company-org-roam company-capf company-dabbrev company-yasnippet company-ispell)))

;;; Typescript
(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log")
      tide-tsserver-flags '("--serverMode partialSemantic" "--useInferredProjectPerProjectRoot"))
;; (setq-hook! 'ruby-mode-hook +format-with-lsp nil)

;; Ruby
(add-hook 'ruby-mode-hook (lambda () (rvm-activate-corresponding-ruby)))

;;; Hacks and fixes
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; Neotree
(defun sxd/split-v-and-window-resize(&rest args)
  (apply 'neo-open-file-vertical-split args)
  (balance-windows))

(after! neotree
  (map! :map neotree-mode-map
        :m "h"   #'+neotree/collapse-or-up
        :m "l"   #'+neotree/expand-or-open
        :n "J"   #'neotree-select-next-sibling-node
        :n "K"   #'neotree-select-previous-sibling-node
        :n "H"   #'neotree-select-up-node
        :n "L"   #'neotree-select-down-node
        :n "v"   (neotree-make-executor :file-fn 'sxd/split-v-and-window-resize)))

;; Flycheck
(after! flycheck
  (setq flycheck-check-syntax-automatically '(mode-enabled save))
  (setq-default flycheck-disabled-checkers '(ruby-reek))
  (setq flycheck-disabled-checkers '(ruby-reek)))

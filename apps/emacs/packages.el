;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
;; (package! ob-typescript)

;; (package! exec-path-from-shell)

;; Claude Code IDE - integrates Claude Code CLI with Emacs
(package! claude-code-ide
  :recipe (:host github :repo "manzaltu/claude-code-ide.el"))

;; Pixel-accurate table alignment for markdown and org buffers
(package! valign)

;; View Large Files in chunks (e.g. multi-MB .jsonl manifests) without
;; hanging Emacs. Open with M-x vlf.
(package! vlf)

;;; ~/.dotfiles/emacs/+my-org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org"
      org-agenda-files (list "~/org/roam" "~/org/journal" "~/org/mobile")
      org-roam-directory "~/org/roam"
      org-src-tab-acts-natively t
      org-tag-alist '(("read" . ?r) ("urgent" . ?u) ("not_urgent" . ?U) ( "important" . ?i) ("not_important" . ?I)))

;; Templates for SPC-n-n
(after! org-capture
  (let
      (
       ;; Important TODOs do as fast as possible
       (todo-entries '(
                       ("t" "TODO" entry (file+headline "./roam/inbox.org" "PLEASE CLASSIFY EVERY TASK HERE") "* TODO %u %?" :prepend t :empty-lines 1 :kill-buffer t)
                     ))

       (journal-entries '(
                          ("j" "Journal" entry (file+headline "./roam/inbox.org" "Notes")
                           "* %? \n%a" :empty-lines 1)
                          ))
       (experimenting '(
                        ;; Maybe adding some capture to build stack knowledge
                        ;; https://200ok.ch/posts/org-mode-capture-template-for-code-snippets.html
                        ("s" "clock entry" entry (clock) "* %?\n%(ha/org-capture-code-snippet \"%F\")" :empty-lines 1)
                        ("e" "clock plain" plain (clock) "%?\n%(ha/org-capture-code-snippet \"%F\")" :empty-lines 1)
                        ("x" "cl: snipx" plain (file+headline "./roam/inbox.org" "Eng") "%?\n%(ha/org-capture-code-snippet \"%F\")" :empty-lines 1)
                      ))

       ;; Just for reference
       (local-project-notes '(
                              ("p" "Templates for projects")
                                ;; Will use {project-root}/{todo,notes,changelog}.org, unless a
                                ;; {todo,notes,changelog}.org file is found in a parent directory.

                              ("pt" "Project todo" entry    ; {project-root}/todo.org
                               (file+headline +org-capture-project-todo-file "Inbox") "* TODO %?\n%i" :prepend t :kill-buffer t)
                              ("pn" "Project notes" entry   ; {project-root}/notes.org
                               (file+headline +org-capture-project-notes-file "Inbox") "* TODO %?\n%i" :prepend t :kill-buffer t)
                              ("pc" "Project changelog" entry ; {project-root}/changelog.org
                               (file+headline +org-capture-project-notes-file "Unreleased")
                               "* TODO %?\n%i" :prepend t :kill-buffer t)

                              ))
       )

    (setq org-capture-templates (append todo-entries experimenting journal-entries))))

(org-babel-do-load-languages 'org-babel-load-languages '((typescript . t)))

;; https://gitlab.com/howardabrams/spacemacs.d/-/blob/master/layers/ha-org/funcs.el#L367
;; http://howardism.org/Technical/Emacs/capturing-content.html
(defun ha/org-capture-code-snippet (f)
  "Given a file, F, this captures the currently selected text
within an Org SRC block with a language based on the current mode
and a backlink to the function and the file."
  (with-current-buffer (find-buffer-visiting f)
    (let ((org-src-mode (replace-regexp-in-string "-mode" "" (format "%s" major-mode)))
          (func-name (which-function)))
      (ha/org-capture-fileref-snippet f "SRC" org-src-mode func-name))))
(defun ha/org-capture-clip-snippet (f)
  "Given a file, F, this captures the currently selected text
within an Org EXAMPLE block and a backlink to the file."
  (with-current-buffer (find-buffer-visiting f)
    (ha/org-capture-fileref-snippet f "EXAMPLE" "" nil)))

(defun ha/org-capture-fileref-snippet (f type headers func-name)
  (let* ((code-snippet
          (buffer-substring-no-properties (mark) (- (point) 1)))
         (file-name   (buffer-file-name))
         (file-base   (file-name-nondirectory file-name))
         (line-number (line-number-at-pos (region-beginning)))
         (initial-txt (if (null func-name)
                          (format "From [[file:%s::%s][%s]]:"
                                  file-name line-number file-base)
                        (format "From ~%s~ (in [[file:%s::%s][%s]]):"
                                func-name file-name line-number
                                file-base))))
    (format "
%s
#+BEGIN_%s %s
%s
#+END_%s" initial-txt type headers code-snippet type)))

(defun toa/print-org-outline-path (l)
  (org-format-outline-path (org-get-outline-path) l nil " > "))

(setq org-agenda-custom-commands
  '(
     ("r" "Reading"
       (
         (tags-todo "read" (
                             (org-agenda-overriding-header "\nPending reading")
                             (org-agenda-remove-tags t)
                             (org-agenda-todo-keyword-format "")
                             (org-agenda-prefix-format
                               " %i %?-25(toa/print-org-outline-path 25) % s % e")))
         ))
     ("z" "Eisenheuer Matrix"
       (
         (tags-todo "-important-urgent-not_urgent-not_important-read-idea" (
                                                                        (org-agenda-overriding-header "\n⚠️ Uncategorized\n")
                                                                        (org-agenda-remove-tags t)
                                                                        (org-agenda-todo-keyword-format "")
                                                                        (org-agenda-prefix-format
                                                                          " %i %?-25(toa/print-org-outline-path 25) % s % e")))
         (tags-todo "urgent+important" (
                                         (org-agenda-overriding-header "\n🔥 Urgent + ⭐ ️Important")
                                         (org-agenda-remove-tags t)
                                         (org-agenda-todo-keyword-format "")
                                         (org-agenda-prefix-format
                                           " %i %?-25(toa/print-org-outline-path 25) % s % e")))
         (tags-todo "urgent+not_important" (
                                             (org-agenda-overriding-header "\n🔥 Urgent + NOT ️important")
                                             (org-agenda-remove-tags t)
                                             (org-agenda-todo-keyword-format "")
                                             (org-agenda-prefix-format
                                               " %i %?-25(toa/print-org-outline-path 25) % s % e")))
         (tags-todo "not_urgent+important" (
                                             (org-agenda-overriding-header "\nNOT Urgent + ⭐ ️important")
                                             (org-agenda-remove-tags t)
                                             (org-agenda-todo-keyword-format "")
                                             (org-agenda-prefix-format
                                               " %i %?-25(toa/print-org-outline-path 25) % s % e")))

         (tags-todo "not_urgent+not_important" (
                                                 (org-agenda-overriding-header "\nNOT Urgent + NOT ️important")
                                                 (org-agenda-remove-tags t)
                                                 (org-agenda-todo-keyword-format "")
                                                 (org-agenda-prefix-format
                                                   " %i %?-25(toa/print-org-outline-path 25) % s % e")))

         ))))

(defun sxd/eisenhower-matrix-agenda-view (&optional arg) (interactive) (org-agenda arg "z"))

(defun sxd/reading-agenda-view (&optional arg) (interactive) (org-agenda arg "r"))

(defun sxd/clipboard-image (file-name)
  "Paste image asking for file name, defaults with timestamp name."
  (interactive (list (read-string
                      (format "Img name (default: %s) " (format-time-string "%Y-%m-%d_%H-%M-%S.png"))
                      nil
                      nil
                      (format-time-string "%Y-%m-%d_%H-%M-%S.png"))))

  (let ((absolute-file-name (concat org-directory "/images/" file-name)))
    (shell-command (concat "pngpaste " absolute-file-name))
    (insert "#+ATTR_ORG: :width 400\n")
    (insert (concat "[[" absolute-file-name "]]"))
    (org-display-inline-images)))

(defun sxd/remove-image ()
  "Remove file associated with link, if file exists."
  (interactive)
  (if (org-in-regexp org-link-bracket-re 1)
      (let ((image-path (match-string 1)))
        (if (file-exists-p image-path)
            (delete-file image-path))
        (kill-whole-line)
        )))

(map! :when (featurep! :lang org)
      (:map sxd/kustom-keymap
       "p" 'sxd/clipboard-image
       "k" 'sxd/remove-image))

(map! :map sxd/kustom-keymap
      "z" 'sxd/eisenhower-matrix-agenda-view
      "r" 'sxd/reading-agenda-view)


(require 'org-inlinetask)

(defun scimax/org-return (&optional ignore)
  "Add new list item, heading or table row with RET.
A double return on an empty element deletes it.
Use a prefix arg to get regular RET. "
  (interactive "P")
  (if ignore
      (org-return)
    (cond

     ((eq 'line-break (car (org-element-context)))
      (org-return-indent))

     ;; Open links like usual, unless point is at the end of a line.
     ;; and if at beginning of line, just press enter.
     ((or (and (eq 'link (car (org-element-context))) (not (eolp)))
          (bolp))
      (org-return))

     ;; It doesn't make sense to add headings in inline tasks. Thanks Anders
     ;; Johansson!
     ((org-inlinetask-in-task-p)
      (org-return))

     ;; checkboxes too
     ((org-at-item-checkbox-p)
      (org-insert-todo-heading nil))

     ;; lists end with two blank lines, so we need to make sure we are also not
     ;; at the beginning of a line to avoid a loop where a new entry gets
     ;; created with only one blank line.
     ((org-in-item-p)
      (if (save-excursion (beginning-of-line) (org-element-property :contents-begin (org-element-context)))
          (org-insert-heading)
        (beginning-of-line)
        (delete-region (line-beginning-position) (line-end-position))
        (org-return)))

     ;; org-heading
     ((org-at-heading-p)
      (if (not (string= "" (org-element-property :title (org-element-context))))
          (progn (org-end-of-meta-data)
                 (org-insert-heading-respect-content)
                 (outline-show-entry))
        (beginning-of-line)
        (setf (buffer-substring
               (line-beginning-position) (line-end-position)) "")))

     ;; tables
     ((org-at-table-p)
      (if (-any?
           (lambda (x) (not (string= "" x)))
           (nth
            (- (org-table-current-dline) 1)
            (org-table-to-lisp)))
          (org-return)
        ;; empty row
        (beginning-of-line)
        (setf (buffer-substring
               (line-beginning-position) (line-end-position)) "")
        (org-return)))

     ;; fall-through case
     (t
      (org-return)))))

(map! :after evil-org
      :map evil-org-mode-map
      :i "RET" #'scimax/org-return)

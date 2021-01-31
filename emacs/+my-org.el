;;; ~/.dotfiles/emacs/+my-org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org"
      org-agenda-files (list "~/org/roam" "~/org/journal")
      org-roam-directory "~/org/roam"
      org-src-tab-acts-natively t
      org-tag-alist '(("urgent" . ?u) ("not_urgent" . ?U) ( "important" . ?i) ("not_important" . ?I)))

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

    (setq org-capture-templates (append todo-entries journal-entries))))

(defun toa/print-org-outline-path (l)
  (org-format-outline-path (org-get-outline-path) l nil " > "))

(setq org-agenda-custom-commands
      '(
        ;; What I want
        ("z" "Eisenheuer Matrix"
         (
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

          (tags-todo "-important-urgent-not_urgent-not_important" (
                                                                   (org-agenda-overriding-header "\n⚠️ Uncategorized\n")
                                                                   (org-agenda-remove-tags t)
                                                                   (org-agenda-todo-keyword-format "")
                                                                   (org-agenda-prefix-format
                                                                    " %i %?-25(toa/print-org-outline-path 25) % s % e")))
          (tags "+TODO=\"DONE\"+CLOSED>\"<-1d>\""
                ((org-agenda-overriding-header "DONE/CLOSED in the last 24h")
                 (org-agenda-todo-keyword-format "%+4s")
                 (org-agenda-prefix-format
                  " %i %?-30(toa/print-org-outline-path 30) % s")
                 ))
          ))))

(defun sxd/eisenhower-matrix-agenda-view (&optional arg) (interactive) (org-agenda arg "z"))

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
      "z" 'sxd/eisenhower-matrix-agenda-view)

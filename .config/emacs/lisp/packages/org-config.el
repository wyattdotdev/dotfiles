;;; -*- lexical-binding: t; -*-

;; Named org-config, not org: lisp/packages is on load-path, so an org.el here
;; would shadow the real org library.

;; Vim-style org editing: o/O continue items, < > promote/demote, agenda j/k
(use-package evil-org
  :after (evil org)
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(with-eval-after-load 'evil
  (evil-define-key 'normal 'global (kbd "<leader>oa") #'org-agenda)
  (evil-define-key 'normal 'global (kbd "<leader>oc") #'org-capture))

(with-eval-after-load 'org
  ;; org-mode-map inherits evil-collection-outline's C-j/C-k (heading nav),
  ;; which overrides 'global.  Restore window navigation (gj/gk still navigate).
  (evil-define-key 'normal org-mode-map
    (kbd "C-j") #'windmove-down
    (kbd "C-k") #'windmove-up)

  (evil-define-key 'normal org-mode-map
    (kbd "<leader>ot") #'org-todo
    (kbd "<leader>ol") #'org-insert-link
    (kbd "<leader>oo") #'org-open-at-point
    (kbd "<leader>os") #'org-schedule
    (kbd "<leader>od") #'org-deadline
    (kbd "<leader>oe") #'org-export-dispatch))

(provide 'org-config)

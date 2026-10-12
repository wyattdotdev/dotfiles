;;; -*- lexical-binding: t; -*-

;; JSON — disable prettification/folding of strings
(add-hook 'json-ts-mode-hook (lambda () (setq-local prettify-symbols-mode nil)))

;; Auto-create parent directories on save
(defun auto-create-parent-dirs ()
  (let ((dir (file-name-directory buffer-file-name)))
    (when (and dir (not (file-exists-p dir)))
      (make-directory dir t))))
(add-hook 'before-save-hook #'auto-create-parent-dirs)

;; Close certain buffers with q
(defun close-with-q-setup ()
  (local-set-key (kbd "q") #'quit-window))
(dolist (mode '(help-mode-hook
                compilation-mode-hook
                special-mode-hook))
  (add-hook mode #'close-with-q-setup))

;; Resize windows evenly when frame is resized
(add-hook 'window-configuration-change-hook #'balance-windows)

;; Reload elisp files on save
(defun reload-elisp-on-save ()
  (when (string-match-p (expand-file-name "emacs-port" (file-name-directory user-emacs-directory))
                        (or buffer-file-name ""))
    (load-file buffer-file-name)
    (message "Configuration reloaded: %s" buffer-file-name)))
(add-hook 'after-save-hook #'reload-elisp-on-save)

(provide 'autocommands)

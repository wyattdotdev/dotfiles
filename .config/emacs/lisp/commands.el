;;; -*- lexical-binding: t; -*-

;; Prettier
(defvar custom-prettier-config nil)

(defun set-prettier-config (config)
  (interactive "sConfig filename: ")
  (setq custom-prettier-config config))

(defun run-prettier ()
  (interactive)
  (let* ((prettier-filename (or custom-prettier-config ".prettierrc"))
         (current-file (buffer-file-name))
         (root-dir (locate-dominating-file current-file ".git"))
         (config-file (or (when root-dir
                            (let ((f (expand-file-name prettier-filename root-dir)))
                              (when (file-exists-p f) f)))
                          (expand-file-name "prettier.json" user-emacs-directory)))
         (cmd (format "prettier --config \"%s\" \"%s\" --write" config-file current-file)))
    (if (= 0 (shell-command cmd))
        (revert-buffer t t)
      (message "Prettier error"))))

;; Buffer cycling — skip non-file and special buffers (vterm allowed through)
(defun my/skippable-buffer-p ()
  (not (or (buffer-file-name) (derived-mode-p 'vterm-mode))))

(defun my/prev-file-buffer ()
  (interactive)
  (let ((start (current-buffer)))
    (previous-buffer)
    (while (and (not (eq (current-buffer) start))
                (my/skippable-buffer-p))
      (previous-buffer))))

(defun my/next-file-buffer ()
  (interactive)
  (let ((start (current-buffer)))
    (next-buffer)
    (while (and (not (eq (current-buffer) start))
                (my/skippable-buffer-p))
      (next-buffer))))

;; Hex / Dec / Bin conversions
(defun hex-to-dec (hex)
  (interactive "sHex value: ")
  (message "Decimal value: %d" (string-to-number hex 16)))

(defun dec-to-bin (dec)
  (interactive "sDecimal value: ")
  (message "Binary value: %b" (string-to-number dec)))

;; LaTeX comment — add % to end of each line in region
(defun latex-comment-region (start end)
  (interactive "r")
  (save-excursion
    (goto-char start)
    (while (< (point) end)
      (end-of-line)
      (unless (or (bolp) (eq (char-before) ?%))
        (insert "%"))
      (forward-line 1))))

(provide 'commands)

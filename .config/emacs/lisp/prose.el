;;; -*- lexical-binding: t; -*-

(defun prose-mode ()
  (interactive)
  (visual-line-mode (if visual-line-mode -1 1)))

(dolist (hook '(markdown-mode-hook latex-mode-hook))
  (add-hook hook #'visual-line-mode))

(provide 'prose)

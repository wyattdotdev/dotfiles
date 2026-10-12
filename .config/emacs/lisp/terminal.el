;; -*- lexical-binding: t; -*-

(use-package vterm
  :commands (vterm vterm-mode)
  :config
  (setq vterm-shell (getenv "SHELL"))
  (setq vterm-max-scrollback 10000)
  (setq vterm-timer-delay 0.01))

(defun split-term ()
  (interactive)
  (split-window-below)
  (other-window 1)
  (vterm))

(defun fullscreen-term ()
  (interactive)
  (vterm)
  (delete-other-windows))

;;; VSCode-style toggleable bottom terminal ----------------------------------
;;
;; The terminal lives in a *side window* at the bottom of the frame.  Side
;; windows are not part of the normal window tree, so `delete-other-windows'
;; (<leader>wf) and friends leave the layout above it untouched.  C-` shows or
;; hides it; the vterm buffer itself survives hiding, so scrollback and any
;; running process persist.

(defvar my/terminal-height 0.3
  "Height of the toggled terminal, as a fraction of the frame.")

(defun my/terminal--root ()
  "Project root of the current buffer, or nil."
  (when-let* ((proj (project-current nil)))
    (project-root proj)))

(defun my/terminal--buffer-name ()
  "Name of the terminal buffer for the current project."
  (if-let* ((root (my/terminal--root)))
      (format "*term %s*" (file-name-nondirectory (directory-file-name root)))
    "*term*"))

(defun my/terminal-toggle ()
  "Show or hide a bottom-split terminal for the current project."
  (interactive)
  (let* ((name (my/terminal--buffer-name))
         (win  (and (get-buffer name) (get-buffer-window name))))
    (if win
        (delete-window win)
      (let* ((dir (or (my/terminal--root) default-directory))
             (buf (or (get-buffer name)
                      (with-current-buffer (get-buffer-create name)
                        (setq default-directory dir)
                        (current-buffer)))))
        (select-window
         (display-buffer-in-side-window
          buf
          `((side . bottom)
            (slot . 0)
            (window-height . ,my/terminal-height)
            (window-parameters . ((no-delete-other-windows . t))))))
        ;; vterm sizes its pty from the selected window, so the shell must not
        ;; be started until the buffer is displayed AND selected -- this is the
        ;; order `vterm--internal' uses.  Starting it in an undisplayed buffer
        ;; sizes the terminal against whatever window happened to be current.
        (with-current-buffer buf
          (unless (derived-mode-p 'vterm-mode)
            (vterm-mode)))
        (when (fboundp 'evil-insert-state)
          (evil-insert-state))))))

;;; Escape handling ----------------------------------------------------------

(defvar vterm--last-escape-time 0
  "Time of the last <escape> press sent to vterm.")

(defun vterm-escape-or-normal-state ()
  "Send <escape> to vterm immediately; a second press within 0.3s also enters evil-normal-state.
Passing ESC straight through avoids Emacs holding the first press waiting for a literal
`<escape><escape>' sequence, which broke ESC for programs like vim running inside vterm."
  (interactive)
  (vterm-send-escape)
  (let ((now (float-time)))
    (if (< (- now vterm--last-escape-time) 0.3)
        (evil-normal-state)
      (setq vterm--last-escape-time now))))

;;; Keybindings --------------------------------------------------------------

;; Global, in every state, so it works from the editor and from inside the
;; terminal.  C-~ (C-S-`) is bound too since some keyboards/terminals send it.
(global-set-key (kbd "C-`") #'my/terminal-toggle)
(global-set-key (kbd "C-~") #'my/terminal-toggle)

(with-eval-after-load 'evil
  (evil-define-key 'normal 'global (kbd "<leader>wt") #'fullscreen-term)
  (evil-define-key 'normal 'global (kbd "<leader>wT") #'split-term)
  (evil-define-key 'normal 'global (kbd "<leader>tt") #'my/terminal-toggle))

;; vterm sends almost every key to the shell; claim C-` back for the toggle.
;; vterm-mode-map only exists once vterm is loaded, so bind it here.
(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "C-`") #'my/terminal-toggle)
  (define-key vterm-mode-map (kbd "C-~") #'my/terminal-toggle)
  (with-eval-after-load 'evil
    (evil-define-key 'insert vterm-mode-map (kbd "<escape>") #'vterm-escape-or-normal-state)))

;; No line numbers in terminal
(add-hook 'vterm-mode-hook (lambda ()
  (display-line-numbers-mode -1)
  (setq-local scroll-margin 0)))

(provide 'terminal)

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

(defun split-term-vertical ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (vterm))

(defun new-term ()
  "Open a fresh vterm buffer in the current window."
  (interactive)
  (vterm t))

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

;;; Mouse-wheel scrolling for TUIs ---------------------------------------------
;;
;; vterm never forwards mouse events, so apps that scroll their own view on
;; the wheel (Claude Code, tmux with `mouse on', vim) can't be scrolled.  Send
;; the SGR wheel sequences by hand.  vterm doesn't know whether the app asked
;; for the mouse, so at a plain shell prompt these just type junk.

(defun my/vterm-wheel-up ()
  "Send a mouse wheel-up event to the terminal."
  (interactive)
  (process-send-string vterm--process "\e[<64;1;1M"))

(defun my/vterm-wheel-down ()
  "Send a mouse wheel-down event to the terminal."
  (interactive)
  (process-send-string vterm--process "\e[<65;1;1M"))

;;; Keybindings --------------------------------------------------------------

;; Global, in every state, so it works from the editor and from inside the
;; terminal.  C-~ (C-S-`) is bound too since some keyboards/terminals send it.
(global-set-key (kbd "C-`") #'my/terminal-toggle)
(global-set-key (kbd "C-~") #'my/terminal-toggle)

(with-eval-after-load 'evil
  (evil-define-key 'normal 'global (kbd "<leader>wtf") #'fullscreen-term)
  (evil-define-key 'normal 'global (kbd "<leader>wtn") #'new-term)
  (evil-define-key 'normal 'global (kbd "<leader>wth") #'split-term)
  (evil-define-key 'normal 'global (kbd "<leader>wtv") #'split-term-vertical)
  (evil-define-key 'normal 'global (kbd "<leader>wT") #'split-term)
  (evil-define-key 'normal 'global (kbd "<leader>tt") #'my/terminal-toggle))

;; vterm sends almost every key to the shell; claim C-` back for the toggle.
;; vterm-mode-map only exists once vterm is loaded, so bind it here.
(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "C-`") #'my/terminal-toggle)
  (define-key vterm-mode-map (kbd "C-~") #'my/terminal-toggle)
  (with-eval-after-load 'evil
    (evil-define-key 'insert vterm-mode-map (kbd "<escape>") #'vterm-escape-or-normal-state)
    (evil-define-key 'insert vterm-mode-map (kbd "M-]") #'my/vterm-wheel-up)
    (evil-define-key 'insert vterm-mode-map (kbd "M-'") #'my/vterm-wheel-down)))

;;; Scrolling ------------------------------------------------------------------
;;
;; vterm snaps the window back to the cursor on every redraw, so scrolling
;; while a TUI is updating gets undone immediately.  Freeze the buffer with
;; `vterm-copy-mode' whenever we're in normal state, and thaw it on insert.

(defun my/vterm--enter-copy-mode ()
  (when (and (derived-mode-p 'vterm-mode) (not vterm-copy-mode))
    (vterm-copy-mode 1)))

(defun my/vterm--exit-copy-mode ()
  (when (and (derived-mode-p 'vterm-mode) vterm-copy-mode)
    (vterm-copy-mode -1)))

(with-eval-after-load 'evil
  (add-hook 'vterm-mode-hook
            (lambda ()
              (add-hook 'evil-normal-state-entry-hook #'my/vterm--enter-copy-mode nil t)
              (add-hook 'evil-insert-state-entry-hook #'my/vterm--exit-copy-mode nil t))))

;; No line numbers in terminal.  Claude Code blinks U+23FA while running
;; tools; RobotoMono lacks it, so Emacs falls back to a taller emoji font and
;; the rows below jump on every blink.  Draw it as a bullet the font has.
(add-hook 'vterm-mode-hook (lambda ()
  (display-line-numbers-mode -1)
  (setq-local scroll-margin 0)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table #x23FA (vector ?•))))

(provide 'terminal)

;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'evil
  ;; Leader key
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))

  ;; Window navigation
  (evil-define-key 'normal 'global (kbd "C-j") #'windmove-down)
  (evil-define-key 'normal 'global (kbd "C-h") #'windmove-left)
  (evil-define-key 'normal 'global (kbd "C-k") #'windmove-up)
  (evil-define-key 'normal 'global (kbd "C-l") #'windmove-right)
  (evil-define-key 'normal 'global (kbd "C-r") #'evil-window-rotate-downwards)

  ;; Move selected lines up/down
  (evil-define-key 'visual 'global (kbd "K") (kbd ":m '<-2<CR>gv=gv"))
  (evil-define-key 'visual 'global (kbd "J") (kbd ":m '>+1<CR>gv=gv"))

  ;; Yank into system clipboard
  (evil-define-key '(normal visual) 'global (kbd "<leader>y") (kbd "\"+y"))

  ;; Buffer / tab navigation
  (evil-define-key 'normal 'global (kbd "H") #'my/prev-file-buffer)
  (evil-define-key 'normal 'global (kbd "L") #'my/next-file-buffer)

  ;; Buffer keybindings
  (evil-define-key 'normal 'global (kbd "<leader>bd") #'kill-current-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>bD")
    (lambda () (interactive) (kill-buffer (current-buffer))))
  (evil-define-key 'normal 'global (kbd "<leader>bs") #'scratch-buffer)

  ;; Window keybindings
  (evil-define-key 'normal 'global (kbd "<leader>wf") #'delete-other-windows)
  (evil-define-key 'normal 'global (kbd "<leader>wF") #'balance-windows)
  (evil-define-key 'normal 'global (kbd "<leader>wh") #'split-window-below)
  (evil-define-key 'normal 'global (kbd "<leader>wv") #'split-window-right)
  (evil-define-key 'normal 'global (kbd "<leader>wx") #'delete-window)
  (evil-define-key 'normal 'global (kbd "<leader>wX") #'delete-window)

  ;; Window resize
  (evil-define-key 'normal 'global (kbd "C-.") (lambda () (interactive) (enlarge-window 5)))
  (evil-define-key 'normal 'global (kbd "C-,") (lambda () (interactive) (shrink-window 5)))
  (evil-define-key 'normal 'global (kbd "<leader><") (lambda () (interactive) (shrink-window-horizontally 5)))
  (evil-define-key 'normal 'global (kbd "<leader>>") (lambda () (interactive) (enlarge-window-horizontally 5)))

  ;; Help (C-h is rebound to windmove-left)
  (evil-define-key 'normal 'global (kbd "<leader>h") help-map)

  ;; Reload config
  (evil-define-key 'normal 'global (kbd "<leader>sc")
    (lambda () (interactive) (load-file (expand-file-name "init.el" user-emacs-directory)))))

;; outline-minor-mode runs on all prog-mode buffers (options.el).
;; evil-collection-outline copies outline-mode-map into outline-minor-mode's
;; evil keymap, which overrides 'global.  Rebind via evil-define-minor-mode-key.
(with-eval-after-load 'evil-collection-outline
  (evil-define-minor-mode-key 'normal 'outline-minor-mode (kbd "C-j") #'windmove-down)
  (evil-define-minor-mode-key 'normal 'outline-minor-mode (kbd "C-k") #'windmove-up))

(provide 'keybindings)

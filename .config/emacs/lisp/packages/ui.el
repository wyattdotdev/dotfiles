;; -*- lexical-binding: t; -*-

;; Evil (vim emulation)
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;; Colorscheme
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(load-theme 'rasmus t)

;; Buffer tabs (built-in tab-bar-mode)
(tab-bar-mode 1)
(setq tab-bar-new-button-show nil
      tab-bar-close-button-show nil)
(with-eval-after-load 'evil
  (evil-define-key 'normal 'global (kbd "<leader>bp") #'tab-bar-mode)
  (evil-define-key 'normal 'global (kbd "<leader>bo") #'tab-bar-close-other-tabs))

;; File explorer — dired configured oil-style (single buffer, current dir)
(use-package dired
  :ensure nil
  :config
  (if (executable-find "gls")
      (setq insert-directory-program "gls"
            dired-listing-switches "-alh --group-directories-first")
    (setq dired-listing-switches "-alh"))
  (setq dired-kill-when-opening-new-dired-buffer t)
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global (kbd "-") #'dired-jump)
    (evil-define-key 'normal dired-mode-map
      (kbd "RET") #'dired-find-alternate-file
      (kbd "-") #'dired-up-directory)))

;; Fuzzy finder (telescope equivalent)
(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :config
  (defun my/consult-buffer-sort (buffers)
    "Sort BUFFERS by recency, like `consult--buffer-sort-visibility',
but keep *starred* buffers (e.g. *Messages*, *scratch*, *vterm*) after
buffers you've actually opened."
    (seq-sort-by (lambda (buf) (if (string-prefix-p "*" (buffer-name buf)) 1 0))
                 #'<
                 (consult--buffer-sort-visibility buffers)))
  (plist-put consult-source-buffer :items
             (lambda ()
               (consult--buffer-query :sort nil
                                       :as #'consult--buffer-pair
                                       :buffer-list (my/consult-buffer-sort (buffer-list)))))

  (defun my/consult-buffer ()
    "`consult-buffer', starting in evil normal state."
    (interactive)
    (letrec ((hook (lambda ()
                      (evil-normal-state)
                      (remove-hook 'minibuffer-setup-hook hook))))
      (add-hook 'minibuffer-setup-hook hook 100))
    (consult-buffer))

  (defun my/vertico-kill-buffer-candidate ()
    "Kill the buffer at point in a vertico completion list, staying in the minibuffer."
    (interactive)
    ;; consult-buffer's candidate list is computed once up front (not
    ;; re-queried per keystroke) and tags each candidate with an invisible
    ;; "tofu" character marking its source, so re-triggering vertico's normal
    ;; update path won't drop a killed buffer. Splice it out of vertico's
    ;; in-memory candidate list directly instead.
    (let* ((cand (nth vertico--index vertico--candidates))
           (buf (and cand (consult--tofu-strip cand))))
      (when (and buf (get-buffer buf))
        (kill-buffer buf)
        (setq vertico--candidates (delete cand vertico--candidates)
              vertico--total (length vertico--candidates))
        (vertico--goto vertico--index)
        (vertico--exhibit))))

  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global (kbd "<leader>ff") #'consult-find)
    (evil-define-key 'normal 'global (kbd "<leader>SPC") #'my/consult-buffer)
    (evil-define-key 'normal 'global (kbd "<leader>fg") #'consult-ripgrep)
    (evil-define-key 'normal 'global (kbd "<leader>fd") #'consult-flymake)
    (evil-define-key 'normal 'global (kbd "<leader>fh") #'consult-info))

  (with-eval-after-load 'vertico
    (evil-define-key 'normal vertico-map (kbd "d") #'my/vertico-kill-buffer-candidate)))

;; Git signs in gutter (gitsigns equivalent)
(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (diff-hl-margin-mode)
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global (kbd "]h") #'diff-hl-next-hunk)
    (evil-define-key 'normal 'global (kbd "[h") #'diff-hl-previous-hunk)
    (evil-define-key 'normal 'global (kbd "<leader>ghs") #'diff-hl-stage-current-hunk)
    (evil-define-key 'normal 'global (kbd "<leader>ghr") #'diff-hl-revert-hunk)
    (evil-define-key 'normal 'global (kbd "<leader>gp")  #'diff-hl-show-hunk)
    (evil-define-key 'normal 'global (kbd "<leader>gd")  #'diff-hl-diff-goto-hunk)))

;; Which key
(use-package which-key
  :ensure nil
  :config
  (setq which-key-idle-delay 0.3)
  (which-key-mode))

(provide 'ui)

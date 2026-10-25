;;; -*- lexical-binding: t; -*-

;; Magit — Git interface
(use-package magit
  :defer t
  :init
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global (kbd "<leader>gg") #'magit-status)
    (evil-define-key 'normal 'global (kbd "<leader>gb") #'magit-blame-addition))
  :config
  (evil-define-key 'normal magit-mode-map (kbd "C-h") #'windmove-left)
  (evil-define-key 'normal magit-mode-map (kbd "C-j") #'windmove-down)
  (evil-define-key 'normal magit-mode-map (kbd "C-k") #'windmove-up)
  (evil-define-key 'normal magit-mode-map (kbd "C-l") #'windmove-right))

;; Compile mode (built-in, mirrors compile-mode.nvim)
(use-package compile
  :ensure nil
  :config
  (setq compilation-scroll-output t)
  (setq compilation-ask-about-save nil)
  (with-eval-after-load 'evil
    ;; Buffer-local so they beat evil-collection-unimpaired's global [e / ]e
    (add-hook 'compilation-mode-hook
              (lambda ()
                (evil-local-set-key 'normal (kbd "[e") #'previous-error)
                (evil-local-set-key 'normal (kbd "]e") #'next-error)))
    (evil-define-key 'normal 'global (kbd "<leader>cc") #'compile)))

;; Auto pairs (mini.pairs equivalent)
(electric-pair-mode 1)

;; Language modes
(use-package php-mode     :defer t)
(use-package svelte-mode  :defer t)
(use-package arduino-mode :defer t)
(use-package csharp-mode  :defer t)
(use-package web-mode
  :mode ("\\.razor\\'" "\\.cshtml\\'")
  ;; Razor files go through Roslyn (see lsp.el); other web-mode files don't
  :hook (web-mode . (lambda ()
                      (when (string-match-p "\\.\\(razor\\|cshtml\\)\\'" (or buffer-file-name ""))
                        (eglot-ensure))))
  :config
  (setq web-mode-engines-alist '(("razor" . "\\.\\(razor\\|cshtml\\)\\'"))))
(use-package markdown-mode
  :defer t
  :mode ("\\.md\\'" . markdown-mode))
(use-package auctex
  :defer t
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq LaTeX-indent-level 4)
  (setq TeX-brace-indent-level 4))

;; Treesitter — auto-install grammars (nvim-treesitter equivalent)
(use-package treesit-auto
  :config
  (setq treesit-auto-install t)
  (global-treesit-auto-mode))

;; Map file extensions to ts modes
(setq auto-mode-alist
      (append '(("\\.js\\'"   . js-ts-mode)
                ("\\.jsx\\'"  . tsx-ts-mode)
                ("\\.ts\\'"   . typescript-ts-mode)
                ("\\.tsx\\'"  . tsx-ts-mode)
                ("\\.go\\'"   . go-ts-mode)
                ("\\.rs\\'"   . rust-ts-mode)
                ("\\.py\\'"   . python-ts-mode)
                ("\\.lua\\'"  . lua-ts-mode)
                ("\\.css\\'"  . css-ts-mode)
                ("\\.json\\'" . json-ts-mode)
                ("\\.yaml\\'" . yaml-ts-mode)
                ("\\.yml\\'"  . yaml-ts-mode)
                ("\\.c\\'"   . c-ts-mode)
                ("\\.h\\'"   . c-ts-mode)
                ("\\.cpp\\'" . c++-ts-mode)
                ("\\.cc\\'"  . c++-ts-mode)
                ("\\.cxx\\'" . c++-ts-mode)
                ("\\.hpp\\'" . c++-ts-mode)
                ("\\.cs\\'"  . csharp-ts-mode)
                ("\\.csx\\'" . csharp-ts-mode))
              auto-mode-alist))

(provide 'code)

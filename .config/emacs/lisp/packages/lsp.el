;;; -*- lexical-binding: t; -*-

;; Completion UI (nvim-cmp equivalent)
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 1)
  (corfu-auto-trigger ".")
  (corfu-cycle t)
  :bind (:map corfu-map
         ("C-SPC"    . corfu-insert-separator)
         ("C-e"      . corfu-quit)
         ("<return>" . corfu-insert))
  :init
  (global-corfu-mode))


;; LSP via eglot (built-in since Emacs 29)
(use-package eglot
  :ensure nil
  :hook
  (rust-ts-mode        . eglot-ensure)
  (latex-mode          . eglot-ensure)
  (js-ts-mode          . eglot-ensure)
  (typescript-ts-mode  . eglot-ensure)
  (tsx-ts-mode         . eglot-ensure)
  (php-mode            . eglot-ensure)
  (svelte-mode         . eglot-ensure)
  (css-ts-mode         . eglot-ensure)
  (html-ts-mode        . eglot-ensure)
  (lua-ts-mode         . eglot-ensure)
  (c-ts-mode           . eglot-ensure)
  (csharp-mode         . eglot-ensure)
  (c++-ts-mode         . eglot-ensure)
  (python-ts-mode      . eglot-ensure)
  (go-ts-mode          . eglot-ensure)
  (csharp-ts-mode      . eglot-ensure)
  :config
  (setq eglot-autoshutdown t) ;; shutdown eglot servers once last buffer is closed
  (add-to-list 'eglot-server-programs
    '(rust-ts-mode . ("rust-analyzer"
                      :initializationOptions
                      (:diagnostics (:enable :json-false)))))

  (add-to-list 'eglot-server-programs
    '(((csharp-mode    :language-id "csharp")
       (csharp-ts-mode :language-id "csharp")
       (web-mode       :language-id "razor"))
      . ("roslyn-language-server" "--stdio" "--autoLoadProjects")))

  (add-to-list 'eglot-server-programs
    '(arduino-mode . ("arduino-language-server"
                      "-cli-config" "~/.arduino15/arduino-cli.yaml"
                      "-cli" "arduino-cli"
                      "-clangd" "clangd"
                      "-fqbn" "arduino:renesas_uno:unor4wifi")))

  ;; Disable eglot for .template.php files
  (add-hook 'eglot-managed-mode-hook
    (lambda ()
      (when (string-match-p "\\.template\\.php$" (or buffer-file-name ""))
        (eglot-shutdown (eglot-current-server) nil t))))

  ;; Roslyn's Razor semantic tokens use types outside its legend, which
  ;; crashes eglot's fontifier; let web-mode handle Razor colors instead
  (add-hook 'eglot-managed-mode-hook
    (lambda ()
      (when (derived-mode-p 'web-mode)
        (eglot-semantic-tokens-mode -1))))

  ;; q to dismiss eldoc buffer
  (add-hook 'eldoc-doc-buffer-mode-hook
    (lambda ()
      (evil-local-set-key 'motion (kbd "q") #'quit-window))))

;; LSP keybindings — set at startup so they exist before eglot first loads
(with-eval-after-load 'evil
  (evil-define-key 'normal 'global (kbd "K")
    (lambda ()
      (interactive)
      (pop-to-buffer (eldoc-doc-buffer t))))
  (evil-define-key 'normal 'global (kbd "gd")         #'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "<leader>gi") #'eglot-find-implementation)
  (evil-define-key 'normal 'global (kbd "<leader>gr") #'xref-find-references)
  (evil-define-key 'normal 'global (kbd "<leader>ca") #'eglot-code-actions)
  (evil-define-key 'normal 'global (kbd "<leader>cd") #'flymake-show-buffer-diagnostics)
  (evil-define-key 'normal 'global (kbd "[d")         #'flymake-goto-prev-error)
  (evil-define-key 'normal 'global (kbd "]d")         #'flymake-goto-next-error)
  (evil-define-key 'normal 'global (kbd "<leader>cD") #'flymake-show-project-diagnostics)
  (evil-define-key 'normal 'global (kbd "<leader>lr") #'eglot-reconnect)
  (evil-define-key 'normal 'global (kbd "<leader>cf")
    (lambda ()
      (interactive)
      (if (alist-get major-mode apheleia-mode-alist)
          (apheleia-format-buffer)
        (eglot-format-buffer)))))

;; Formatter (none-ls equivalent)
(use-package apheleia
  :hook (go-ts-mode . apheleia-mode)
  :config
  (setf (alist-get 'js-ts-mode apheleia-mode-alist) nil)
  (setf (alist-get 'lua-ts-mode apheleia-mode-alist) '(stylua))
  (setf (alist-get 'go-ts-mode apheleia-mode-alist) '(goimports gofmt)))

(use-package tuareg
  :ensure t
  :mode (("\\.ocamlinit\\'" . tuareg-mode)))

(use-package ocaml-eglot
  :ensure t
  :after tuareg
  :hook
  (tuareg-mode . ocaml-eglot)
  (ocaml-eglot . eglot-ensure))

(provide 'lsp)

;;; rasmus-theme.el --- Rasmus color theme -*- lexical-binding: t -*-
;; Port of rasmus.nvim (https://github.com/kvrohit/rasmus.nvim)

(deftheme rasmus "A muted, dark Emacs theme ported from rasmus.nvim")

(let* ((bg         "#1a1a19")
       (fg         "#d1d1d1")
       (black      "#333332")
       (red        "#ff968c")
       (green      "#61957f")
       (yellow     "#ffc591")
       (blue       "#8db4d4")
       (magenta    "#de9bc8")
       (cyan       "#7bb099")
       (br-black   "#4c4c4b")
       (br-red     "#ffafa5")
       (br-green   "#7aae98")
       (br-yellow  "#ffdeaa")
       (br-blue    "#a6cded")
       (br-magenta "#f7b4e1")
       (br-cyan    "#94c9b2")
       (br-white   "#eaeaea")
       (gray01     "#222221")
       (gray02     "#2a2a29")
       (gray03     "#323231")
       (gray04     "#3a3a39")
       (gray05     "#6a6a69")
       (gray06     "#767675")
       (gray07     "#b6b6b5")
       ;; Ghostty-measured display values (RGB sampled from fastfetch color blocks).
       ;; Emacs skips P3 color management; these pre-compensate so vterm matches Ghostty.
       (vt-red        "#f19b90")
       (vt-green      "#6d9480")
       (vt-yellow     "#f6c798")
       (vt-blue       "#95b3d1")
       (vt-magenta    "#d49ec6")
       (vt-cyan       "#86af9a")
       (vt-br-red     "#f3b2a8")
       (vt-br-green   "#85ad99")
       (vt-br-yellow  "#fadfb0")
       (vt-br-blue    "#aeccea")
       (vt-br-magenta "#edb7df")
       (vt-br-cyan    "#9fc8b3"))

  (custom-theme-set-faces
   'rasmus

   ;; ── Core ─────────────────────────────────────────────────────────────
   `(default                              ((t (:foreground ,fg :background ,bg))))
   `(cursor                               ((t (:background ,cyan))))
   `(fringe                               ((t (:foreground ,fg :background ,bg))))
   `(vertical-border                      ((t (:foreground ,gray02))))
   `(window-divider                       ((t (:foreground ,gray02))))
   `(window-divider-first-pixel           ((t (:foreground ,gray02))))
   `(window-divider-last-pixel            ((t (:foreground ,gray02))))
   `(border                               ((t (:foreground ,gray02))))
   `(highlight                            ((t (:background ,gray01))))
   `(region                               ((t (:background ,gray03 :extend t))))
   `(secondary-selection                  ((t (:background ,gray04))))
   `(hl-line                              ((t (:background ,gray01 :extend t))))
   `(shadow                               ((t (:foreground ,gray05))))
   `(error                                ((t (:foreground ,red :bold t :underline t))))
   `(warning                              ((t (:foreground ,yellow :bold t))))
   `(success                              ((t (:foreground ,green :bold t))))
   `(escape-glyph                         ((t (:foreground ,cyan))))
   `(trailing-whitespace                  ((t (:background ,red))))
   `(link                                 ((t (:foreground ,cyan :underline t))))
   `(link-visited                         ((t (:foreground ,magenta :underline t))))
   `(fill-column-indicator               ((t (:foreground ,gray03))))
   `(nobreak-space                        ((t (:foreground ,cyan))))

   ;; ── Line numbers ─────────────────────────────────────────────────────
   `(line-number                          ((t (:foreground ,gray05 :background ,bg))))
   `(line-number-current-line             ((t (:foreground ,gray07 :background ,bg))))
   `(line-number-major-tick               ((t (:foreground ,gray06 :background ,bg))))
   `(line-number-minor-tick               ((t (:foreground ,gray05 :background ,bg))))

   ;; ── Mode line ────────────────────────────────────────────────────────
   `(mode-line                            ((t (:foreground ,gray07 :background ,gray01))))
   `(mode-line-inactive                   ((t (:foreground ,gray06 :background ,gray01))))
   `(mode-line-buffer-id                  ((t (:foreground ,fg :bold t))))
   `(mode-line-emphasis                   ((t (:foreground ,cyan :bold t))))
   `(mode-line-highlight                  ((t (:foreground ,yellow))))

   ;; ── Minibuffer ───────────────────────────────────────────────────────
   `(minibuffer-prompt                    ((t (:foreground ,blue))))

   ;; ── Search ───────────────────────────────────────────────────────────
   `(isearch                              ((t (:inverse-video t))))
   `(isearch-fail                         ((t (:foreground ,red))))
   `(lazy-highlight                       ((t (:inverse-video t))))
   `(match                                ((t (:inverse-video t))))

   ;; ── Paren matching ───────────────────────────────────────────────────
   `(show-paren-match                     ((t (:foreground ,yellow :bold t))))
   `(show-paren-mismatch                  ((t (:foreground ,red :bold t))))

   ;; ── Completion ───────────────────────────────────────────────────────
   `(completions-common-part              ((t (:foreground ,yellow))))
   `(completions-first-difference         ((t (:foreground ,blue :bold t))))
   `(completions-highlight                ((t (:foreground ,bg :background ,gray06))))

   ;; ── Font lock ────────────────────────────────────────────────────────
   `(font-lock-comment-face               ((t (:foreground ,gray05))))
   `(font-lock-comment-delimiter-face     ((t (:foreground ,gray05))))
   `(font-lock-doc-face                   ((t (:foreground ,gray05))))
   `(font-lock-doc-markup-face            ((t (:foreground ,gray06))))
   `(font-lock-string-face                ((t (:foreground ,cyan))))
   `(font-lock-keyword-face               ((t (:foreground ,blue))))
   `(font-lock-builtin-face               ((t (:foreground ,fg))))
   `(font-lock-function-name-face         ((t (:foreground ,blue))))
   `(font-lock-function-call-face         ((t (:foreground ,fg))))      ; Emacs 29+
   `(font-lock-variable-name-face         ((t (:foreground ,fg))))
   `(font-lock-variable-use-face          ((t (:foreground ,fg))))      ; Emacs 29+
   `(font-lock-type-face                  ((t (:foreground ,fg))))
   `(font-lock-constant-face              ((t (:foreground ,cyan))))
   `(font-lock-preprocessor-face         ((t (:foreground ,red))))
   `(font-lock-warning-face               ((t (:foreground ,yellow :bold t))))
   `(font-lock-negation-char-face         ((t (:foreground ,yellow))))
   `(font-lock-operator-face              ((t (:foreground ,yellow))))  ; Emacs 29+
   `(font-lock-delimiter-face             ((t (:foreground ,gray07))))  ; Emacs 29+
   `(font-lock-bracket-face               ((t (:foreground ,gray05))))  ; Emacs 29+
   `(font-lock-punctuation-face           ((t (:foreground ,gray05))))  ; Emacs 29+
   `(font-lock-escape-face                ((t (:foreground ,cyan))))    ; Emacs 29+
   `(font-lock-misc-punctuation-face      ((t (:foreground ,gray05))))  ; Emacs 29+
   `(font-lock-regexp-grouping-backslash  ((t (:foreground ,green))))
   `(font-lock-regexp-grouping-construct  ((t (:foreground ,green))))
   `(font-lock-number-face                ((t (:foreground ,cyan))))    ; Emacs 29+

   ;; ── TSX / JSX (typescript-ts-mode) ──────────────────────────────────
   `(typescript-ts-jsx-tag-face           ((t (:foreground ,blue))))
   `(typescript-ts-jsx-attribute-face     ((t (:foreground ,cyan))))

   ;; ── web-mode (Razor / HTML templates) ───────────────────────────────
   `(web-mode-html-tag-face               ((t (:foreground ,blue))))
   `(web-mode-html-tag-custom-face        ((t (:foreground ,blue))))
   `(web-mode-html-tag-bracket-face       ((t (:foreground ,gray05))))
   `(web-mode-html-attr-name-face         ((t (:foreground ,cyan))))
   `(web-mode-html-attr-custom-face       ((t (:foreground ,cyan))))
   `(web-mode-html-attr-equal-face        ((t (:foreground ,gray05))))
   `(web-mode-html-attr-value-face        ((t (:foreground ,cyan))))
   `(web-mode-block-delimiter-face        ((t (:foreground ,yellow))))
   `(web-mode-block-control-face          ((t (:foreground ,blue))))
   `(web-mode-block-attr-name-face        ((t (:foreground ,cyan))))
   `(web-mode-block-attr-value-face       ((t (:foreground ,cyan))))
   `(web-mode-symbol-face                 ((t (:foreground ,cyan))))
   `(web-mode-doctype-face                ((t (:foreground ,gray05))))
   `(web-mode-param-name-face             ((t (:foreground ,fg))))
   `(web-mode-json-key-face               ((t (:foreground ,fg))))
   `(web-mode-json-context-face           ((t (:foreground ,fg))))
   `(web-mode-error-face                  ((t (:foreground ,red :underline t))))
   `(web-mode-block-face                  ((t nil)))
   `(web-mode-inlay-face                  ((t nil)))
   `(web-mode-current-element-highlight-face ((t (:background ,gray03))))
   `(web-mode-current-column-highlight-face  ((t (:background ,gray02))))

   ;; ── Whitespace ───────────────────────────────────────────────────────
   `(whitespace-space                     ((t (:foreground ,gray03))))
   `(whitespace-tab                       ((t (:foreground ,gray03))))
   `(whitespace-newline                   ((t (:foreground ,gray03))))
   `(whitespace-trailing                  ((t (:background ,red))))
   `(whitespace-line                      ((t (:foreground ,red))))
   `(whitespace-empty                     ((t (:background ,gray01))))

   ;; ── Diff ─────────────────────────────────────────────────────────────
   `(diff-header                          ((t (:foreground ,gray07 :background ,gray01))))
   `(diff-file-header                     ((t (:foreground ,fg :background ,gray01 :bold t))))
   `(diff-index                           ((t (:foreground ,magenta))))
   `(diff-hunk-header                     ((t (:foreground ,cyan))))
   `(diff-added                           ((t (:foreground ,br-green :inverse-video t))))
   `(diff-removed                         ((t (:foreground ,br-red :inverse-video t))))
   `(diff-changed                         ((t (:foreground ,br-blue :inverse-video t))))
   `(diff-indicator-added                 ((t (:foreground ,br-green))))
   `(diff-indicator-removed               ((t (:foreground ,br-red))))
   `(diff-indicator-changed               ((t (:foreground ,br-blue))))
   `(diff-refine-added                    ((t (:foreground ,br-green :bold t :inverse-video t))))
   `(diff-refine-removed                  ((t (:foreground ,br-red :bold t :inverse-video t))))

   ;; ── Flymake ──────────────────────────────────────────────────────────
   `(flymake-error                        ((t (:underline (:style wave :color ,red)))))
   `(flymake-warning                      ((t (:underline (:style wave :color ,yellow)))))
   `(flymake-note                         ((t (:underline (:style wave :color ,cyan)))))

   ;; ── Flycheck ─────────────────────────────────────────────────────────
   `(flycheck-error                       ((t (:underline (:style wave :color ,red)))))
   `(flycheck-warning                     ((t (:underline (:style wave :color ,yellow)))))
   `(flycheck-info                        ((t (:underline (:style wave :color ,blue)))))

   ;; ── Flyspell ─────────────────────────────────────────────────────────
   `(flyspell-incorrect                   ((t (:foreground ,red :italic t :underline (:style wave :color ,red)))))
   `(flyspell-duplicate                   ((t (:foreground ,cyan :italic t :underline (:style wave :color ,cyan)))))

   ;; ── Eglot ────────────────────────────────────────────────────────────
   `(eglot-diagnostic-tag-unnecessary-face ((t (:foreground ,gray05 :italic t))))
   `(eglot-diagnostic-tag-deprecated-face  ((t (:foreground ,yellow :strike-through t))))
   `(eglot-highlight-symbol-face           ((t (:background ,gray04 :underline (:color ,gray06 :style line)))))
   `(eglot-inlay-hint-face                 ((t (:foreground ,gray05 :italic t))))

   ;; ── Popup / float ────────────────────────────────────────────────────
   `(popup-face                           ((t (:foreground ,gray07 :background ,gray02))))
   `(popup-selection-face                 ((t (:foreground ,bg :background ,gray06))))

   ;; ── Corfu ────────────────────────────────────────────────────────────
   `(corfu-default                        ((t (:foreground ,gray07 :background ,gray02))))
   `(corfu-current                        ((t (:foreground ,bg :background ,gray06))))
   `(corfu-bar                            ((t (:background ,gray05))))
   `(corfu-border                         ((t (:background ,gray02))))
   `(corfu-annotations                    ((t (:foreground ,gray06))))
   `(corfu-deprecated                     ((t (:foreground ,gray05 :strike-through t))))

   ;; ── Company ──────────────────────────────────────────────────────────
   `(company-tooltip                      ((t (:foreground ,gray07 :background ,gray02))))
   `(company-tooltip-selection            ((t (:foreground ,bg :background ,gray06))))
   `(company-tooltip-common               ((t (:foreground ,yellow))))
   `(company-tooltip-annotation           ((t (:foreground ,gray06))))
   `(company-tooltip-scrollbar-track      ((t (:background ,gray02))))
   `(company-tooltip-scrollbar-thumb      ((t (:background ,gray05))))
   `(company-scrollbar-bg                 ((t (:background ,gray02))))
   `(company-scrollbar-fg                 ((t (:background ,gray05))))

   ;; ── Vertico ──────────────────────────────────────────────────────────
   `(vertico-current                      ((t (:foreground ,bg :background ,gray06))))

   ;; ── Orderless ────────────────────────────────────────────────────────
   `(orderless-match-face-0               ((t (:foreground ,yellow))))
   `(orderless-match-face-1               ((t (:foreground ,blue))))
   `(orderless-match-face-2               ((t (:foreground ,green))))
   `(orderless-match-face-3               ((t (:foreground ,magenta))))

   ;; ── Consult ──────────────────────────────────────────────────────────
   `(consult-preview-line                 ((t (:background ,gray01))))
   `(consult-preview-match                ((t (:foreground ,yellow))))

   ;; ── Marginalia ───────────────────────────────────────────────────────
   `(marginalia-documentation             ((t (:foreground ,gray06 :italic t))))

   ;; ── Which-key ────────────────────────────────────────────────────────
   `(which-key-key-face                   ((t (:foreground ,br-cyan))))
   `(which-key-group-description-face     ((t (:foreground ,yellow :italic t))))
   `(which-key-command-description-face   ((t (:foreground ,blue))))
   `(which-key-separator-face             ((t (:foreground ,gray05))))

   ;; ── Dired ────────────────────────────────────────────────────────────
   `(dired-directory                      ((t (:foreground ,blue :bold t))))
   `(dired-symlink                        ((t (:foreground ,cyan))))
   `(dired-special                        ((t (:foreground ,magenta))))
   `(dired-broken-symlink                 ((t (:foreground ,red :bold t))))

   ;; ── Magit ────────────────────────────────────────────────────────────
   `(magit-section-heading                ((t (:foreground ,cyan :bold t))))
   `(magit-section-heading-selection      ((t (:foreground ,yellow :bold t))))
   `(magit-section-highlight              ((t (:background ,gray01))))
   `(magit-diff-added                     ((t (:foreground ,br-green :inverse-video t))))
   `(magit-diff-removed                   ((t (:foreground ,br-red :inverse-video t))))
   `(magit-diff-base                      ((t (:foreground ,br-blue :inverse-video t))))
   `(magit-diff-added-highlight           ((t (:foreground ,br-green :background ,gray01 :inverse-video t))))
   `(magit-diff-removed-highlight         ((t (:foreground ,br-red :background ,gray01 :inverse-video t))))
   `(magit-diff-base-highlight            ((t (:foreground ,br-blue :background ,gray01 :inverse-video t))))
   `(magit-diff-hunk-heading              ((t (:foreground ,gray07 :background ,gray03))))
   `(magit-diff-hunk-heading-highlight    ((t (:foreground ,fg :background ,gray04))))
   `(magit-diffstat-added                 ((t (:foreground ,br-green))))
   `(magit-diffstat-removed               ((t (:foreground ,br-red))))
   `(magit-branch-local                   ((t (:foreground ,blue))))
   `(magit-branch-remote                  ((t (:foreground ,green))))
   `(magit-tag                            ((t (:foreground ,yellow))))
   `(magit-hash                           ((t (:foreground ,gray06))))
   `(magit-log-author                     ((t (:foreground ,red))))
   `(magit-filename                       ((t (:foreground ,fg))))

   ;; ── diff-hl ──────────────────────────────────────────────────────────
   `(diff-hl-insert                       ((t (:foreground ,br-green :background ,br-green))))
   `(diff-hl-delete                       ((t (:foreground ,br-red :background ,br-red))))
   `(diff-hl-change                       ((t (:foreground ,br-yellow :background ,br-yellow))))
   `(diff-hl-margin-insert                ((t (:foreground ,br-green))))
   `(diff-hl-margin-delete                ((t (:foreground ,br-red))))
   `(diff-hl-margin-change                ((t (:foreground ,br-yellow))))

   ;; ── Centaur-tabs ─────────────────────────────────────────────────────
   `(centaur-tabs-default                 ((t (:foreground ,gray05 :background ,gray01))))
   `(centaur-tabs-selected                ((t (:foreground ,bg :background ,gray07))))
   `(centaur-tabs-unselected              ((t (:foreground ,gray05 :background ,gray01))))
   `(centaur-tabs-selected-modified       ((t (:foreground ,bg :background ,br-cyan))))
   `(centaur-tabs-unselected-modified     ((t (:foreground ,br-cyan :background ,gray01))))
   `(centaur-tabs-active-bar-face         ((t (:background ,gray07))))

   ;; ── Doom modeline ────────────────────────────────────────────────────
   `(doom-modeline-bar                    ((t (:background ,gray07))))
   `(doom-modeline-bar-inactive           ((t (:background ,gray03))))
   `(doom-modeline-buffer-path            ((t (:foreground ,gray06))))
   `(doom-modeline-buffer-file            ((t (:foreground ,fg :bold t))))
   `(doom-modeline-buffer-modified        ((t (:foreground ,br-cyan))))
   `(doom-modeline-buffer-major-mode      ((t (:foreground ,blue))))
   `(doom-modeline-info                   ((t (:foreground ,cyan))))
   `(doom-modeline-project-dir            ((t (:foreground ,gray06))))
   `(doom-modeline-error                  ((t (:foreground ,red))))
   `(doom-modeline-warning                ((t (:foreground ,yellow))))

   ;; ── Org-mode ─────────────────────────────────────────────────────────
   `(org-level-1                          ((t (:foreground ,br-white :bold t))))
   `(org-level-2                          ((t (:foreground ,br-white :bold t))))
   `(org-level-3                          ((t (:foreground ,br-white :bold t))))
   `(org-level-4                          ((t (:foreground ,br-white :bold t))))
   `(org-level-5                          ((t (:foreground ,br-white :bold t))))
   `(org-level-6                          ((t (:foreground ,br-white :bold t))))
   `(org-level-7                          ((t (:foreground ,br-white :bold t))))
   `(org-level-8                          ((t (:foreground ,br-white :bold t))))
   `(org-link                             ((t (:foreground ,cyan :underline t))))
   `(org-code                             ((t (:foreground ,fg :background ,gray02))))
   `(org-verbatim                         ((t (:foreground ,fg :background ,gray02))))
   `(org-block                            ((t (:foreground ,fg :background ,gray02 :extend t))))
   `(org-block-begin-line                 ((t (:foreground ,gray05 :background ,gray02 :extend t))))
   `(org-block-end-line                   ((t (:foreground ,gray05 :background ,gray02 :extend t))))
   `(org-todo                             ((t (:foreground ,cyan :bold t :italic t))))
   `(org-done                             ((t (:foreground ,gray05 :bold t))))
   `(org-date                             ((t (:foreground ,cyan))))
   `(org-special-keyword                  ((t (:foreground ,yellow :italic t))))
   `(org-table                            ((t (:foreground ,blue))))
   `(org-tag                              ((t (:foreground ,gray05 :italic t))))
   `(org-document-title                   ((t (:foreground ,br-white :bold t))))
   `(org-document-info                    ((t (:foreground ,gray06))))
   `(org-list-dt                          ((t (:foreground ,blue))))
   `(org-priority                         ((t (:foreground ,yellow))))
   `(org-ellipsis                         ((t (:foreground ,gray05))))
   `(org-headline-done                    ((t (:foreground ,gray05))))

   ;; ── AUCTeX ───────────────────────────────────────────────────────────
   `(font-latex-warning-face                ((t (:foreground ,green))))
   `(font-latex-sedate-face                 ((t (:foreground ,blue))))
   `(font-latex-bold-face                   ((t (:foreground ,fg :bold t))))
   `(font-latex-italic-face                 ((t (:foreground ,fg :italic t))))
   `(font-latex-math-face                   ((t (:foreground ,cyan))))
   `(font-latex-string-face                 ((t (:foreground ,cyan))))
   `(font-latex-verbatim-face               ((t (:foreground ,fg :background ,gray02))))
   `(font-latex-sectioning-0-face           ((t (:foreground ,br-white :bold t))))
   `(font-latex-sectioning-1-face           ((t (:foreground ,br-white :bold t))))
   `(font-latex-sectioning-2-face           ((t (:foreground ,br-white :bold t))))
   `(font-latex-sectioning-3-face           ((t (:foreground ,br-white :bold t))))
   `(font-latex-sectioning-4-face           ((t (:foreground ,br-white :bold t))))
   `(font-latex-sectioning-5-face           ((t (:foreground ,br-white :bold t))))

   ;; ── Markdown ─────────────────────────────────────────────────────────
   `(markdown-header-face-1               ((t (:foreground ,br-white :bold t))))
   `(markdown-header-face-2               ((t (:foreground ,br-white :bold t))))
   `(markdown-header-face-3               ((t (:foreground ,br-white :bold t))))
   `(markdown-header-face-4               ((t (:foreground ,br-white :bold t))))
   `(markdown-header-face-5               ((t (:foreground ,br-white :bold t))))
   `(markdown-header-face-6               ((t (:foreground ,br-white :bold t))))
   `(markdown-header-delimiter-face       ((t (:foreground ,gray05))))
   `(markdown-link-face                   ((t (:foreground ,br-white :italic t))))
   `(markdown-url-face                    ((t (:foreground ,gray06))))
   `(markdown-code-face                   ((t (:foreground ,fg :background ,gray02 :extend t))))
   `(markdown-inline-code-face            ((t (:foreground ,fg :background ,gray02))))
   `(markdown-blockquote-face             ((t (:foreground ,gray07))))
   `(markdown-bold-face                   ((t (:foreground ,fg :bold t))))
   `(markdown-italic-face                 ((t (:foreground ,fg :italic t))))
   `(markdown-list-face                   ((t (:foreground ,yellow))))
   `(markdown-markup-face                 ((t (:foreground ,gray05))))
   `(markdown-metadata-key-face           ((t (:foreground ,blue))))

   ;; ── Terminal (term / ansi-term) ───────────────────────────────────────
   `(term                                 ((t (:foreground ,fg :background ,bg))))
   `(term-color-black                     ((t (:foreground ,black :background ,br-black))))
   `(term-color-red                       ((t (:foreground ,red :background ,br-red))))
   `(term-color-green                     ((t (:foreground ,green :background ,br-green))))
   `(term-color-yellow                    ((t (:foreground ,yellow :background ,br-yellow))))
   `(term-color-blue                      ((t (:foreground ,blue :background ,br-blue))))
   `(term-color-magenta                   ((t (:foreground ,magenta :background ,br-magenta))))
   `(term-color-cyan                      ((t (:foreground ,cyan :background ,br-cyan))))
   `(term-color-white                     ((t (:foreground ,fg :background ,br-white))))

   ;; ── vterm ────────────────────────────────────────────────────────────
   ;; vterm--get-color calls face-foreground or face-background based on context,
   ;; so each face must use the same value for both attrs. Bright row (8-15) is
   ;; handled entirely by the vterm-color-bright-* faces below.
   `(vterm-color-default                  ((t (:foreground ,fg :background ,bg))))
   `(vterm-color-black                    ((t (:foreground ,black :background ,black))))
   `(vterm-color-red                      ((t (:foreground ,vt-red :background ,vt-red))))
   `(vterm-color-green                    ((t (:foreground ,vt-green :background ,vt-green))))
   `(vterm-color-yellow                   ((t (:foreground ,vt-yellow :background ,vt-yellow))))
   `(vterm-color-blue                     ((t (:foreground ,vt-blue :background ,vt-blue))))
   `(vterm-color-magenta                  ((t (:foreground ,vt-magenta :background ,vt-magenta))))
   `(vterm-color-cyan                     ((t (:foreground ,vt-cyan :background ,vt-cyan))))
   `(vterm-color-white                    ((t (:foreground ,fg :background ,fg))))
   `(vterm-color-bright-black             ((t (:foreground ,br-black :background ,br-black))))
   `(vterm-color-bright-red               ((t (:foreground ,vt-br-red :background ,vt-br-red))))
   `(vterm-color-bright-green             ((t (:foreground ,vt-br-green :background ,vt-br-green))))
   `(vterm-color-bright-yellow            ((t (:foreground ,vt-br-yellow :background ,vt-br-yellow))))
   `(vterm-color-bright-blue              ((t (:foreground ,vt-br-blue :background ,vt-br-blue))))
   `(vterm-color-bright-magenta           ((t (:foreground ,vt-br-magenta :background ,vt-br-magenta))))
   `(vterm-color-bright-cyan              ((t (:foreground ,vt-br-cyan :background ,vt-br-cyan))))
   `(vterm-color-bright-white             ((t (:foreground ,br-white :background ,br-white)))))

  (custom-theme-set-variables
   'rasmus
   `(ansi-color-names-vector
     [,black ,red ,green ,yellow ,blue ,magenta ,cyan ,fg])))

(provide-theme 'rasmus)
;;; rasmus-theme.el ends here

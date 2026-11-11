;; -*- no-byte-compile: t; lexical-binding: t -*-

(setq load-prefer-newer t)

(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

(setq package-enable-at-startup nil)

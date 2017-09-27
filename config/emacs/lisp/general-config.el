(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
; Changes Yes/no with y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; No scrollbars
(set-fringe-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Initial mode in text avoids lag
(setq initial-major-mode 'text-mode
      initial-scratch-message nil)

;; prefer utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(savehist-mode 1)

;;Persistent undo history
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.undo/")))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "inox")

(pkg
  smooth-scrolling
  :ensure t
  :init
  (setq scroll-margin 5
        scroll-conservatively 9999
        scroll-step 1))

;; No more ....~ (backup) or # ... # (auto-save) files in the project
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))
(setq auto-save-file-name-transforms `((".*" , "~/.emacs.d/.saves" t)))

(setq vc-follow-symlinks t)

(provide 'general-config)

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
(menu-bar-mode -1)

;; prefer utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(savehist-mode 1)

;;Persistent undo history
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist `((".*" . ,temporary-file-directory)))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program my-browser)

(use-package
  smooth-scrolling
  :ensure t
  :defer t
  :init
  (setq scroll-margin 5
        scroll-conservatively 9999
        scroll-step 1))

;; Initial mode in text avoids lag
(setq initial-major-mode 'fundamental-mode
      initial-scratch-message my-initial-msg)

; Temporary files
(setq temporary-file-directory "/tmp/emacs")
(when (not (file-exists-p temporary-file-directory))
  (mkdir temporary-file-directory))
(setq
  ; Files with the sape of: '#filename#'
  auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
  backup-by-copying             t
  ; Files with the sape of: '~filename'
  backup-directory-alist        `((".*" . ,temporary-file-directory))
  delete-old-versions           t
  kept-new-versions             6
  kept-old-versions             2
  version-control               t
  ; Files with the sape of: '.#filename'
  create-lockfiles              nil)

(setq vc-follow-symlinks t)

(use-package diminish :ensure t)

(defun set-terminal-title ()
  (interactive)
  (send-string-to-terminal (concat "\033]1; " (buffer-name) "\007"))
  (if buffer-file-name
      (send-string-to-terminal (concat "\033]2; " (buffer-file-name) "\007"))
    (send-string-to-terminal (concat "\033]2; " (buffer-name) "\007"))))

(if (not window-system)
    (add-hook 'post-command-hook 'set-terminal-title))

(provide '01-init-general-config)

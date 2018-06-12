;; Bootstrap `use-package'
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)

(defvar emacs-dir "~/.emacs.d/")

(unless
  (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Custom file
(setq custom-file (concat emacs-dir "custom.el"))
(unless (file-exists-p custom-file))
  (shell-command (concat "touch " custom-file))
(load custom-file)

(setq *is-a-mac* (eq system-type 'darwin))
(setq *cygwin* (eq system-type 'cygwin))
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)))

;; Load modules
(defvar lisp-directory (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path lisp-directory)
(mapc (lambda (file-name)
        (require (intern (file-name-sans-extension file-name))))
      (directory-files lisp-directory nil "\\.el$"))

(defun display-startup-echo-area-message ()
  (message (format "Emacs started in %s" (emacs-init-time))))

(provide 'init)

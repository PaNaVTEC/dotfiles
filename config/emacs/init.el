;; Bootstrap `use-package'
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(unless
  (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Functions
(defalias 'pkg 'use-package)

(defvar modules-dir (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path modules-dir)

;; Load modules
(require 'general-config)
(require 'appearance)
(require 'vim-mode)
(require 'auto-complete)
(require 'haskell)
(require 'javascript)
(require 'scala)
(require 'syntax-check)
(require 'file-explorer)
(require 'relative-lines)
(require 'helm-fw)
(require 'ctrlp)

;; Misc
(pkg markdown-mode :ensure t)
(pkg yaml-mode :ensure t)
(pkg restclient :ensure t)

;; Zeal setup
(pkg zeal-at-point :ensure t)
(add-to-list 'zeal-at-point-mode-alist '(haskell-mode . "haskell"))
(global-set-key "\C-cd" 'zeal-at-point)
(add-to-list 'exec-path "/usr/bin/zeal")

(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-projectile helm smooth-scrolling restclient zeal-at-point ensime scala-mode company-mode neotree yaml-mode markdown-mode intero haskell-mode evil-indent-textobject evil-surround evil-leader evil use-package powerline leuven-theme flycheck-color-mode-line))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

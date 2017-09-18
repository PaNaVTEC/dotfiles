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
(defalias 'pkg 'use-package)

;; Load modules
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(dolist (module '(general-config
                   appearance
                   vim-mode
                   acklike
                   auto-complete
                   haskell
                   javascript
                   scala
                   syntax-check
                   file-explorer
                   relative-lines
                   helm-fw
                   ctrlp
                   markdown
                   yaml
                   rest))
  (require module))

(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" default)))
 '(package-selected-packages
   (quote
    (helm-projectile helm smooth-scrolling restclient zeal-at-point ensime scala-mode company-mode neotree yaml-mode markdown-mode intero haskell-mode evil-indent-textobject evil-surround evil-leader evil use-package powerline leuven-theme flycheck-color-mode-line))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
                   helm-fw
                   ctrlp
                   markdown
                   yaml
                   compile-mode
                   rest
                   vimscript
                   clipboard))
  (require module))

(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "~")
 '(git-gutter:verbosity 0)
 '(git-gutter:visual-line t)
 '(git-gutter:window-width 1)
 '(package-selected-packages
   (quote
    (web-mode zenburn-theme zeal-at-point yaml-mode use-package telephone-line spacemacs-theme spaceline smooth-scrolling rjsx-mode restclient nyan-mode neotree monokai-theme moe-theme material-theme markdown-mode linum-relative json-mode js2-refactor intero helm-projectile hc-zenburn-theme git-gutter flycheck-color-mode-line flatland-theme evil-surround evil-numbers evil-leader evil-indent-textobject ensime darkokai-theme company-tern))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

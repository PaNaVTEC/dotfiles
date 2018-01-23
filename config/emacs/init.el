;; Bootstrap `use-package'
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)

(unless
  (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(defalias 'pkg 'use-package)

;; Custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Load modules
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(dolist (module '(mysetup
                   init-welcome
                   general-config
                   appearance
                   vim-mode
                   acklike
                   auto-complete
                   haskell
                   javascript
                   init-groovy
                   init-python
                   init-golang
                   scala
                   syntax-check
                   file-explorer
                   helm-fw
                   git
                   init-projectmanagement
                   markdown
                   yaml
                   compile-mode
                   rest
                   vimscript
                   clipboard
                   key-helper
                   el
                   sh))
  (require module))

(defun display-startup-echo-area-message ()
  (message (format "Emacs started in %s" (emacs-init-time))))

(provide 'init)

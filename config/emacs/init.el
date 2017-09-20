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
(provide 'custom)


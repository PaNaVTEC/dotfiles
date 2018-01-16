(require 'programming-mode)

(pkg
  groovy-mode
  :ensure t
  :mode "\\.groovy$"
  :mode "\\.gradle$"
  :config (add-hook 'groovy-mode-hook 'programming-mode))

(provide 'init-groovy)

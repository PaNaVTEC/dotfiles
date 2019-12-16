(require 'init-programming-mode)

(use-package
  es-mode
  :ensure t
  :defer t
  :mode "\\.es$"
  :config

  (add-hook 'es-mode-hook 'programming-mode))

(provide 'init-elasticsearch)

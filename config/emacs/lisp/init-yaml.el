(require 'programming-mode)

(use-package
  yaml-mode
  :ensure t
  :mode "\\.ya?ml$"
  :config
  (add-hook 'yaml-mode-hook 'programming-mode))
(provide 'init-yaml)

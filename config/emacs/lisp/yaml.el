(require 'programming-mode)

(pkg
  yaml-mode
  :ensure t
  :mode "\\.ya?ml$"
  :config
  (add-hook 'yaml-mode-hook 'programming-mode))
(provide 'yaml)

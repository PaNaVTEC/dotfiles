(require 'init-programming-mode)

(use-package
  terraform-mode
  :ensure t
  :mode "\\.tf$"
  :defer t
  :config

  (add-hook 'terraform-mode-hook 'programming-mode))

(provide 'init-terraform)

(require 'init-programming-mode)

(use-package
  dockerfile-mode
  :ensure t
  :mode "Dockerfile"
  :defer t
  :config

  (add-hook 'dockerfile-mode-hook 'programming-mode))

(provide 'init-docker)

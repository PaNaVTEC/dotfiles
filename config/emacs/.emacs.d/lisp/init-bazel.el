(require 'init-programming-mode)

(use-package
  bazel-mode
  :ensure t
  :defer t
  :mode "\\.ba?ze?l$"
  :config
  (add-hook 'bazel-mode-hook 'programming-mode)
)

(provide 'init-bazel)

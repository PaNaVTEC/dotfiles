(require 'init-programming-mode)

(use-package
  bazel
  :ensure t
  :defer t
  :mode ("\\.ba?ze?l$" . bazel-mode))

(provide 'init-bazel)

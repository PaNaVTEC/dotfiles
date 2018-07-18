(require 'init-programming-mode)

(use-package
  rust-mode
  :ensure t
  :defer t
  :config
  (add-hook 'rust-mode 'programming-mode))
(use-package flymake-rust :ensure t :defer t)

(provide 'init-rust)

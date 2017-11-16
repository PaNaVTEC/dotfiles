(require 'programming-mode)

(pkg
  yaml-mode
  :ensure t
  :config
  (add-hook 'yaml-mode-hook 'programming-mode))
(provide 'yaml)

(require 'programming-mode)

(pkg
  yaml-mode
  :ensure t
  (add-hook 'yaml-mode-hook 'programming-mode))
(provide 'yaml)

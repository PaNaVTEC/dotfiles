(require 'programming-mode)

(add-hook 'flycheck-mode-hook
  (lambda () (progn (flycheck-add-mode 'python-pylint 'python-mode-hook))))

(add-hook 'python-mode-hook 'programming-mode)

(provide 'init-python)

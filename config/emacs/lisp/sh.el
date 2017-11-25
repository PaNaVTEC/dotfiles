(require 'programming-mode)

(add-hook 'sh-mode-hook 'programming-mode)
(add-hook 'sh-mode-hook 'company-mode)
(setq sh-basic-offset 2 sh-indentation 2)

(provide 'sh)

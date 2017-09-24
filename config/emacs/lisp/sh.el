(require 'programming-mode)

(add-hook 'sh-mode-hook 'programming-mode)
(add-hook 'sh-mode-hook 'company-mode)

(provide 'sh)

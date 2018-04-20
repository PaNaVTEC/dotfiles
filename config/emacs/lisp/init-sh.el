(require 'programming-mode)

(add-hook 'sh-mode-hook 'programming-mode)
(add-hook 'sh-mode-hook 'company-mode)
(add-hook 'sh-mode-hook 'sh-doc)
(setq sh-basic-offset 2 sh-indentation 2)

(defun sh-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Bash")))

(provide 'init-sh)

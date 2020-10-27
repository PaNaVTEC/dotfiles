(require 'init-programming-mode)

(add-hook 'sh-mode-hook 'programming-mode)
(add-hook 'sh-mode-hook 'sh-doc)

(add-hook
  'sh-mode-hook
  (lambda ()
    (progn
      (programming-mode)
      (sh-doc)
      (add-hook 'flycheck-mode-hook (lambda () (progn (flycheck-add-mode 'sh-shellcheck 'sh-mode)))))))

(setq sh-basic-offset 2 sh-indentation 2)

(defun sh-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Bash")))

(provide 'init-sh)

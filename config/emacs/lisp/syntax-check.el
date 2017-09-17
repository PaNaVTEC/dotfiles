(pkg
  flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  (define-key evil-normal-state-map (kbd "]w") 'flycheck-next-error)
  (define-key evil-normal-state-map (kbd "[w") 'flycheck-previous-error))

(provide 'syntax-check)

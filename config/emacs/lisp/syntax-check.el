(pkg
  flycheck
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "]w") 'flycheck-next-error)
  (define-key evil-normal-state-map (kbd "[w") 'flycheck-previous-error)
  (location-list-buffer (rx bos "*Flycheck errors*")))

(provide 'syntax-check)

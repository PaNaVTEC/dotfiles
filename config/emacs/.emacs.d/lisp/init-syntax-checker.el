(use-package
  flycheck
  :ensure t
  :diminish flycheck-mode
  :defer t
  :config
  (define-key evil-normal-state-map (kbd "]w") 'flycheck-next-error)
  (define-key evil-normal-state-map (kbd "[w") 'flycheck-previous-error)
  (evil-collection-init 'flycheck)
  (location-list-buffer (rx bos "*Flycheck errors*"))
  (location-list-buffer (rx bos "*Flycheck error messages*")))

(provide 'init-syntax-checker)

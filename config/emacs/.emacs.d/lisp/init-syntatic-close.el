(use-package smartparens :ensure t :defer t)
(use-package evil-smartparens :ensure t :defer t)

(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)

(provide 'init-syntatic-close)

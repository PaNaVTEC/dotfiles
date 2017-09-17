(pkg company
     :ensure t
     :diminish company-mode
     :config
     (add-hook 'js2-mode-hook 'company-mode))

(provide 'auto-complete)

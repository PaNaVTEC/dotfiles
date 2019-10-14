(use-package
  company
  :ensure t
  :diminish company-mode
  :config
  (setq company-idle-delay 0.3)
  (setq company-show-numbers t))

(use-package
  company-tabnine
  :ensure t
  :after company
  :config (add-to-list 'company-backends #'company-tabnine))

(provide 'init-auto-complete)

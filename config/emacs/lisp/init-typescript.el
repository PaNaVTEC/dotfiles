(use-package
  typescript-mode
  :mode ("\\.ts?" . typescript-mode))

(use-package
  tide
  :ensure t
  :config
  (tide-setup)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (setq company-tooltip-align-annotations t)
  (add-hook
    'flycheck-mode-hook
    (lambda () (progn
                 (flycheck-add-mode 'typescript-tslint 'typescript-mode))))
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook 'programming-mode)
  (add-hook 'typescript-mode-hook 'tide-mode)
  (add-hook 'typescript-mode-hook 'company-mode))

(use-package
  web-mode
  :mode ("\\.tsx" . web-mode)
  :config
  (add-hook 'web-mode-hook 'programming-mode)
  (add-hook 'web-mode-hook 'company-mode)
  (tide-setup))

(provide 'init-typescript)

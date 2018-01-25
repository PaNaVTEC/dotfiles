(use-package
  typescript-mode
  :mode ("\\.ts" . typescript-mode)
  :config

  (use-package
    tide
    :ensure t
    :config
    (defun my/setup-tide ()
      (tide-setup)
      (tide-mode)
      (eldoc-mode +1)
      (tide-hl-identifier-mode +1)
      (setq
        company-tooltip-align-annotations t
        tide-format-options '(:indentSize 2 :tabSize 2))

      (add-hook 'before-save-hook 'tide-format-before-save)
      (add-hook
        'flycheck-mode-hook
        (lambda () (progn
                     (flycheck-add-mode 'typescript-tslint 'typescript-mode)))))

    (add-hook 'typescript-mode-hook 'programming-mode)
    (add-hook 'typescript-mode-hook 'my/setup-tide)
    (add-hook 'typescript-mode-hook 'company-mode)))

(use-package
  web-mode
  :mode ("\\.tsx" . web-mode)
  :config
  (add-hook 'web-mode-hook 'programming-mode)
  (add-hook 'web-mode-hook 'company-mode)
  (tide-setup))

(provide 'init-typescript)

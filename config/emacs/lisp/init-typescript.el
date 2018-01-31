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

(use-package
  typescript-mode
  :ensure t
  :pin melpa-stable
  :mode ("\\.tsx?" . typescript-mode)
  :config

  (use-package
    tide
    :ensure t
    :pin melpa-stable
    :config

    (add-hook 'typescript-mode-hook 'programming-mode)
    (add-hook 'typescript-mode-hook 'my/setup-tide)
    (add-hook 'typescript-mode-hook 'company-mode)))

(provide 'init-typescript)

(defun my/setup-tide ()
  (tide-setup)
  (tide-mode)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)

  ; Bind tide keys
  (evil-leader/set-key "b" 'tide-jump-to-definition)
  (evil-leader/set-key "7" 'tide-references)

  (location-list-buffer (rx bos "*tide-"))

  (setq
    company-tooltip-align-annotations t
    tide-format-options '(:indentSize 2 :tabSize 2))

;  (add-hook 'before-save-hook 'tide-format-before-save)
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

  (setq typescript-indent-level 2)
  (set-compile-for 'typescript-mode "yarn test")

  (use-package
    tide
    :ensure t
    :pin melpa-stable
    :config

    (add-hook 'typescript-mode-hook 'programming-mode)
    (add-hook 'typescript-mode-hook 'my/setup-tide)
    (add-hook 'typescript-mode-hook 'company-mode)))

(provide 'init-typescript)

(use-package
  purescript-mode
  :diminish purescript-indentation-mode
  :mode "\\.purs\\'"
  :ensure t
  :config
  (setq projectile-tags-command "npm run etags")
  (add-hook 'purescript-mode-hook 'turn-on-purescript-decl-scan)

  ; Cant navigate to etags if the prefix is a namespace
  (add-hook 'purescript-mode-hook (lambda ()
    (make-variable-buffer-local 'find-tag-default-function)
    (setq find-tag-default-function (lambda () (current-word t t)))
  ))

  (add-hook 'purescript-mode-hook 'turn-on-purescript-indentation)
  (add-hook 'purescript-mode-hook 'programming-mode)
  (add-hook 'purescript-mode-hook 'inferior-psci-mode)

  (setq purescript-align-imports-pad-after-name nil)
  (defun purescript-sort-and-align-imports ()
    (interactive)
    (save-excursion
      (while (purescript-navigate-imports)
        (progn
          (purescript-sort-imports)
          (purescript-align-imports)))
      (purescript-navigate-imports-return))))

(use-package psci :ensure t :defer t)
(use-package flycheck-purescript :ensure t :defer t)

(provide 'init-purescript)

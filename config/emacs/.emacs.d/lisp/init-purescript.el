(use-package
  purescript-mode
  :diminish purescript-indentation-mode
  :mode "\\.purs\\'"
  :ensure t
  :config
  (setq projectile-tags-command "npm run etags")
  (add-hook 'purescript-mode-hook 'turn-on-purescript-decl-scan)

  (setq purescript-align-imports-pad-after-name nil)
  (defun purescript-sort-and-align-imports ()
    (interactive)
    (save-excursion
      (while (purescript-navigate-imports)
        (progn
          (purescript-sort-imports)
          (purescript-align-imports)))
      (purescript-navigate-imports-return)))

  (add-hook 'purescript-mode-hook
            (lambda ()
              (turn-on-purescript-indentation)
              (programming-mode)
              (inferior-psci-mode))))

(use-package psci :ensure t :defer t)
(use-package flycheck-purescript :ensure t :defer t)

(provide 'init-purescript)

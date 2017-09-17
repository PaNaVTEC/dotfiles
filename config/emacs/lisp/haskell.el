(pkg
  haskell-mode
  :ensure t
  :config
  (pkg company-ghci :defer t))

(pkg
  intero
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

(provide 'haskell)

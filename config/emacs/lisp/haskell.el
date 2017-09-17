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

;; Zeal setup
(pkg zeal-at-point :ensure t)
(add-to-list 'zeal-at-point-mode-alist '(haskell-mode . "haskell"))
(global-set-key "\C-cd" 'zeal-at-point)
(add-to-list 'exec-path "/usr/bin/zeal")

(provide 'haskell)

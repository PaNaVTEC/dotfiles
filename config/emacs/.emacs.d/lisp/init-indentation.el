(use-package
  highlight-indent-guides
  :ensure t
  :defer t
  :config
  (setq
    highlight-indent-guides-character ?│
    highlight-indent-guides-method 'character)
    highlight-indent-guides-responsive 'top)

(provide 'init-indentation)

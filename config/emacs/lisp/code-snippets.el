(use-package
  yasnippet
  :ensure t
  :defer t
  :diminish yas-minor-mode
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))
(use-package yasnippet-snippets :ensure t :defer t)

(provide 'code-snippets)

(use-package
  yasnippet
  :ensure t
  :defer t
  :diminish yas-minor-mode
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))

(provide 'init-code-snippets)

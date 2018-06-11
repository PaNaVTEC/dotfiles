(use-package
  yasnippet
  :ensure t
  :defer t
  :diminish yas-minor-mode
  :config
  (setq yas-snippet-dirs '((concat emacs-dir "snippets"))))

(provide 'init-code-snippets)

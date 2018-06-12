(use-package
  yasnippet
  :ensure t
  :defer t
  :diminish yas-minor-mode
  :config
  (setq yas-snippet-dirs (list (concat emacs-dir "snippets"))))

(provide 'init-code-snippets)

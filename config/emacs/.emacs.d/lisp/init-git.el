(use-package magit :ensure t :defer t)
(use-package
  evil-magit
  :ensure t
  :defer t
  :config
  (evil-collection-init 'magit))

(provide 'init-git)

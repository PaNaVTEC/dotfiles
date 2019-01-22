(use-package
  projectile
  :ensure t
  :config
  (projectile-mode))

(use-package
  perspective
  :ensure t
  :after projectile
  :config
  (persp-mode)

  (define-key evil-normal-state-map (kbd "[p") 'persp-prev)
  (define-key evil-normal-state-map (kbd "]p") 'persp-next)
  (evil-leader/set-key "p" 'projectile-persp-switch-project)
  (use-package persp-projectile :ensure t))

;; CtrlP like
(use-package
  helm-projectile
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
  (location-list-buffer (rx bos "*helm projectile")))

(provide 'init-projectmanagement)

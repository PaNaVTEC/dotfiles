(use-package
  projectile
  :ensure t
  :config
  (projectile-mode))

(use-package
  perspective
  :ensure t
  :after projectile
  :bind ("C-x C-b" . persp-list-buffers)
  :custom (persp-mode-prefix-key (kbd "C-c M-p"))
  :config
  (persp-mode)

  (defadvice projectile-persp-switch-project (before hide-neotree-w activate)
    (neotree-hide))
  (defadvice projectile-persp-switch-project (after change-neotree-dir activate)
    (neotree-projectile-action))

  (location-list-buffer (rx bos "*helm-mode-persp"))

  (set-face-foreground 'persp-selected-face "#81A1C1")
  (define-key evil-normal-state-map (kbd "[p") 'persp-prev)
  (define-key evil-normal-state-map (kbd "]p") 'persp-next)
  (evil-leader/set-key "p" 'projectile-persp-switch-project)
  (use-package persp-projectile :ensure t))

;; CtrlP like
(use-package
  helm-projectile
  :ensure t
  :config
  (global-set-key (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
  (location-list-buffer (rx bos "*helm projectile")))

(provide 'init-projectmanagement)

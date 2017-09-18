(pkg
  powerline
  :ensure t
  :config
  (powerline-center-evil-theme)

  (pkg flycheck-color-mode-line
       :ensure t
       :config
       (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))

(pkg
  zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

(set-default-font "xos4 Terminus")
(set-face-attribute 'default nil :height 150)

(provide 'appearance)

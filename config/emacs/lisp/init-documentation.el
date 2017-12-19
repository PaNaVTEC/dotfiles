(pkg
  helm-dash
  :ensure t
  :config
  (setq helm-dash-docsets-path "~/.local/share/Zeal/Zeal/docsets")
  (evil-leader/set-key "d" 'helm-dash-at-point))

(provide 'init-documentation)

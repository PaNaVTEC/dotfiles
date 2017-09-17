(pkg
  neotree
  :ensure t
  :init
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (global-set-key (kbd "C-n") 'neotree-toggle)
  (define-key evil-normal-state-map (kbd "C-n") 'neotree-toggle))

(provide 'file-explorer)

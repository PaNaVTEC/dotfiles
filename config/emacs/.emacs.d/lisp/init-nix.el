(require 'init-programming-mode)

(use-package
  nix-mode
  :ensure t
  :mode "\\.nix\\'"
  :defer t
  :config
  (set-company-backend-for 'nix-mode-hook 'company-nixos-options)
  (add-hook 'nix-mode-hook 'programming-mode))

(use-package nixos-options :ensure t :defer t)
(use-package nix-sandbox :ensure t :defer t)
(use-package company-nixos-options :ensure t :defer t)

(provide 'init-nix)

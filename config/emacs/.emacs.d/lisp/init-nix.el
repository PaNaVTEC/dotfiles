(require 'init-programming-mode)

(use-package
  nix-mode
  :ensure t
  :mode "\\.nix\\'"
  :defer t
  :config

  (use-package nixos-options :ensure t :defer t)
  (use-package nix-sandbox :ensure t :defer t)
  (use-package company-nixos-options
    :ensure t
    :defer t
    :config
    (add-hook 'js-mode-hook
              (lambda () (add-to-list 'company-backends 'company-nixos-options))))

(add-hook 'nix-mode-hook 'programming-mode)
(add-hook 'nix-mode-hook 'company-mode))

(provide 'init-nix)

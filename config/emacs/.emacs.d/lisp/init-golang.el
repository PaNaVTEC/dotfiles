(require 'init-programming-mode)

(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :ensure t
  :config
    (set-compile-for 'go-mode-hook "go build")
    (set-company-backend-for 'go-mode-hook 'company-go)
    (add-hook 'before-save-hook 'gofmt-before-save)

    (add-hook 'go-mode-hook 'programming-mode))

(use-package company-go :ensure t :defer t)

(provide 'init-golang)

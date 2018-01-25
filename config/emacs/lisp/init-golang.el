(require 'programming-mode)

(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :ensure t
  :config
    (set-compile-for 'go-mode-hook "go build")
    (add-hook 'before-save-hook 'gofmt-before-save)

    (add-hook 'go-mode-hook 'programming-mode)
    (add-hook 'go-mode-hook 'company-mode))

(use-package
  company-go
  :ensure t
  :defer t
  :config
  (add-hook 'go-mode-hook
    (lambda () (add-to-list 'company-backends 'company-go))))

(provide 'init-golang)

(add-hook 'text-mode-hook
          (lambda () (progn
                  (wc-mode +1)
                  (writegood-mode +1)
                  (flyspell-mode +1)
                  (flyspell-buffer))))

(use-package helm-flyspell :ensure t :defer t)
(use-package wc-mode :diminish flyspell-mode :ensure t :defer t)
(use-package writegood-mode :diminish writegood-mode :ensure t :defer t)
(use-package writeroom-mode :diminish writeroom-mode :ensure t :defer t)

(evil-leader/set-key "c" 'helm-flyspell-correct)

(provide 'init-text)

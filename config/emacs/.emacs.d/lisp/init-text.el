(define-minor-mode good-spelling-mode
  "Mode for regular text editing"
  nil " T" nil

  (use-package helm-flyspell :ensure t :defer t)
  (use-package wc-mode :diminish flyspell-mode :ensure t :defer t)
  (use-package writegood-mode :diminish writegood-mode :ensure t :defer t)
  (use-package writeroom-mode :diminish writeroom-mode :ensure t :defer t)

  (evil-leader/set-key "c" 'helm-flyspell-correct)

  (if good-spelling-mode
      (progn
        (wc-mode +1)
        (writegood-mode +1)
        (flyspell-mode +1)
        (flyspell-buffer))
    (progn
      (wc-mode -1)
      (writegood-mode -1)
      (flyspell-mode -1))))

(provide 'init-text)

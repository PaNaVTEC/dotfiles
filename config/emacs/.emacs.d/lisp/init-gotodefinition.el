(use-package dumb-jump
  :pin melpa-stable
  :ensure t
  :defer t
  :config
    (setq dumb-jump-selector 'helm)

    (define-key evil-normal-state-map (kbd "]j") 'dumb-jump-go)
    (define-key evil-normal-state-map (kbd "[j") 'dumb-jump-back)

    (location-list-buffer (rx bos "*helm dumb jump choices*")))

(provide 'init-gotodefinition)

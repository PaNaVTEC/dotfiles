(pkg
  which-key
  :ensure t
  :defer t
  :config
  (which-key-mode +1)
  (setq which-key-idle-delay 0.7
        which-key-popup-type 'minibuffer))

(provide 'key-helper)


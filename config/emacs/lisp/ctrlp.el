(pkg
  helm-projectile
  :ensure t
  :config
  (global-set-key (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
  (add-to-list 'display-buffer-alist `(,(rx bos "*helm projectile*" eos)
                                       (display-buffer-reuse-window display-buffer-in-side-window)
                                       (side            . bottom)
                                       (reusable-frames . visible)
                                       (window-height   . 0.33))))

(provide 'ctrlp)

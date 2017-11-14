;; Don't change directory after navigating
(add-hook 'find-file-hook
          (lambda ()
            (setq default-directory command-line-default-directory)))
(pkg
  helm-projectile
  :ensure t
  :config
  (global-set-key (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
  (location-list-buffer (rx bos "*helm projectile*")))

(provide 'ctrlp)

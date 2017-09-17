(pkg
  linum-relative
  :diminish linum-relative-mode
  :ensure t
  :config
  (linum-relative-global-mode)
  (setq
    linum-relative-current-symbol ""
    linum-relative-format "%3s ")) ;; Add \u2502 for more separation

(provide 'relative-lines)

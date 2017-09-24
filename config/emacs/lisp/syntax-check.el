(pkg
  flycheck
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "]w") 'flycheck-next-error)
  (define-key evil-normal-state-map (kbd "[w") 'flycheck-previous-error)
  (add-to-list 'display-buffer-alist `(,(rx bos "*Flycheck errors*" eos)
                                       (display-buffer-reuse-window display-buffer-in-side-window)
                                       (side            . bottom)
                                       (reusable-frames . visible)
                                       (window-height   . 0.33))))

(provide 'syntax-check)

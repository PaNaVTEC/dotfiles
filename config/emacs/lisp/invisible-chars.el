(pkg
  whitespace
  :diminish whitespace-mode
  :init
  (progn
    (setq whitespace-line-column 80)
    (setq whitespace-style '(face trailing leading tabs newline tab-mark lines-tail newline-mark))
    (setq whitespace-display-mappings '((newline-mark 10 [172 10]))))
:config
  (evil-leader/set-key "w" 'whitespace-cleanup))

(provide 'invisible-chars)

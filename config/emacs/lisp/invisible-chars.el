(use-package
  whitespace
  :init
  (progn
    (setq whitespace-line-column 80)
    (setq whitespace-style '(face tabs empty trailing lines-tail newline-mark))
    (setq
      whitespace-display-mappings
      '((newline-mark 10 [172 10])))))
  :config
    (evil-leader/set-key "w" 'whitespace-cleanup)
(provide 'invisible-chars)

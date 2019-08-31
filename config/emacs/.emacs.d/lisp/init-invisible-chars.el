(require 'whitespace)

(progn
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face
                           indentation
                           newline
                           newline-mark
                           empty
                           lines-tail
                           space-after-tab::tab
                           space-before-tab::tab
                           tab-mark
                           tabs
                           trailing))
  (setq whitespace-display-mappings '((newline-mark 10 [172 10])
                                      (space-mark 32 [183] [46])))
  (set-face-attribute 'whitespace-trailing nil :background "#B48EAD")
  (set-face-attribute 'whitespace-empty nil :background "#B48EAD")
  (evil-leader/set-key "w" 'whitespace-cleanup))

(provide 'init-invisible-chars)

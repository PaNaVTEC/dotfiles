(pkg
  rainbow-delimiters
  :ensure t
  :config
  (require 'cl-lib)
  (require 'color)
  (cl-loop
    for index from 1 to rainbow-delimiters-max-face-count
    do
    (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
      (cl-callf color-saturate-name (face-foreground face) 30))))

(provide 'rainbow-parenthesis)

(require 'prettify)
(require 'proper-gutter-mode)
(require 'invisible-chars)
(require 'syntax-check)
(require 'rainbow-parenthesis)

(define-minor-mode
  programming-mode
  :lighter " P"
  :group 'programming

  (setq show-paren-delay 0)

  (if programming-mode
    (progn
      (prettify-symbols-mode +1)
      (whitespace-mode +1)
      (proper-gutter-mode +1)
      (rainbow-delimiters-mode +1)
      (show-paren-mode +1)
      (flycheck-mode +1))
    (progn
      (prettify-symbols-mode -1)
      (whitespace-mode -1)
      (proper-gutter-mode -1)
      (rainbow-delimiters-mode -1)
      (show-paren-mode -1)
      (flycheck-mode -1))))

(provide 'programming-mode)

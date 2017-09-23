(require 'prettify)
(require 'proper-gutter-mode)
(require 'invisible-chars)
(require 'syntax-check)

(define-minor-mode
  programming-mode
  :lighter " P"
  :group 'programming

  (if programming-mode
    (progn
      (prettify-symbols-mode +1)
      (whitespace-mode +1)
      (proper-gutter-mode +1)
      (flycheck-mode +1))
    (progn
      (prettify-symbols-mode -1)
      (whitespace-mode -1)
      (proper-gutter-mode -1)
      (flycheck-mode -1))))

(provide 'programming-mode)

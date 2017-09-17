(setq prettify-symbols-unprettify-at-point 'right-edge)
(defun prettify (symbols)
  (dolist (sym symbols)
    (push sym prettify-symbols-alist)))

(provide 'prettify)

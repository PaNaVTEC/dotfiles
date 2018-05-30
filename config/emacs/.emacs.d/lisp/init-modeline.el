(use-package nyan-mode :ensure t)

(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
               (output ""))
       (when (and path (equal "" (car path)))
         (setq path (cdr path)))
       (while (and path (< (length output) (- max-length 4)))
         (setq output (concat (car path) "/" output))
         (setq path (cdr path)))
       (when path
         (setq output (concat ".../" output)))
       output))

(defvar mode-line-directory
  '(:propertize
    (:eval (if (buffer-file-name) (concat " " (shorten-directory default-directory 20)) " "))
                face mode-line-directory)
  "Formats the current directory.")
(put 'mode-line-directory 'risky-local-variable t)
(setq-default mode-line-buffer-identification
  (propertized-buffer-identification "%b "))

(defun mode-line-id ()
  (if buffer-file-name
    buffer-file-name
    mode-line-buffer-identification))

(setq-default
  mode-line-format
  (list
    " "
    mode-line-modified
    mode-line-frame-identification
    " "
    mode-line-directory
    mode-line-buffer-identification
    " "
    '(:eval (list (nyan-create)))
    "  "
    "%02l" "/" "%01c"
    'vc-mode-line
    "   "
    mode-line-modes))

(provide 'init-modeline)

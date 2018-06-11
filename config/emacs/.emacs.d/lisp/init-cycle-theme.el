(defvar themes-index)
(setq themes-index -1)

(defun cycle-theme ()
  (interactive)
  (setq themes-index (% (1+ themes-index) (length available-themes)))
  (load-indexed-theme))

(defun load-indexed-theme ()
  (try-load-theme (nth themes-index available-themes)))

(defun try-load-theme (theme)
  (if (ignore-errors (load-theme theme :no-confirm))
    (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))

(with-eval-after-load
  'evil-leader
  (evil-leader/set-key "\\" 'cycle-theme))

(cycle-theme)
(provide 'init-cycle-theme)

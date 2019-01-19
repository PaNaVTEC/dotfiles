(defun copy-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
    (progn
      (cond
        ((and (display-graphic-p) select-enable-clipboard)
         (gui-set-selection 'CLIPBOARD (buffer-substring (region-beginning) (region-end))))
        (t (shell-command-on-region (region-beginning) (region-end)
                                    (cond
                                      (*cygwin* "putclip")
                                      (*is-a-mac* "pbcopy")
                                      (*linux* "xsel -ib")))
           ))
      (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))

(define-key evil-motion-state-map (kbd "M-c") 'copy-to-x-clipboard)
(global-set-key (kbd "C-S-V") 'yank)

(provide 'init-clipboard)

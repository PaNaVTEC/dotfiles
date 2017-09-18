(defun search-text-in-project (term)
  (grep-compute-defaults)
    (interactive "sSearch Term: ")
    (rgrep term "*.*" "./"))

(evil-ex-define-cmd "Ack" 'search-text-in-project)

(provide 'acklike)

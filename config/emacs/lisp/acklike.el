(evil-define-command
  evil-ack (arg)
  (interactive "<a>")
  (progn (grep-compute-defaults)
         (rgrep arg "*.*" "./")))

(evil-ex-define-cmd "Ack" 'evil-ack)

(provide 'acklike)

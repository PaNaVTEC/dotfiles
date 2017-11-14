(evil-define-command
  evil-ack (arg)
  (interactive "<a>")
  (progn (grep-compute-defaults)
         (rgrep arg "*.*" "./")))

(evil-ex-define-cmd "Ack" 'evil-ack)
(customize-set-variable
  'grep-find-ignored-directories
  (list "SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "objects" "build" "bin" "out" "lib" "dist" "node_modules"))

(provide 'acklike)

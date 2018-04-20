(require 'grep)

(evil-define-command
  evil-ack (to-search)
  (interactive "<a>")
  (my-ack to-search (projectile-project-root)))

(evil-define-command
  evil-ack-in (to-search path)
  (interactive "<a>\n"  (list (read-file-name (projectile-project-root))))
  (my-ack to-search path))
(location-list-buffer (rx bos "*helm-mode-evil-ack-in*"))
(location-list-buffer (rx bos "*grep*"))

(defun my-ack (arg path-to-search)
  (progn (grep-compute-defaults)
         (rgrep arg "*.*" path-to-search)))

(evil-ex-define-cmd "Ack" 'evil-ack)
(evil-ex-define-cmd "ack" 'evil-ack)
(evil-ex-define-cmd "ackin" 'evil-ack-in)

(customize-set-variable
  'grep-find-ignored-directories
  (list "SCCS" "RCS" "CVS" "MCVS" ".svn" "coverage" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "objects" "build" "bin" "out" "lib" "dist" "node_modules" ".nyc_output" ".awcache"))

(grep-apply-setting 'grep-find-template "find <D> <X> -type f <F> -exec grep <C> -n --null -r -E -o \".{0,50}<R>.{0,50}\" /dev/null \{\} +")

(use-package
  xah-find
  :ensure t
  :defer t
  :config
  (location-list-buffer (rx bos "*xah-find output*")))

(provide 'init-acklike)

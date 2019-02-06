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
  (list "SCCS" "RCS" "CVS" "MCVS" ".svn" "coverage" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "objects" "build" "bin" "out" "lib" "dist" "node_modules" ".nyc_output" ".awcache" ".stack-work"))

(grep-apply-setting 'grep-find-template "find <D> <X> -type f <F> -exec grep <C> -n --null -r -E -o \".{0,50}<R>.{0,50}\" /dev/null \{\} +")

(use-package
  xah-find
  :ensure t
  :defer t
  :config
  (location-list-buffer (rx bos "*xah-find output*")))

(use-package
  helm-ag
  :ensure t
  :defer t
  :config
  (custom-set-variables
   '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
   '(helm-ag-command-option "--hidden --width 120")
   '(helm-ag-use-grep-ignore-list t)
   '(helm-ag-insert-at-point 'word)
   '(helm-ag-use-agignore t)))

(defun helm-do-ag-projectile-root ()
  (interactive)
  (let ((rootdir (projectile-project-root)))
    (unless rootdir
      (error "Could not find the project root. Use projectile swith project"))
    (helm-do-ag rootdir)))

(global-set-key (kbd "C-S-f") 'helm-do-ag-projectile-root)

(provide 'init-acklike)

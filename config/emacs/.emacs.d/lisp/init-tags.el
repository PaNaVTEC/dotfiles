(defun initialize-project-tags ()
  (setq my-tags-current-project (concat (projectile-project-root) "TAGS"))
  (if (file-exists-p my-tags-current-project)
      (visit-tags-table my-tags-current-project)))

(use-package helm-xref
  :ensure t
  :init (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  :config
  (location-list-buffer (rx bos "*helm-xref*")))

(provide 'init-tags)

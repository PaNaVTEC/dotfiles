(require 'init-helm-xref)

(defun initialize-project-tags ()
  (setq my-tags-current-project (concat (projectile-project-root) "TAGS"))
  (if (file-exists-p my-tags-current-project)
      (visit-tags-table my-tags-current-project)))

(setq xref-show-xrefs-function 'helm-xref-show-xrefs)
(set-face-foreground 'helm-xref-file-name "#81A1C1")
(setq helm-xref-candidate-formatting-function  'helm-xref-format-candidate-long)
(location-list-buffer (rx bos "*helm-xref*"))

; Waiting for @brotzeit in github to answer, so we can use the module instead of forking his plugin
; (use-package helm-xref
;   :ensure t
;   :init (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
;   :config
;   (set-face-foreground 'helm-xref-file-name "#81A1C1")
;
;   (helm-build-sync-source "Helm Xref"
;     :candidates (lambda ()
;                   helm-xref-alist)
;     :persistent-action (lambda (xref-item) (helm-xref-goto-xref-item xref-item 'display-buffer))
;     :action '(("Switch to buffer" . (lambda (xref-item) (helm-xref-goto-xref-item xref-item 'switch-to-buffer)))
;               ("Other window" . (lambda (xref-item) (helm-xref-goto-xref-item xref-item 'dired-other-window))))
;     :candidate-number-limit 9999)
;
;   (setq helm-xref-candidate-formatting-function  'helm-xref-format-candidate-long)
;   (location-list-buffer (rx bos "*helm-xref*")))

(provide 'init-tags)

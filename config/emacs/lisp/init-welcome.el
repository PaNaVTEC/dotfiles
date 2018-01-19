;; Initial mode in text avoids lag
;(setq initial-major-mode 'text-mode
;      initial-scratch-message nil)

(pkg
  dashboard
  :ensure t
  :config
  (setq dashboard-startup-banner 'official)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (registers . 5)))
  (dashboard-setup-startup-hook))

(provide 'init-welcome)

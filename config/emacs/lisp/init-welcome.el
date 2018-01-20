;; Initial mode in text avoids lag
(setq ;initial-major-mode 'text-mode
  initial-scratch-message nil)

(pkg
  page-break-lines
  :ensure t)

(pkg
  dashboard
  :ensure t
  :after page-break-lines
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'official
        dashboard-items '((projects  . 10)
                          (recents . 10))))

(provide 'init-welcome)

;; Initial mode in text avoids lag
(setq ;initial-major-mode 'text-mode
  initial-scratch-message nil)

(use-package page-break-lines :ensure t)

(use-package
  dashboard
  :ensure t
  :after page-break-lines
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'official
        dashboard-items '((projects  . 10)
                          (recents . 10))))

(provide 'init-welcome)

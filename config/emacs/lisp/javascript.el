(pkg
  js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node"
  :config
  (setq js-indent-level 2
        evil-shift-width 2
        js2-basic-offset 2
        js2-strict-missing-semi-warning nil)
  ;(setq js2-mode-show-strict-warnings nil)
  ;(setq js2-mode-show-parse-errors nil)
  (add-hook 'flycheck-mode-hook
            (lambda () (flycheck-add-mode 'javascript-standard 'js2-mode))))

(pkg rjsx-mode :ensure t :mode "\\.jsx$" :mode "components/.+\\.js$")
(pkg tern :defer t :init (add-hook 'js2-mode-hook 'tern-mode))
(pkg js2-refactor :ensure t)
(pkg json-mode :ensure t :mode "\\.json\\'")
(pkg
  company-tern
  :ensure t
  :defer t
  :init
  (add-hook 'js2-mode-hook
            (lambda () (add-to-list 'company-backends 'company-tern))))

(provide 'javascript)

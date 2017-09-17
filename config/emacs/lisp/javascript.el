(require 'prettify)

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

  (defun javascript/prettify ()
    (prettify
      '(("<-" . ?←)
        ("function" . ?ƒ)
        ("NaN" . ?ℕ)
        ("this" . ?@)
        ("=>" . ?⇒)
        ("<=" . ?≤)
        (">=" . ?≥)
        ("!=" . ?≠))))
  (add-hook 'js2-mode-hook 'prettify-symbols-mode)
  (add-hook 'js2-mode-hook 'javascript/prettify)

  ;; Lint
  (add-hook 'flycheck-mode-hook
            (lambda () (flycheck-add-mode 'javascript-standard 'js2-mode))))

(pkg rjsx-mode :ensure t :mode "\\.jsx$" :mode "components/.+\\.js$")
(pkg tern :defer t :init (add-hook 'js2-mode-hook 'tern-mode))
(pkg
  js2-refactor
  :ensure t
  :config
  (evil-leader/set-key "v" 'js2r-extract-var)
  (evil-leader/set-key "m" 'js2r-extract-method)
  (evil-leader/set-key "f" 'js2r-extract-function)
  (evil-leader/set-key "n" 'js2r-inline-var)
  (evil-leader/set-key "r" 'js2r-rename-var))

(pkg json-mode :ensure t :mode "\\.json\\'")
(pkg
  company-tern
  :ensure t
  :defer t
  :init
  (add-hook 'js2-mode-hook
            (lambda () (add-to-list 'company-backends 'company-tern))))

(provide 'javascript)

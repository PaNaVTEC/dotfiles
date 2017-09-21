(require 'prettify)
(require 'proper-gutter-mode)

(defun prettify-js-for (mode-hook)
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
  (add-hook mode-hook 'prettify-symbols-mode)
  (add-hook mode-hook 'javascript/prettify))

(pkg
  js2-mode
  :ensure t
  :mode "\\.js$"
  :interpreter "node"
  :config
  (setq js-indent-level 2
        evil-shift-width 2
        js2-basic-offset 2
        js2-bounce-indent-p t
        js2-strict-missing-semi-warning nil)

  (add-hook 'js2-mode-hook 'company-mode)
  (add-hook 'js2-mode-hook 'proper-gutter-mode)
  (prettify-js-for 'js2-mode-hook)
  (add-hook
    'flycheck-mode-hook
    (lambda () (progn (flycheck-add-mode 'javascript-standard 'js2-mode)))))

(pkg
  web-mode
  :ensure t
  :mode "\\.jsx$"
  :mode "components/.+\\.js$"
  :interpreter "node"
  :config
  (setq web-mode-code-indent-offset 2)
  (add-hook 'web-mode-hook 'company-mode)
  (add-hook 'web-mode-hook 'proper-gutter-mode)
  (prettify-js-for 'web-mode-hook)
  (add-hook
    'flycheck-mode-hook
    (lambda () (progn (flycheck-add-mode 'javascript-standard 'web-mode)))))

(pkg tern
     :defer t
     :init
     (progn
       (add-hook 'js2-mode-hook 'tern-mode)
       (add-hook 'web-mode-hook 'tern-mode)))

(pkg
  js2-refactor
  :ensure t
  :config

  (evil-leader/set-key "v" 'js2r-extract-var)
  (evil-leader/set-key "m" 'js2r-extract-method)
  (evil-leader/set-key "f" 'js2r-extract-function)
  (evil-leader/set-key "n" 'js2r-inline-var)
  (evil-leader/set-key "r" 'js2r-rename-var))

(pkg
  json-mode
  :ensure t
  :mode "\\.json\\'"
  :config
  (add-hook 'json-mode-hook 'proper-gutter-mode))

(pkg
  company-tern
  :ensure t
  :defer t
  :init
  (add-hook
    'web-mode-hook
    (lambda () (add-to-list 'company-backends 'company-tern)))
  (add-hook
    'js2-mode-hook
    (lambda () (add-to-list 'company-backends 'company-tern))))

(provide 'javascript)

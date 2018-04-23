(require 'init-programming-mode)

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
  (add-hook mode-hook 'javascript/prettify))

(use-package
  indium
  :ensure t
  :mode "\\.jsx?$"
  :defer t
  :config
  (setq indium-chrome-executable my-browser))

(use-package
  js2-mode
  :ensure t
  :mode ("\\.js$" . js2-mode )
  :mode ("\\.jsx$" . js2-jsx-mode )
  :interpreter "node"
  :defer t
  :config
  (setq js-indent-level 2
        evil-shift-width 2
        js-switch-indent-offset 2
        js2-basic-offset 2
        js2-bounce-indent-p -1
        js2-assume-strict t
        sgml-basic-offset 2
        c-basic-offset 2
        js2-pretty-multiline-declarations 'all
        js2-strict-missing-semi-warning nil)

  (set-compile-for 'js-mode-hook "yarn test:unit")

  (add-hook 'js-mode-hook 'programming-mode)
  (add-hook 'js-mode-hook 'company-mode)
  (add-hook 'js-mode-hook 'js-doc)
  (prettify-js-for 'js-mode-hook)
  (add-hook
    'flycheck-mode-hook
    (lambda () (progn
                 (flycheck-add-mode 'javascript-standard 'js2-mode)
                 (flycheck-add-mode 'javascript-standard 'js2-jsx-mode)
                 (add-to-list 'flycheck-disabled-checkers 'javascript-eslint)))))

(use-package
  web-mode
  :ensure t
  :mode "\\.x?html?$"
  :mode "\\.hbs$"
  :defer t
  :config
  (setq
    web-mode-markup-indent-offset 2
    web-mode-code-indent-offset 2)
  (add-hook 'web-mode-hook 'programming-mode))

(use-package tern :defer t :config (add-hook 'js-mode-hook 'tern-mode))

(use-package
  js2-refactor
  :ensure t
  :defer t
  :config

  (evil-leader/set-key "v" 'js2r-extract-var)
  (evil-leader/set-key "m" 'js2r-extract-method)
  (evil-leader/set-key "f" 'js2r-extract-function)
  (evil-leader/set-key "n" 'js2r-inline-var)
  (evil-leader/set-key "r" 'js2r-rename-var))

(use-package
  json-mode
  :ensure t
  :mode "\\.json\\'"
  :defer t
  :config
  (setq json-reformat:indent-width 2
        js-indent-level 2)
  (add-hook 'json-mode-hook 'whitespace-mode)
  (add-hook 'json-mode-hook 'proper-gutter-mode))

(use-package
  company-tern
  :ensure t
  :defer t
  :config
  (add-hook 'js-mode-hook
    (lambda () (add-to-list 'company-backends 'company-tern))))

(defun js-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("JavaScript" "NodeJS" "React" "Sinon")))

(provide 'init-javascript)

(require 'init-programming-mode)

;(use-package
;  eglot
;  :ensure t)

(use-package
  lsp-mode
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "]w") 'flymake-goto-next-error)
  (define-key evil-normal-state-map (kbd "[w") 'flymake-goto-prev-error)
  (setq lsp-enable-snippet nil))

(use-package
  dart-mode
  :ensure t
  :mode "\\.dart$"
  :config
    (add-hook 'dart-mode-hook 'programming-mode)
    (add-hook 'dart-mode-hook 'lsp)
    (with-eval-after-load "projectile"
      (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
      (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))
    (setq lsp-auto-guess-root t)
;    (with-eval-after-load "eglot"
;      (add-to-list 'eglot-server-programs '(dart-mode . ("dart_language_server")))
;      (add-hook 'dart-mode-hook 'eglot-ensure))
    (setq dart-format-on-save t)
    (setq dart-sdk-path "~/flutter/bin/cache/dart-sdk/"))

(use-package
  flutter
  :ensure t
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload))
  :config
    (setq flutter-sdk-path "~/flutter/"))

(provide 'init-flutter)

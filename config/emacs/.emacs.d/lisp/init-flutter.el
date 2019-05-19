(require 'init-programming-mode)

(use-package
  dart-mode
  :ensure t
  :mode "\\.dart$"
  :config
    (add-hook 'dart-mode-hook 'programming-mode)
  :custom
  (dart-format-on-save t)
  (dart-enable-analysis-server t)
  (dart-sdk-path "/opt/dart-sdk"))

(use-package
  flutter
  :ensure t
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload))
  :custom
  (flutter-sdk-path "~/flutter/"))

(provide 'init-flutter)

(require 'bazel-mode)

(add-to-list 'load-path "/path/to/bazel-mode/directory")
(autoload 'bazel-mode "bazel-mode" "Major mode for Bazel BUILD files." t)
(add-to-list 'auto-mode-alist '("/BUILD\\(\\..*\\)?\\'" . bazel-mode))
(add-to-list 'auto-mode-alist '("/WORKSPACE\\'" . bazel-mode))
(add-to-list 'auto-mode-alist '("\\.\\(BUILD\\|WORKSPACE\\|bzl\\)\\'" . bazel-mode))

(provide 'init-bazel)

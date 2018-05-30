(use-package
  jdee
  :ensure t
  :mode ("\\.java$"  .  jdee-mode)
  :init
  (custom-set-variables
    '(jdee-server-dir "~/.jdee-server/target/"))
  :config
  (add-hook 'jdee-mode-hook 'programming-mode)
  (add-hook 'jdee-mode-hook 'company-mode))

(provide 'init-java)

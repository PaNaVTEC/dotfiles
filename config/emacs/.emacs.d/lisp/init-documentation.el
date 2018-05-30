(use-package
  helm-dash
  :pin melpa-stable
  :ensure t
  :defer t
  :config
  (location-list-buffer (rx bos "*helm-dash*"))
  (setq
   helm-dash-docsets-path "~/.local/share/Zeal/Zeal/docsets"
   helm-dash-browser-func 'eww))

(evil-leader/set-key "d" 'helm-dash-at-point)
(provide 'init-documentation)

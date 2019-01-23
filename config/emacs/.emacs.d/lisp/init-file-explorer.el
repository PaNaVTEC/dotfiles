(use-package
  neotree
  :ensure t
  :init
  (evil-define-key
    'normal neotree-mode-map
    (kbd "TAB") 'neotree-enter
    (kbd "RET") 'neotree-enter
    (kbd "I")   'neotree-hidden-file-toggle
    (kbd "i")   'neotree-enter-horizontal-split
    (kbd "s")   'neotree-enter-vertical-split
    (kbd "m")   'neotree-modify-mode-menu
    (kbd "p")   'neotree-open-file-in-system-application)

  (add-hook 'neo-change-root-hook #'neotree-resize-window)
  (add-hook 'neo-enter-hook #'neotree-resize-window)

  (evil-leader/set-key "f" 'neotree-find)

  (global-set-key (kbd "C-n") 'neotree-toggle)
  (define-key evil-normal-state-map (kbd "C-n") 'neotree-toggle)
  (setq-default neo-show-hidden-files t)
  (setq-default neo-auto-indent-point t)
  (setq-default neo-window-fixed-size nil))

(defun neotree-modify-mode-menu (option)
  "Asks for a mode and execute associated Neotree command"
  (interactive "c(a)dd node | (d)elete node | (c)opy node | (r)ename node")
  (cond
    ((eq option ?a) (call-interactively #'neotree-create-node))
    ((eq option ?d) (neotree-delete-node))
    ((eq option ?c) (neotree-copy-node))
    ((eq option ?r) (neotree-rename-node))
    (:else (message (format "Invalid option %c" option)))))

(location-list-buffer (rx bos "*helm-mode-evil-ack-in*"))
(location-list-buffer (rx bos "*helm-mode-neotree-"))
(location-list-buffer (rx bos "*helm-mode-neo-buffer--rename-node*"))

(provide 'init-file-explorer)

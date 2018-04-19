(use-package
  neotree
  :ensure t
  :init

  (evil-define-key
    'normal neotree-mode-map
    (kbd "TAB") 'neotree-enter
    (kbd "SPC") 'neotree-quick-look
    (kbd "q") 'neotree-hide
    (kbd "RET") 'neotree-enter
    (kbd "I") 'neotree-hidden-file-toggle
    (kbd "R") 'neotree-refresh
    (kbd "i") 'neotree-enter-horizontal-split
    (kbd "s") 'neotree-enter-vertical-split
    (kbd "m") 'neotree-modify-mode-menu)

  (evil-leader/set-key "f" 'neotree-find)

  (global-set-key (kbd "C-n") 'neotree-toggle)
  (define-key evil-normal-state-map (kbd "C-n") 'neotree-toggle)
  (setq-default neo-show-hidden-files t))

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

(provide 'file-explorer)

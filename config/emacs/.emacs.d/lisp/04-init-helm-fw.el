;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(use-package helm
     :init (use-package helm-projectile :ensure t)
     :diminish (helm-mode . "")
     :config
     (require 'helm-misc)
     (require 'helm-projectile)
     (require 'helm-locate)
     (helm-buffer-list)
     (helm-mode 1)
     (define-key evil-normal-state-map (kbd "<backtab>") 'helm-mini)
     (setq
       helm-quick-update t
       helm-bookmark-show-location t
       helm-buffers-fuzzy-matching t)

     (location-list-buffer (rx bos "*helm M-x"))
     (location-list-buffer (rx bos "*helm mini"))
     (location-list-buffer (rx bos "*helm-ag"))
     (location-list-buffer (rx bos "*helm-mode-completion-at-point*"))
     ;; Override default command launcher
     (global-set-key (kbd "M-x") 'helm-M-x)
     (evil-leader/set-key "hr" 'helm-resume))

(provide '04-init-helm-fw)

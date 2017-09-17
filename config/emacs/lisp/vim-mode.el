(pkg
  evil
  :ensure t
  :config
  (evil-mode 1)

  (pkg
    evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ","))

  (pkg
    evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (pkg evil-indent-textobject :ensure t)

  ;; Visual line navigation
  (define-key evil-normal-state-map (kbd "gj") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "g <down>") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "gk") 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "g <up>") 'evil-previous-visual-line)

  ;; Buffer navigation
  (define-key evil-normal-state-map (kbd "C-w <up>") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-w <down>") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-w <left>") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-w <right>") 'evil-window-right)

  ;; Typo avoider
  (evil-ex-define-cmd "WQ" 'evil-save-and-quit)
  (evil-ex-define-cmd "Wq" 'evil-save-and-quit)
  (evil-ex-define-cmd "W" 'evil-write)
  (evil-ex-define-cmd "Wa" 'evil-write-all)
  (evil-ex-define-cmd "Q" 'evil-quit)
  (evil-ex-define-cmd "Qa" 'evil-quit-all))

(defun insert-cursor () (send-string-to-terminal "\e[6 q"))
(defun box-cursor () (send-string-to-terminal "\e[2 q"))
(unless (and (null (getenv "TMUX")) (display-graphic-p))
  (add-hook 'evil-insert-state-entry-hook 'insert-cursor)
  (add-hook 'evil-insert-state-exit-hook 'box-cursor)
  (add-hook 'kill-emacs-hook 'box-cursor)
  (add-hook 'evil-normal-state-entry-hook 'box-cursor)
  (add-hook 'evil-motion-state-entry-hook 'box-cursor))

(provide 'vim-mode)

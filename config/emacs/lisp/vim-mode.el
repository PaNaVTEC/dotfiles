(pkg
  evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-motion-state-map (kbd "C-z") 'suspend-emacs)

  ;; Visual line navigation
  (define-key evil-motion-state-map (kbd "gj") 'evil-next-visual-line)
  (define-key evil-motion-state-map (kbd "g <down>") 'evil-next-visual-line)
  (define-key evil-motion-state-map (kbd "gk") 'evil-previous-visual-line)
  (define-key evil-motion-state-map (kbd "g <up>") 'evil-previous-visual-line)

  ;; Window navigation
  (define-key evil-motion-state-map (kbd "C-w <up>") 'evil-window-up)
  (define-key evil-motion-state-map (kbd "C-w <down>") 'evil-window-down)
  (define-key evil-motion-state-map (kbd "C-w <left>") 'evil-window-left)
  (define-key evil-motion-state-map (kbd "C-w <right>") 'evil-window-right)

  ;; Buffer navigation
  (define-key evil-motion-state-map (kbd "[ b") 'evil-prev-buffer)
  (define-key evil-motion-state-map (kbd "] b") 'evil-next-buffer)

  ;; Reload config
  (evil-ex-define-cmd "ReloadConfig" '(lambda () (interactive) (load-file "~/.emacs.d/init.el")))

  ;; Typo avoider
  (evil-ex-define-cmd "WQ" "wq")
  (evil-ex-define-cmd "Wq" "wq")
  (evil-ex-define-cmd "wqa" "xall")
  (evil-ex-define-cmd "Wqa" "xall")
  (evil-ex-define-cmd "WQa" "xall")
  (evil-ex-define-cmd "WQA" "xall")
  (evil-ex-define-cmd "W" "w")
  (evil-ex-define-cmd "Wa" 'evil-write-all)
  (evil-ex-define-cmd "Q" "q")
  (evil-ex-define-cmd "Qa" "qa"))

(pkg
  evil-surround
  :ensure t
  :config
  (global-evil-surround-mode))

(pkg
  evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader ","))

(pkg
  evil-numbers
  :ensure t
  :config

  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt))

;; Cursor shape in insert/visual mode
(defun insert-cursor () (send-string-to-terminal "\e[6 q"))
(defun box-cursor () (send-string-to-terminal "\e[2 q"))
(unless (and (null (getenv "TMUX")) (display-graphic-p))
  (add-hook 'evil-insert-state-entry-hook 'insert-cursor)
  (add-hook 'evil-insert-state-exit-hook 'box-cursor)
  (add-hook 'kill-emacs-hook 'box-cursor)
  (add-hook 'evil-normal-state-entry-hook 'box-cursor)
  (add-hook 'evil-motion-state-entry-hook 'box-cursor))

(provide 'vim-mode)

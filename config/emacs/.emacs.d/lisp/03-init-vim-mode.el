(use-package
  evil
  :ensure t
  :init (setq evil-want-integration nil)
  :config
  (evil-mode 1)

  (unless (display-graphic-p)
    (use-package
      evil-terminal-cursor-changer
      :ensure t
      :init
      (setq
        evil-motion-state-cursor 'box
        evil-visual-state-cursor 'box
        evil-normal-state-cursor 'box
        evil-insert-state-cursor 'bar
        evil-emacs-state-cursor  'hbar)
      :config
      (evil-terminal-cursor-changer-activate)))

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
  (define-key evil-motion-state-map (kbd "C-w k") 'evil-window-up)
  (define-key evil-motion-state-map (kbd "C-w j") 'evil-window-down)
  (define-key evil-motion-state-map (kbd "C-w h") 'evil-window-left)
  (define-key evil-motion-state-map (kbd "C-w l") 'evil-window-right)

  ;; Buffer navigation
  (define-key evil-motion-state-map (kbd "[ b") 'evil-prev-buffer)
  (define-key evil-motion-state-map (kbd "] b") 'evil-next-buffer)

  (global-set-key (kbd "C-l") 'evil-search-highlight-persist-remove-all)

  ;;; esc quits
  (defun minibuffer-keyboard-quit ()
    "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
    (interactive)
    (if (and delete-selection-mode transient-mark-mode mark-active)
        (setq deactivate-mark  t)
      (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
      (abort-recursive-edit)))
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

  ;; Reload config
  (evil-ex-define-cmd
   "ReloadConfig"
   '(lambda () (interactive) (load-file (concat emacs-dir "init.el"))))

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
  (evil-ex-define-cmd "Qa" "qa")
  (evil-ex-define-cmd "E" "e"))

  (location-list-buffer (rx bos "*evil-registers*"))

(use-package
  evil-easymotion
  :ensure t
  :config
  (evilem-default-keybindings "SPC")
  (evilem-define (kbd "SPC <up>") #'evilem-motion-previous-line)
  (evilem-define (kbd "SPC <down>") #'evilem-motion-next-line)

  (evilem-define (kbd "SPC g <up>") #'evilem-motion-previous-visual-line)
  (evilem-define (kbd "SPC g <down>") #'evilem-motion-next-visual-line))

(use-package
  evil-surround
  :ensure t
  :config
  (global-evil-surround-mode)
  (add-to-list 'evil-surround-operator-alist '(evil-paredit-change . change))
  (add-to-list 'evil-surround-operator-alist '(evil-paredit-delete . delete)))

(use-package
  evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader ","))

(use-package
  evil-numbers
  :ensure t
  :config

  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt))

;(use-package evil-paredit :ensure t :defer t)
(use-package evil-collection
  :ensure t
  :defer t
  :init
  (evil-collection-init 'debug)
  (evil-collection-init 'diff-mode)
  (evil-collection-init 'dired)
  (evil-collection-init 'eshell)
  (evil-collection-init 'eww)
  (evil-collection-init 'help)
  (evil-collection-init 'compile))

(provide '03-init-vim-mode)

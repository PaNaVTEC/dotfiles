(pkg
  linum-relative
  :diminish linum-relative-mode
  :ensure t
  :config
  (setq
    linum-relative-current-symbol ""
    linum-relative-format "%3s ")) ;; Add \u2502 for more separation

(pkg
  git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
  (custom-set-variables
    '(git-gutter:window-width 1)
    ; Live update
    ;'(git-gutter:update-interval 2)
    '(git-gutter:modified-sign "~")
    ; No logs, set to 4 while debugging
    '(git-gutter:verbosity 0)
    '(git-gutter:added-sign "+")
    '(git-gutter:visual-line t)
    '(git-gutter:deleted-sign "-"))

  ;; Hunk navigation
  (define-key evil-normal-state-map (kbd "[h") 'git-gutter:previous-hunk)
  (define-key evil-normal-state-map (kbd "]h") 'git-gutter:next-hunk)

  ;; Hunk edition
  (evil-leader/set-key "z" 'git-gutter:revert-hunk)

  (global-git-gutter-mode t)
  (git-gutter:linum-setup))

(add-function
  :after (symbol-function 'git-gutter--turn-on)
  #'linum-relative-global-mode)

(provide 'relative-lines)

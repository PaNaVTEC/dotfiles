(define-minor-mode
  proper-gutter-mode
  "This mode defines the relative numbers + linum mode + git gutter at the
  left side. Ideal for programming, not needed for another buffers"
  :lighter " Gutter"
  :group 'proper-gutter

  ;; Configures relative mode
  (pkg
    linum-relative
    :diminish linum-relative-mode
    :ensure t
    :config
    (setq
      linum-relative-current-symbol ""
      linum-relative-format "%3s ")) ;; Add \u2502 for more separation

  ;; Configures git-gutter
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

    (git-gutter:linum-setup))

  (if proper-gutter-mode
    (progn
      (git-gutter-mode +1)
      (linum-relative-mode +1))
    (progn
      (git-gutter-mode -1)
      (linum-relative-mode -1))))

(provide 'proper-gutter-mode)

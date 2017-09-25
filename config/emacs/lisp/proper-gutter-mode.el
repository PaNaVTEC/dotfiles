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
    :defer t
    :config
    (setq
      linum-relative-current-symbol ""
      linum-relative-format "%3s "))

  ;; Configures git-gutter
  (pkg
    git-gutter
    :ensure t
    :diminish git-gutter-mode
    :config
    (custom-set-variables
      '(git-gutter:window-width 1)
      '(git-gutter:added-sign " ")
      '(git-gutter:deleted-sign " ")
      '(git-gutter:modified-sign " ")
      '(git-gutter:verbosity 0) ; No logs, set to 4 while debugging
      '(git-gutter:visual-line t))

    ;; Hunk navigation
    (define-key evil-normal-state-map (kbd "[h") 'git-gutter:previous-hunk)
    (define-key evil-normal-state-map (kbd "]h") 'git-gutter:next-hunk)

    ;; Hunk edition
    (evil-leader/set-key "z" 'git-gutter:revert-hunk))

  (defun proper-gutter-mode-on ()
    (if (>= emacs-major-version 26)
      (progn
        (setq display-line-numbers-type 'relative)
        (set-face-foreground 'line-number-current-line "gold3")
        (display-line-numbers-mode +1)
        (git-gutter-mode +1))
      (progn
        (git-gutter:linum-setup)
        (git-gutter-mode +1)
        (linum-relative-mode +1))))

  (defun proper-gutter-mode-off ()
    (if (>= emacs-major-version 26)
      (progn
        (display-line-numbers-mode -1)
        (git-gutter-mode -1))
      (progn
        (git-gutter-mode -1)
        (linum-relative-mode -1))))

  (if proper-gutter-mode (proper-gutter-mode-on) (proper-gutter-mode-off)))

(provide 'proper-gutter-mode)

(use-package
  diff-hl
  :ensure t
  :defer t
  :diminish ""
  :config
    (setq diff-hl-side 'left)

    (define-key evil-normal-state-map (kbd "[h") 'diff-hl-previous-hunk)
    (define-key evil-normal-state-map (kbd "]h") 'diff-hl-next-hunk)
    (evil-leader/set-key "z" 'diff-hl-revert-hunk)

    (set-face-background 'diff-hl-change "#81A1C1")
    (set-face-background 'diff-hl-insert "#A3BE8C")
    (set-face-background 'diff-hl-delete "#BF616A")

    (setq
      diff-hl-margin-symbols-alist
      '((insert . " ") (delete . " ") (change . " ") (unknown . " ") (ignored . " ")))

    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(provide 'init-proper-gutter-mode)

(require 'programming-mode)

(pkg
  scala-mode
  :ensure t
  :defer t
  :config
  (defun scala/prettify ()
    (prettify
     '(("->" . ?→)
       ("def" . ?ƒ)
       ("<-" . ?←)
       ("=>" . ?⇒)
       ("==>" . ?⟹)
       ("<=" . ?≤)
       (">=" . ?≥)
       ("::" . ?∷)
       ("==" . ?≡)
       ("!=" . ?≠)
       ("???" . ?⊥))))
  (add-hook 'scala-mode-hook 'programming-mode)
  (add-hook 'scala-mode-hook 'scala/prettify))

(pkg
  ensime
  :ensure t
  :pin melpa-stable
  :config
  (setq
   ensime-startup-notification nil
   ensime-startup-snapshot-notification nil
   ensime-use-helm t)
  (define-key evil-normal-state-map (kbd "]w") 'ensime-forward-note)
  (define-key evil-normal-state-map (kbd "[w") 'ensime-backward-note)

  ;; Info
  (evil-leader/set-key "p" 'ensime-type-at-point-full-name)
  (evil-leader/set-key "q" 'ensime-show-doc-for-symbol-at-point)
  (evil-leader/set-key "h" 'ensime-show-hierarchy-of-type-at-point)

  ;; Refactor
  (evil-leader/set-key "O" 'ensime-refactor-diff-organize-imports)
  (evil-leader/set-key "l" 'ensime-refactor-diff-extract-local)
  (evil-leader/set-key "m" 'ensime-refactor-diff-extract-method)

  ;; Run
  (evil-leader/set-key "r" 'ensime-db-run)

  (add-to-list 'flycheck-disabled-checkers 'scala)

  (add-hook 'scala-mode-hook 'ensime))
(pkg sbt-mode :ensure t)

(provide 'scala)

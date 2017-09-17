(require 'prettify)

(pkg
  scala-mode
  :ensure t
  :defer t
  :config

  ;; Prettify symbols
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
  (add-hook 'scala-mode-hook 'prettify-symbols-mode)
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
  (add-hook 'scala-mode-hook 'ensime))
(pkg sbt-mode :ensure t)

(provide 'scala)

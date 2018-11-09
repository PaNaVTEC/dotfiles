(require 'init-programming-mode)

(defun haskell/prettify ()
  (prettify
    '(
      ("forall" . ?∀)
      ("exists" . ?∃)

      ("->" . ?→)
      ("<-" . ?←)
      ("=>" . ?⇒)

      ("|->" . ?↦)
      ("<-|" . ?↤)

      ("~>" . ?⇝)
      ("<~" . ?⇜)

      (">->" . ?↣)
      ("<-<" . ?↢)

      ("not" . ?¬)
      ("&&" . ?∧)
      ("||" . ?∨)

      ("==" . ?≡)
      ("/=" . ?≠)
      ("<=" . ?≤)
      (">=" . ?≥)

      ("elem" . ?∈)
      ("notElem" . ?∉)
      ("member" . ?∈)
      ("notMember" . ?∉)
      ("union" . ?∪)
      ("intersection" . ?∩)
      ("isSubsetOf" . ?⊆)
      ("isProperSubsetOf" . ?⊂)

      ("<<" . ?≪)
      (">>" . ?≫)
      ("undefined" . ?⊥)
      ("\\" . ?λ))))

(use-package
  haskell-mode
  :ensure t
  :mode "\\.hs$"
  :defer t
  :config
  (use-package
    intero
    :ensure t
    :config
    (flycheck-add-next-checker 'intero '(warning . haskell-hlint))
    (global-set-key (kbd "C-g") 'intero-goto-definition)
    (global-set-key (kbd "M-n") 'intero-highlight-uses-mode-next)
    (global-set-key (kbd "M-p") 'intero-highlight-uses-mode-prev)
    (global-set-key (kbd "ESC <f7>") 'intero-uses-at))

  (use-package company-ghci :ensure t)

  (custom-set-variables '(haskell-stylish-on-save t))
  (set-compile-for 'haskell-mode-hook "stack test")
  (set-company-backend-for 'haskell-mode-hook 'company-ghci)

  (use-package
    dante
    :ensure t
    :config

    (evil-leader/set-key "7" 'xref-find-references)
    (add-hook 'dante-mode-hook
              '(lambda () (flycheck-add-next-checker
                      'haskell-dante
                      '(warning . haskell-hlint))))
    )

  (add-hook 'haskell-mode-hook 'programming-mode)
  (add-hook 'haskell-mode-hook 'haskell/prettify)
  (add-hook 'haskell-mode-hook 'hs-doc)
  (add-hook 'haskell-mode-hook 'intero-mode))
;;  (add-hook 'haskell-mode-hook 'dante-mode))

(defun hs-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Haskell")))

(location-list-buffer (rx bos "*Intero-Help*"))

(provide 'init-haskell)

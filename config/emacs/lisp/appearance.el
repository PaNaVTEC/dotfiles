(require 'cycle-theme)

(pkg
  powerline
  :ensure t
  :config
  (powerline-center-evil-theme)
  (pkg flycheck-color-mode-line
       :ensure t
       :config
       (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))

(defun location-list-buffer (regex)
  (add-to-list 'display-buffer-alist `(,regex
                                        (display-buffer-reuse-window
                                          display-buffer-in-side-window)
                                        (side            . bottom)
                                        (reusable-frames . visible)
                                        (window-height   . 0.33))))

;; Changes vertical separator to be a proper line
(set-display-table-slot
  standard-display-table
  'vertical-border (make-glyph-code ?│))

;; Personalization
(set-default-font my-font)
(set-face-attribute 'default nil :height my-font-height)

(provide 'appearance)

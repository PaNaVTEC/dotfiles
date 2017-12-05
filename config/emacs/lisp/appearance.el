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

; Buffer dividers
(defun custom-window-divider ()
  (let ((display-table (or buffer-display-table standard-display-table)))
    (set-display-table-slot display-table 5 ?│)
    (set-window-display-table (selected-window) display-table)))

(add-hook 'window-configuration-change-hook 'custom-window-divider)

; Line wrapping
(set-display-table-slot standard-display-table 'truncation (make-glyph-code ?→))
(set-display-table-slot standard-display-table 'wrap (make-glyph-code ?⤸))

;; Personalization
(set-default-font my-font)
(set-face-attribute 'default nil :height my-font-height)

(provide 'appearance)

(require 'init-cycle-theme)

(use-package
  powerline
  :ensure t
  :config
  (powerline-center-evil-theme)
  (use-package flycheck-color-mode-line
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

;; Font size (ui only, in terminal this is provided by urxvt)
(if
  (display-graphic-p)
  (progn
    (global-set-key (kbd "C-+") 'text-scale-increase)
    (global-set-key (kbd "C--") 'text-scale-decrease)))

(set-default-font my-font)

(provide '02-init-appearance)

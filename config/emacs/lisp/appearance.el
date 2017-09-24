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

;; Personalization
(defcustom available-themes '(zenburn spacemacs-light) "Available themes to cycle")
(set-default-font "xos4 Terminus")
(set-face-attribute 'default nil :height 150)
(pkg nord-theme :ensure t)
(pkg spacemacs-theme :ensure t)
(pkg nord-theme :ensure t)

(require 'cycle-theme)

(provide 'appearance)

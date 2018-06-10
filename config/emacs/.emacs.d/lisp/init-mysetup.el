(defcustom my-browser "inox" "Current browser")

(defcustom my-lines-mode 'normal "Type of lines. 'normal or 'relative")
(defcustom my-initial-msg nil "Initial welcome message")

;; Fonts
(defcustom my-font "Terminus" "Emacs font")
(defcustom my-font-height 150 "Emacs font height")

;; Themes
(defcustom available-themes '(nord solarized-light material material-light) "Available themes to cycle")
(use-package solarized-theme :ensure t :defer t)
(use-package material-theme :ensure t :defer t)
(use-package
  nord-theme
  :ensure t
  :config
  ;; nord9
  (set-face-attribute 'font-lock-comment-face nil :foreground "#81A1C1")
  ;; nord13
  (set-face-attribute 'vertical-border nil :foreground "#EBCB8B")

  ;; configure smerge colors
  (add-hook 'smerge-mode-hook
  (lambda ()
    (set-face-background 'smerge-lower "green")
    (set-face-background 'smerge-markers "brightblack")
    (set-face-background 'smerge-upper "red"))))

(provide 'init-mysetup)

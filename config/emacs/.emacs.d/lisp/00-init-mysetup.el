(defcustom my-browser "xdg-open"
  "Current browser"
  :type 'string
  :group 'mysetup)

(defcustom my-lines-mode 'normal
  "Type of lines. 'normal or 'relative"
  :group 'mysetup)

(defcustom my-initial-msg nil
  "Initial welcome message"
  :type 'string
  :group 'mysetup)

;; Fonts
(defcustom my-font "Pragmata Pro Mono-14"
  "Emacs font"
  :type 'string
  :group 'mysetup)

;; Themes
(defcustom available-themes '(nord solarized-light material material-light)
  "Available themes to cycle"
  :type 'list
  :group 'mysetup)

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
    (set-face-background 'smerge-lower "#A3BE8C")
    (set-face-background 'smerge-markers "#4C566A")
    (set-face-background 'smerge-upper "#BF616A"))))

(provide '00-init-mysetup)

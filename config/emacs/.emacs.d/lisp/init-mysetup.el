(defcustom my-browser "inox"
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
(defcustom my-font "Terminus"
  "Emacs font"
  :type 'string
  :group 'mysetup)

(defcustom my-font-height 150
  "Emacs font height"
  :type 'integer
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
    (set-face-background 'smerge-lower "green")
    (set-face-background 'smerge-markers "brightblack")
    (set-face-background 'smerge-upper "red"))))

(provide 'init-mysetup)

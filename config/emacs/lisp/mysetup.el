;; Fonts
(defcustom my-font "xos4 Terminus" "Emacs font")
(defcustom my-font-height 150 "Emacs font height")

;; Themes
(defcustom available-themes '(nord spacemacs-light) "Available themes to cycle")
(pkg spacemacs-theme :ensure t)
(pkg nord-theme :ensure t :config
  ;; nord9
  (set-face-attribute 'font-lock-comment-face nil :foreground "#81A1C1")
  ;; nord13
  (set-face-attribute 'vertical-border nil :foreground "#EBCB8B"))

(provide 'mysetup)

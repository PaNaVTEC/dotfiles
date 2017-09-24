;; Fonts
(defcustom my-font "xos4 Terminus" "Emacs font")
(defcustom my-font-height 150 "Emacs font height")

;; Themes
(defcustom available-themes '(nord spacemacs-light) "Available themes to cycle")
(pkg zenburn-theme :ensure t)
(pkg spacemacs-theme :ensure t)
(pkg nord-theme :ensure t)

(provide 'mysetup)

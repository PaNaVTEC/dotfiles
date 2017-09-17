;; Bootstrap `use-package'
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(unless
  (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Functions
(defalias 'pkg 'use-package)

;; Config
(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; No scrollbars
(set-fringe-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Initial mode in text avoids lag
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message nil)

;; prefer utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(tool-bar-mode -1)
(savehist-mode 1)

;; Appearance
(pkg
  powerline
  :ensure t
  :config
  (powerline-center-evil-theme)

  (pkg flycheck-color-mode-line
       :ensure t
       :config
       (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))

(pkg
  color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-eighties t))

(set-default-font "xos4 Terminus")
(set-face-attribute 'default nil :height 150)

;; Evil mode
(pkg
  evil
  :ensure t
  :config
  (evil-mode 1)

  (pkg
    evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ",")
    (evil-leader/set-key "e" 'find-file))

  (pkg
    evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (pkg evil-indent-textobject :ensure t)

  ;; Visual line navigation
  (define-key evil-normal-state-map (kbd "gj") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "g <down>") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "gk") 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "g <up>") 'evil-previous-visual-line)

  ;; Buffer navigation
  (define-key evil-normal-state-map (kbd "C-w <up>") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-w <down>") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-w <left>") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-w <right>") 'evil-window-right)

  ;; Typo avoider
  (evil-ex-define-cmd "WQ" 'evil-save-and-quit)
  (evil-ex-define-cmd "Wq" 'evil-save-and-quit)
  (evil-ex-define-cmd "W" 'evil-write)
  (evil-ex-define-cmd "Wa" 'evil-write-all)
  (evil-ex-define-cmd "Q" 'evil-quit)
  (evil-ex-define-cmd "Qa" 'evil-quit-all))

(defun insert-cursor () (send-string-to-terminal "\e[6 q"))
(defun box-cursor () (send-string-to-terminal "\e[2 q"))
(unless (and (null (getenv "TMUX")) (display-graphic-p))
  (add-hook 'evil-insert-state-entry-hook 'insert-cursor)
  (add-hook 'evil-insert-state-exit-hook 'box-cursor)
  (add-hook 'kill-emacs-hook 'box-cursor)
  (add-hook 'evil-normal-state-entry-hook 'box-cursor)
  (add-hook 'evil-motion-state-entry-hook 'box-cursor))

(pkg company
     :ensure t
     :diminish company-mode
     :config
     (add-hook 'js2-mode-hook 'company-mode))

;; Haskell mode
(pkg
  haskell-mode
  :ensure t
  :config
  (pkg company-ghci :defer t))

(pkg
  intero
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

;; Javascript
(pkg js2-mode
     :ensure t
     :mode "\\.js\\'"
     :interpreter "node"
     :config
     (setq js-indent-level 2)
     (setq evil-shift-width 2)
     (setq js2-basic-offset 2)
     (setq js2-strict-missing-semi-warning nil)
     ;(setq js2-mode-show-strict-warnings nil)
     ;(setq js2-mode-show-parse-errors nil)
     (add-hook 'flycheck-mode-hook
               (lambda () (flycheck-add-mode 'javascript-standard 'js2-mode))))

(pkg rjsx-mode :ensure t :mode "\\.jsx$" :mode "components/.+\\.js$")
(pkg tern :defer t :init (add-hook 'js2-mode-hook 'tern-mode))
(pkg js2-refactor :ensure t)
(pkg json-mode
     :ensure t
     :mode "\\.json\\'")
(pkg company-tern
     :ensure t
     :defer t
     :init
     (add-hook 'js2-mode-hook
               (lambda () (add-to-list 'company-backends 'company-tern))))

;; Scala
(global-prettify-symbols-mode)
(setq prettify-symbols-unprettify-at-point 'right-edge)
(pkg
  scala-mode
  :ensure t
  :pin melpa-stable
  :defer t
  :config

  ;; Prettify symbols
  (add-hook 'scala-mode-hook
            (lambda ()
              (push '("->" . ?→) prettify-symbols-alist)
              (push '("def" . ?ƒ) prettify-symbols-alist)
              (push '("<-" . ?←) prettify-symbols-alist)
              (push '("=>" . ?⇒) prettify-symbols-alist)
              (push '("==>" . ?⟹) prettify-symbols-alist)
              (push '("<=" . ?≤) prettify-symbols-alist)
              (push '(">=" . ?≥) prettify-symbols-alist)
              (push '("::" . ?∷) prettify-symbols-alist)
              (push '("==" . ?≡) prettify-symbols-alist)
              (push '("!=" . ?≠) prettify-symbols-alist)
              (push '("???" . ?⊥) prettify-symbols-alist)))

  ;; Ensime
  (pkg
    ensime
    :ensure t
    :init (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
    :config (setq
              ensime-startup-notification nil
              ensime-startup-snapshot-notification nil
              ensime-use-helm t))

  ;; Sbt
  (pkg sbt-mode :ensure t))

(pkg markdown-mode :ensure t)
(pkg yaml-mode :ensure t)

;; Syntax check
(pkg
  flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  (define-key evil-normal-state-map (kbd "]w") 'flycheck-next-error)
  (define-key evil-normal-state-map (kbd "[w") 'flycheck-previous-error))

;; Zeal setup
(pkg zeal-at-point :ensure t)

(add-to-list 'zeal-at-point-mode-alist '(haskell-mode . "haskell"))
(global-set-key "\C-cd" 'zeal-at-point)
(add-to-list 'exec-path "/usr/bin/zeal")

;; Neotree
(pkg
  neotree
  :ensure t
  :init
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (global-set-key (kbd "C-n") 'neotree-toggle)
  (define-key evil-normal-state-map (kbd "C-n") 'neotree-toggle))

;; Rest client
(pkg restclient :ensure t)

;; Emacs line number
(pkg
  linum-relative
  :diminish linum-relative-mode
  :ensure t
  :config
  (linum-relative-global-mode)
  (setq
    linum-relative-current-symbol ""
    linum-relative-format "%3s ")) ;; Add \u2502 for more separation

(pkg smooth-scrolling
     :ensure t
     :init
     (setq scroll-margin 5
           scroll-conservatively 9999
           scroll-step 1))

;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(pkg helm
     :ensure t
     :init (pkg helm-projectile :ensure t)
     :config
     (require 'helm-config)
     (require 'helm-misc)
     (require 'helm-projectile)
     (require 'helm-locate)
     (helm-mode 1)
     (define-key evil-normal-state-map " " 'helm-mini)
     (setq helm-quick-update t)
     (setq helm-bookmark-show-location t)
     (setq helm-buffers-fuzzy-matching t)

     ;; Override default command launcher
     (global-set-key (kbd "M-x") 'helm-M-x))

(pkg
  helm-projectile
  :ensure t
  :config
  (global-set-key (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file))

;; Emacs global
(global-set-key (kbd "C-l") 'evil-search-highlight-persist-remove-all)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "inox")

(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-projectile helm smooth-scrolling restclient zeal-at-point ensime scala-mode company-mode neotree yaml-mode markdown-mode intero haskell-mode evil-indent-textobject evil-surround evil-leader evil use-package powerline leuven-theme flycheck-color-mode-line))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
(set-face-attribute 'default nil :height 130)

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
    (evil-leader/set-key "e" 'find-file)
    )

  (pkg
    evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (pkg evil-indent-textobject :ensure t)

  ;; Visual line navigation
  (define-key evil-normal-state-map (kbd "gj") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "gk") 'evil-previous-visual-line))

(pkg company :ensure t)

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
(pkg js2-mode :ensure t)
(pkg js2-refactor :ensure t)

;; Scala
(defun customize/scala-mode ()
  "Enables scala customization as a hook"
  ((defconst
     scala--prettify-symbols-alist
     '(("->" . ?→)
       ("<-" . ?←)
       ("=>" . ?⇒)
       ("==>" . ?⟹)
       ("<=" . ?≤)
       (">=" . ?≥)
       ("==" . ?≡)
       ("!=" . ?≠)
       ("???" . ?⊥)))

   (set (make-local-variable 'prettify-symbols-alist)
        scala--prettify-symbols-alist)
   (prettify-symbols-mode)))

(pkg
  scala-mode
  :ensure t
  :pin melpa-stable
  :init
  (progn
    (dolist (ext '(".cfe" ".cfs" ".si" ".gen" ".lock"))
      (add-to-list 'completion-ignored-extensions ext)))
  (add-hook 'scala-mode-hook 'customize/scala-mode)
  :config

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
(global-linum-mode t)

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

     ;; Ctrlp like
     (global-set-key (kbd "C-p") 'projectile--find-file)
     (define-key evil-normal-state-map (kbd "C-p") 'projectile--find-file)

     ;; Override default command launcher
     (global-set-key (kbd "M-x") 'helm-M-x))

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

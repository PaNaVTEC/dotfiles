;; Bootstrap `use-package'

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list
  'package-archives
  '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless
  (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Config
(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(tool-bar-mode -1)
(savehist-mode 1)

;; Appearance

(use-package
  powerline
  :ensure t
  :config
  (powerline-center-evil-theme)

  (use-package flycheck-color-mode-line
               :ensure t
               :config
               (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))

(use-package leuven-theme :ensure t)

;; Evil mode

(use-package
  evil
  :ensure t
  :config
  (evil-mode 1)

  (use-package
    evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ",")
    (evil-leader/set-key "e" 'find-file)
    )

  (use-package
    evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject :ensure t)

  ;; Visual line navigation
  (define-key evil-normal-state-map (kbd "gj") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "gk") 'evil-previous-visual-line))

(use-package company-mode :ensure t)

;; Haskell mode
(use-package haskell-mode
             :ensure t
             :config
             (use-package company-ghci :defer t))

(use-package intero
             :ensure t
             :config
             (add-hook 'haskell-mode-hook 'intero-mode))

(use-package markdown-mode :ensure t)
(use-package yaml-mode :ensure t)

;; Syntax check
(use-package
  flycheck
  :ensure t
  :config
  (global-flycheck-mode))

;; Zeal setup
(use-package zeal-at-point :ensure t)

(add-to-list 'zeal-at-point-mode-alist '(haskell-mode . "haskell"))
(global-set-key "\C-cd" 'zeal-at-point)
(add-to-list 'exec-path "/usr/bin/zeal")

;; Neotree
(use-package
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
(use-package restclient :ensure t)

;; Emacs line number
(global-linum-mode t)

(use-package smooth-scrolling
             :ensure t
             :init
             (setq scroll-margin 5
                   scroll-conservatively 9999
                   scroll-step 1))

;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(use-package helm 
             :ensure t
             :init (use-package helm-projectile :ensure t)
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
    (neotree yaml-mode markdown-mode intero haskell-mode evil-indent-textobject evil-surround evil-leader evil use-package powerline leuven-theme flycheck-color-mode-line))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setq inhibit-startup-screen t)

(use-package emacs
	:init
		(set-face-attribute 'default nil 
			:font "PragmataPro Liga" 
			:height 120
		)
)

;; Font settings
(add-to-list 'load-path "~/Documents/config-files/emacs/pragmatapro-full.el")
(load "~/Documents/config-files/emacs/pragmatapro-full.el")
(global-prettify-symbols-mode 1)
(add-hook 'prog-mode-hook #'prettify-hook)
(add-hook 'text-mode-hook #'prettify-hook)

(require 'package)
(add-to-list 'package-archives
                          '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Evil Mode
(unless (package-installed-p 'evil)
    (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Theme
(unless (package-installed-p 'kanagawa-themes)
  (package-install 'kanagawa-themes))
(use-package kanagawa-themes
    :ensure t
    :config
    (load-theme 'kanagawa-wave t))
(custom-set-variables
 '(package-selected-packages nil))
(custom-set-faces
 )

(setq make-backup-files nil)
(global-display-line-numbers-mode 1)


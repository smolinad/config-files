(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode 1)
(setq make-backup-files nil)

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
    (load-theme 'kanagawa-dragon t))
(custom-set-variables
 '(package-selected-packages nil))
(custom-set-faces
 )

;; Remap
;; --- Custom Evil keybindings ---
(with-eval-after-load 'evil

  ;; --- Leader key actions ---
  (evil-define-key 'normal 'global (kbd "SPC x") #'dired)

  ;; --- Move selected lines up/down ---
  (defun my/move-region (start end n)
    "Move the selected region up or down by N lines."
    (let ((text (delete-and-extract-region start end)))
      (forward-line n)
      (let ((new-start (point)))
        (insert text)
        (set-mark new-start)
        (goto-char (+ new-start (length text)))
        (setq deactivate-mark nil))))

  (defun my/move-region-up (start end)
    (interactive "r")
    (my/move-region start end -1))

  (defun my/move-region-down (start end)
    (interactive "r")
    (my/move-region start end 1))

  (evil-define-key 'visual 'global
    (kbd "J") #'my/move-region-down
    (kbd "K") #'my/move-region-up)

  ;; --- Scroll and recenter ---
  (evil-define-key 'normal 'global
    (kbd "C-d") (lambda () (interactive) (evil-scroll-down nil) (recenter))
    (kbd "C-u") (lambda () (interactive) (evil-scroll-up nil) (recenter)))

  ;; --- Search next/prev and center ---
  (evil-define-key 'normal 'global
    (kbd "n") (lambda () (interactive) (evil-search-next) (recenter))
    (kbd "N") (lambda () (interactive) (evil-search-previous) (recenter)))

  ;; --- Paste without overwriting register ---
  (evil-define-key 'visual 'global (kbd "SPC p")
    (lambda ()
      (interactive)
      (let ((text (buffer-substring (region-beginning) (region-end))))
        (delete-region (region-beginning) (region-end))
        (evil-paste-after 1)
        (insert text))))

  ;; --- Yank to system clipboard ---
  (evil-define-key 'normal 'global (kbd "SPC y") "\"+y")
  (evil-define-key 'normal 'global (kbd "SPC Y") "\"+Y")
  (evil-define-key 'visual 'global (kbd "SPC y") "\"+y")

  ;; --- Open tmux sessionizer ---
  (evil-define-key 'normal 'global
    (kbd "C-f") (lambda () (interactive)
                  (shell-command "tmux new tmux-sessionizer")))

  ;; --- Escape from insert mode using C-c ---
  (define-key evil-insert-state-map (kbd "C-c") #'evil-normal-state)

  ;; --- Disable arrow keys ---
  (dolist (key '("<up>" "<down>" "<left>" "<right>"))
    (global-set-key (kbd key) #'ignore))

  ;; --- Disable mouse input (optional) ---
  (dolist (ev '(mouse-1 mouse-2 mouse-3 mouse-4 mouse-5
                 wheel-up wheel-down wheel-left wheel-right))
    (global-unset-key (vector ev))))


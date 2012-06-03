(setq
 load-path (cons (expand-file-name "~/.emacs.d") load-path)
 load-path (cons (expand-file-name "~/.emacs.d/themes/") load-path)
 load-path (cons (expand-file-name "~/.emacs.d/interface") load-path)
 load-path (cons (expand-file-name "~/.emacs.d/auto-complete") load-path)
 load-path (cons (expand-file-name "~/.emacs.d/auto-complete-clang") load-path)
 inhibit-startup-message t
 next-line-add-newlines nil
 require-final-newline t
 delete-old-versions t
 delete-auto-save-files t
 make-backup-files nil
 scroll-step 1
 scroll-preserve-screen-position t
 mouse-yank-at-point t
 search-highlight t
 compilation-scroll-output t
 apropos-do-all nil
 auto-save-interval 512
 auto-save-list-file-prefix "~/.backups/save-"
 indent-line-function 'indent-relative-maybe
 default-frame-alist (cons '(cursor-type . bar) (copy-alist default-frame-alist))
 c-default-style "gnu"
 tab-width 2
 c-basic-offset 2
 default-tab-width 2
 indent-tabs-mode nil
 )

(fset 'yes-or-no-p (symbol-function 'y-or-n-p))
(set-scroll-bar-mode 'right)
																				;(set-default-font "Inconsolata-12")
;; sudo apt-get install fonts-inconsolata
(set-face-attribute 'default nil :family "Inconsolata" :height 130)

(tool-bar-mode nil)
(column-number-mode t)
(line-number-mode t)
(show-paren-mode t)

(global-set-key [home]        'beginning-of-line)
(global-set-key [end]         'end-of-line)
(global-set-key [(control z)] 'undo)
(global-set-key "\C-l"        'goto-line)
(global-set-key [f2]          'save-buffer)
(global-set-key [f3]          'remove-split)
(global-set-key [f4]          'split-window-horizontally)
(global-set-key [f5]          'indent-buffer)
(global-set-key [f7]          'compile)
(global-set-key "\C-f"        'highlight-phrase)
(global-set-key [C-delete]    'my-kill-buffer)

(defun indent-buffer ()
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
	)

(defun my-kill-buffer ()
	(interactive)
	(kill-buffer (buffer-name))
	(set-name))

(add-hook 'c-mode-common-hook (lambda() (local-set-key (kbd "C-o ") 'ff-find-other-file)))

(add-hook 'c++-mode-hook
          '(lambda ()
						 (interactive) (column-marker-2 80)))

;; http://www.emacswiki.org/emacs/linum+.el
(when (require 'linum nil 'noerror)
  (progn
    (linum-mode t)
    (global-set-key [f9] 'linum-mode)))

;; http://www.emacswiki.org/emacs/CuaMode
(when (require 'cua-base nil 'noerror)
  (progn
    (cua-mode t)
    (global-set-key "\C-c" 'cua-copy-region)
    (global-set-key "\C-v" 'cua-paste)))

;; http://www.emacswiki.org/emacs/download/zenburn.el
(require 'color-theme-zenburn)
(color-theme-zenburn)


(when (require 'zenburn nil 'noerror)
  (color-theme-zenburn))

;; http://code.google.com/p/autopair/
(when (require 'autopair nil 'noerror)
  (autopair-global-mode))

;; used to show tabs and spaces
(require 'whitespace)

(require 'smarttabs)
(smart-tabs-advice js2-indent-line js2-basic-offset)

;; column marker
(when (require 'column-marker)
  (progn
    (column-marker-2 80)))


(setq
 load-path (cons (expand-file-name "~/.emacs.d") load-path)
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
(global-set-key [f11]          'cscope-find-global-definition)
;(global-set-key [f11]          'cscope-find-this-symbol)
(global-set-key [f12]          'cscope-find-this-file)
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

;; Toggles source/header file
;; modified to nicbr
(setq-default cc-other-file-alist 
							'(
								("\\.cpp$"  (".H"))
								("\\.H$"   (".cpp"))
								))
(setq ff-search-directories 
      '("."
        "~/projects/SEL/*"
        "~/projects/SEL/include/*"
        "~/projects/registro.br/src/*"
        "~/projects/registro.br/src/lib/*"
				"~/projects/registro.br/include/*"
				))

(add-hook 'c-mode-common-hook (lambda() (local-set-key (kbd "C-o ") 'ff-find-other-file)))

(add-hook 'c++-mode-hook
          '(lambda ()
						 (interactive) (column-marker-2 80)))

;; CScope
;; find /home/mauro/projects/ -name "*.cpp" -o -name "*.H" > ~/projects/cscope_db/cscope.files
;; cscope -b -q -k
(when (require 'xcscope nil 'noerror)
	(cscope-set-initial-directory "~/projects/cscope_db")
	(setq cscope-do-not-update-database t))

; JavaScript mode
;; https://github.com/mooz/js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; http://stud4.tuwien.ac.at/~e0225855/linum/linum.html
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

;; http://emacs-fu.blogspot.com/2010/04/zenburn-color-theme.html
;; http://www.emacswiki.org/emacs/download/zenburn.el
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

;; http://code.google.com/p/yasnippet/
(add-to-list 'load-path
						 "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets/")


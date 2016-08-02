;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yph's settings

(setq inhibit-startup-message t)
(tool-bar-mode 0)
(menu-bar-mode 0)

(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\M-g"     'goto-line)
(global-set-key "\M-r"     'replace-string)

;; Modes
(setq-default major-mode 'text-mode)

;; [Home] & [End] key should take you to beginning and end of lines..
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq make-backup-files nil)
(setq-default c-basic-offset 4)
(setq-default js-indent-level 4)
(setq-default indent-tabs-mode nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Color theme & font
(set-frame-parameter nil 'background-mode 'dark)
(add-to-list 'custom-theme-load-path "~/config/solarized.emacs/")
(if (display-graphic-p) (load-theme 'solarized t))
(set-default-font "Roboto Mono-14")

;; Turn on highlighting for long lines (default = big, in practice only will show up for specific modes as below)
(require 'whitespace)
(setq whitespace-line-column 500)
(setq whitespace-style '(face lines-tail trailing tabs))
(global-whitespace-mode 1)

;; Add mode-specific line lengths
(add-hook 'text-mode-hook (lambda () (setq-local whitespace-line-column 80)))
(add-hook 'c++-mode-hook (lambda () (setq-local whitespace-line-column 80)))

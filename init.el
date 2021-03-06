; default load path for el files

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;
;; Distro packages: silversearcher-ag mu4e
;; (debug-on-entry 'display-warning)

;; custom file location

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq custom-file "~/.emacs.d/lisp/my-custom-theme.el")
(load custom-file)

(setq load-prefer-newer t)
(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/lisp")
;; evil-mode - Thanks for all the fish, Vim!
(require 'evil)
(evil-mode 1)

(require 'my-packages)
(require 'my-helm)
(require 'my-latex)
(require 'my-org)
; (require 'my-mail)
(require 'my-git)
(require 'my-text)
(require 'my-prog)
(require 'my-irc)
(require 'my-gdb)
(require 'my-log)
;(require 'my-vg)

(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

;; create backups
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(byte-recompile-directory (expand-file-name "~/.emacs.d/lisp/") 0)

;; start emacs server
(server-start)

;; open log file
(setq inhibit-startup-screen t)

;; Add final message so using C-h l I can see if .emacs failed
(message ".emacs loaded successfully.")

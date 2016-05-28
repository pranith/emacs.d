;; default load path for el files

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; custom file location
(setq custom-file "~/.emacs.d/my-custom-theme.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'my-packages)
(require 'my-helm)
(require 'my-latex)
(require 'my-org)
(require 'my-mail)
(require 'my-git)
(require 'my-text)
(require 'my-prog)

;; create backups
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;; start emacs server
;; (server-start)

;; Add final message so using C-h l I can see if .emacs failed
(message ".emacs loaded successfully.")

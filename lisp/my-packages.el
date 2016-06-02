(require 'package)
  (push '("marmalade" . "http://marmalade-repo.org/packages/")
        package-archives )
  (push '("melpa" . "http://melpa.org/packages/")
        package-archives)
(package-initialize)

(require 'color-theme-sanityinc-solarized)
(require 'yasnippet)
(yas-global-mode 1)

;; sr-speedbar for source tree traversal
;; (require 'sr-speedbar)

;; save last line
(setq save-place-file "~/.emacs.d/saved-places")
(require 'saveplace)
(setq-default save-place-mode t)

(provide 'my-packages)

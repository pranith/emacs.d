(require 'package)
(setq package-enable-at-startup nil)
  (push '("marmalade" . "http://marmalade-repo.org/packages/")
        package-archives )
  (push '("melpa" . "http://melpa.org/packages/")
        package-archives)
  (push '("melpa-stable" . "http://stable.melpa.org/packages/")
        package-archives)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(require 'color-theme-sanityinc-solarized)
(require 'yasnippet)
(yas-global-mode 1)

;; sr-speedbar for source tree traversal
;; (require 'sr-speedbar)

;; save last line
(require 'saveplace)
(if (fboundp #'save-place-mode)
   (save-place-mode +1)
     (setq-default save-place t))

(use-package ensime
 :ensure t
 :pin melpa-stable)

(provide 'my-packages)

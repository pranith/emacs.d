;; Setup text mode
;; (require 'ispell)
;; (require 'hunspell)
;; (require 'aspell)
;; (require 'rw-hunspell)
;; (require 'helm-flyspell)

(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")
(setq flyspell-mode t)

(add-hook 'text-mode-hook '(lambda() (auto-fill-mode 1)))
(add-hook 'text-mode-hook '(lambda() (setq fill-column 72)))

(setq auto-save-timeout 2000)

(autoload 'markdown-mode "markdown-mode"
    "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

(provide 'my-text)

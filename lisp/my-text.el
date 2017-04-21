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
(add-hook 'text-mode-hook '(lambda() (setq fill-column 80)))

(setq auto-save-timeout 2000)

(autoload 'markdown-mode "markdown-mode"
    "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
(setq writegood-mode t)

(global-set-key "\C-cg" 'writegood-mode)
(global-set-key "\C-c\C-gg" 'writegood-grade-level)
(global-set-key "\C-c\C-ge" 'writegood-reading-ease)

(require 'langtool)
(setq langtool-language-tool-jar "/home/pranith/langtool/languagetool-commandline.jar")

(global-set-key "\C-x4w" 'langtool-check-buffer)
(global-set-key "\C-x4W" 'langtool-check-done)
(global-set-key "\C-x4n" 'langtool-goto-next-error)
(global-set-key "\C-x4p" 'langtool-goto-previous-error)
(global-set-key "\C-x44" 'langtool-show-message-at-point)
(provide 'my-text)

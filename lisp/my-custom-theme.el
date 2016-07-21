;; Setup text mode
(add-hook 'text-mode-hook '(lambda() (auto-fill-mode 1)))
(add-hook 'text-mode-hook '(lambda() (setq fill-column 78)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes
   (quote
    ("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(package-selected-packages
   (quote
    (flycheck-rust cargo rust-mode markdown-mode+ writegood-mode helm-ag auto-compile sr-speedbar helm-circe circe nlinum company-c-headers wc-mode helm-gtags ggtags company-irony-c-headers company-irony flycheck-irony flycheck markdown-mode yasnippet evil-magit magit use-package helm-mu flymake auctex helm evil color-theme-sanityinc-solarized)))
 '(safe-local-variable-values
   (quote
    ((c-tab-always-indent)
     (c-hanging-braces-alist
      (brace-list-open)
      (brace-list-close)
      (block-close . c-snug-do-while)
      (substatement-open before after))
     (c-tab-always-indent . t)
     (c-default-style "linux")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "unknown" :slant normal :weight normal :height 113 :width normal)))))

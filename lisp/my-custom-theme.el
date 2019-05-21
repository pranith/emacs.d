;; Setup text mode
(add-hook 'text-mode-hook '(lambda() (auto-fill-mode 1)))
(add-hook 'text-mode-hook '(lambda() (setq fill-column 78)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"))
 '(c-basic-offset 4)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(fci-rule-color "#073642")
 '(indent-tabs-mode t)
 '(org-agenda-files (quote ("~/logs/diary.org")))
 '(package-selected-packages
   (quote
    (ac-clang auto-complete-clang flycheck-vale highlight-indent-guides evil-smartparens smartparens ensime scala-mode flycheck-checkpatch dracula-theme langtool color-theme-sanityinc-tomorrow openwith flycheck-rust cargo rust-mode markdown-mode+ writegood-mode helm-ag auto-compile sr-speedbar helm-circe circe nlinum company-c-headers wc-mode helm-gtags ggtags company-irony-c-headers company-irony flycheck-irony flycheck markdown-mode yasnippet evil-magit magit use-package helm-mu flymake auctex helm evil color-theme-sanityinc-solarized)))
 '(safe-local-variable-values
   (quote
    ((company-clang-arguments "-I/home/pdenthumdas/perfsim/perfsimFiles/" "-I/home/pdenthumdas/perfsim/ucodeFiles/" "-I/home/pdenthumdas/perfsim/traceParserFiles" "-I/home/pdenthumdas/perfsim/analyzerFiles" "-I/home/pdenthumdas/perfsim/infraFiles" "-I/home/pdenthumdas/perfsim/uarchlibFiles/")
     (flycheck-clang-language-standard . c++11)
     (flycheck-gcc-language-standard . c++11)
     (c-tab-always-indent)
     (c-hanging-braces-alist
      (brace-list-open)
      (brace-list-close)
      (block-close . c-snug-do-while)
      (substatement-open before after))
     (c-tab-always-indent . t)
     (c-default-style "linux"))))
 '(tramp-syntax (quote (quote nil) default) nil (tramp))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil)
 '(verilog-auto-lineup (quote ignore)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "APPL" :slant normal :weight normal :height 113 :width normal)))))

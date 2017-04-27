(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/devops/Dropbox/work/log.org"))

(setq org-latex-to-pdf-process '("texi2dvi --pdf --clean --verbose --batch %f"))
(setq org-export-latex-hyperref-format "\\ref{%s}")

(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))))

(define-key global-map "\C-cd" (lambda () (interactive) (switch-to-buffer "diary.md")))

(provide 'my-org)

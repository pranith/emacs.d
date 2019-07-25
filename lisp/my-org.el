(require 'org)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-latex-to-pdf-process '("texi2dvi --pdf --clean --verbose --batch %f"))
(setq org-export-latex-hyperref-format "\\ref{%s}")

(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa

(setq org-tag-alist '(("important" . ?i)
		      ("urgent"    . ?u)))

; Add tags to TODOs using C-c C-c
; Search for tags using C-C a
(setq org-agenda-custom-commands
   '(("1" "Q1" tags-todo "+important+urgent")
     ("2" "Q2" tags-todo "+important-urgent")
     ("3" "Q3" tags-todo "-important+urgent")
     ("4" "Q4" tags-todo "-important-urgent")))

(provide 'my-org)

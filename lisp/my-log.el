; log file
(find-file "/home/pranith/devops/Dropbox/research/work/diary.org")
(define-key global-map "\C-cd" (lambda () (interactive) (switch-to-buffer "diary.org")))

(provide 'my-log)

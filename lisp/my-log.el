; log file
(defvar my-log-diary_file)
(setq my-log-diary_file "/home/pranith/devops/Dropbox/research/work/diary.org")
(find-file my-log-diary_file)
(define-key global-map "\C-cd" (lambda () (interactive) (switch-to-buffer (find-file-noselect my-log-diary_file))))

(provide 'my-log)

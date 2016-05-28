;; magit settings
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(setq evil-magit-state 'motion)
(require 'evil-magit)

(provide 'my-git)

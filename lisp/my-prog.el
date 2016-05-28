(require 'cc-mode)
(require 'irony)
(require 'company)
(require 'semantic)
(require 'nlinum)

(setq irony-mode 1)

(add-to-list 'company-backends 'company-c-headers)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(setq company-backends (delete 'company-semantic company-backends))
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

(defun my-irony-mode-hook ()
   (define-key irony-mode-map [remap completion-at-point]
        'irony-completion-at-point-async)
     (define-key irony-mode-map [remap complete-symbol]
          'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

(global-linum-mode t)
(column-number-mode t)
;; add line numbers
;;(add-hook 'prog-mode-hook 'linum-mode)
;;(defun linum-format-func (line)
;;  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
;;     (propertize (format (format "%%%dd " w) line) 'face 'linum)))
;;(setq linum-format 'linum-format-func)

(provide 'my-prog)

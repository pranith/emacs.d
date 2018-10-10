(require 'cc-mode)
(require 'irony)
(require 'company)
(require 'semantic)
(require 'nlinum)
(require 'sr-speedbar)
(require 'highlight-indent-guides)
;; (require 'flycheck)
(require 'ensime)
(require 'evil-smartparens)
(require 'smartparens)

(require 'smartparens-config)

(smartparens-global-mode t)
(add-hook 'prog-mode-hook #'evil-smartparens-mode)
(add-hook
 'smartparens-enabled-hook #'evil-smartparens-mode)

(global-flycheck-mode)

(setq irony-mode 1)
(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
(setq smartparens-global-mode 1)

(add-to-list 'company-backends 'company-c-headers)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)

(add-hook 'c-mode-hook 'highlight-indent-guides-mode)
(add-hook 'c++-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)

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

(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

;; (add-hook 'c++-mode-hook 'flycheck-mode)
;; (add-hook 'c-mode-hook 'flycheck-mode)
;; (eval-after-load 'flycheck
;;  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
;; (eval-after-load 'flycheck
;;    '(add-to-list 'flycheck-checkers 'irony))

;; ==========================================
;; (optional) bind TAB for indent-or-complete
;; ==========================================
(defun irony--check-parens ()
(save-excursion
  (if (memq (char-after) '(?\) ?\} ?\])) t nil)))
(defun irony--check-expansion ()
(save-excursion
  ;(if (looking-at "\\_>") (message "\\_>")
  ;  (backward-char 1)
    (if (looking-at "\\.") t
      (backward-char 1)
      (if (looking-at "->") t nil))))
(defun irony--indent-or-complete ()
"Indent or Complete"
(interactive)
(cond ((and (not (use-region-p))
            (irony--check-expansion))
       (message "complete")
       (company-complete-common))
      ((irony--check-parens)
       (message "End-parens")
       (forward-char 1))
      (t
       (message "indent")
       (call-interactively 'c-indent-line-or-region))))
(defun irony--enter-and-indent ()
(interactive)
(cond ((irony--check-parens)
      (message "enter on paren")
      (insert "\n\n")
      (call-interactively 'c-indent-line-or-region)
      (beginning-of-line)
      (backward-char 1)
      (call-interactively 'c-indent-line-or-region))
      (t (call-interactively 'newline-and-indent))))
(defun irony-mode-keys ()
"Modify keymaps used by `irony-mode'."
(local-set-key (kbd "TAB") 'irony--indent-or-complete)
(local-set-key [tab] 'irony--indent-or-complete)
(local-set-key [C-return] 'irony--enter-and-indent)
(local-set-key [return] 'irony--enter-and-indent)
(local-set-key (kbd "RET") 'irony--enter-and-indent))
(add-hook 'c-mode-common-hook 'irony-mode-keys)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

(global-linum-mode t)
(column-number-mode t)

(setq sr-speedbar-right-side nil)
(setq sr-speedbar-skip-other-window-p t)
(setq sr-speedbar-auto-refresh t)
;; (setq sr-speedbar-max-width-x 20)
;; (setq sr-speedbar-width 20)

;; regular speedbar config
(setq speedbar-show-unknown-files t)
(setq speedbar-verbosity-level 0)

(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

;; make evil mode treat underscore as part of one word
(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol))

(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
 '(add-hook 'flycheck-mode-hook #'flycheck-checkpatch-setup))

(defun compile-make ()
  "Compile the project"
  (interactive)
  (compile "make -j8\""))

(setq compilation-scroll-output 'first-error)
(global-set-key [f4] 'compile-make)

(provide 'my-prog)

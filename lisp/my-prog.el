(require 'cc-mode)
(require 'irony)
(require 'company)
(require 'sr-speedbar)
;; (require 'highlight-indent-guides)
;; (require 'flycheck)
;; (require 'ensime)
(require 'evil-smartparens)
(require 'smartparens)
(require 'lsp-mode)
(require 'lsp-ui)
(require 'dtrt-indent)

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

;; (add-hook 'c-mode-hook 'highlight-indent-guides-mode)
;; (add-hook 'c++-mode-hook 'highlight-indent-guides-mode)
;; (setq highlight-indent-guides-method 'character)

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
      (insert "\n")
      (call-interactively 'c-indent-line-or-region)
      (beginning-of-line)
      ;; (backward-char 1)
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

(defun evil-mode-quit ()
  "Quit and indent"
  (interactive)
  (if (and evil-mode
       (eq evil-state 'insert)
       (c-indent-line-or-region)
       ))
  (evil-force-normal-state))

(local-set-key (kbd "ESC") 'evil-mode-quit)

(global-display-line-numbers-mode t)
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
;(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

;; make evil mode treat underscore as part of one word
(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol))

(add-hook 'after-init-hook #'global-flycheck-mode)

;(eval-after-load 'flycheck
; '(add-hook 'flycheck-mode-hook #'flycheck-checkpatch-setup))

(defun compile-make ()
  "Compile the project"
  (interactive)
  (compile "make -j8\""))

(setq compilation-scroll-output 'first-error)
(global-set-key [f4] 'compile-make)

(require 'helm-xref)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(define-key global-map [remap switch-to-buffer] 'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1 ;; clangd is fast
      ;; be more ide-ish
      lsp-headerline-breadcrumb-enable t)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;(add-to-list 'c-mode-common-hook
;      (lambda () (setq c-syntactic-indentation nil)))
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(c-add-style "m5" '("linux"
		    (c-basic-offset . 4)
                    (indent-tabs-mode . nil)
		    (fill-column . 95)
	            (c-offsets-alist . ((substatement-open . 0)
				        (inline-open . 0)
				        (block-open . -4)
				        (case-label . 2)
				        (label . 2)
				        (statement-case-intro . 2)
				        (statement-case-open . 2)
				        (access-label . -2)
				        (innamespace . 0)))))

(setq-default show-trailing-whitespace t)
(setq-default delete-trailing-whitespace t)
(setq-default lsp-enable-indentation nil)

(define-key c-mode-map (kbd "C-c /") 'lsp-ui-find-workspace-symbol)
(define-key c++-mode-map (kbd "C-c /") 'lsp-ui-find-workspace-symbol)

(provide 'my-prog)


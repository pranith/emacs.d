(require 'helm)
(require 'helm-config)
(require 'helm-ag)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-split-window-inside-p            t ; open helm buffer inside current window
                                              ; not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when
                                              ; reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for lib in `require', `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; key bindings
(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-c C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "C-c M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "C-c M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
(define-key helm-gtags-mode-map (kbd "M-[") 'helm-gtags-find-rtag)
(define-key helm-gtags-mode-map (kbd "M-]") 'helm-gtags-find-symbol)

(global-set-key (kbd "M-s s")   'helm-ag)

(setq helm-gtags-auto-update t)

(helm-mode t)

(provide 'my-helm)

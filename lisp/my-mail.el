(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
;; default
(setq mu4e-maildir "~/devops/Maildir")
(setq mu4e-drafts-folder "/[gmail].drafts")
(setq mu4e-sent-folder   "/[gmail].sent_mail")
(setq mu4e-trash-folder  "/[gmail].trash")
(setq mu4e-compose-complete-addresses t)
(setq mu4e-compose-complete-only-personal t)
(setq mu4e-html2text-command "html2text -utf8 -width 72")
(setq mu4e-user-mail-address-list '("bobby.prani@gmail.com"
				    "pranith@gatech.edu"
				    "pdenthumdas3@gatech.edu"
				    "bobbyprani@gmail.com"))

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

     ;; Header markers
    (defvar my-mu4e-patches nil
      "List of mu4e-messages snagged by the (Patches) actions.")
    (defvar my-mu4e-applied-patches nil
      "List of mu4e-messages successfully applied by the (Patches)
    actions.")
    (make-variable-buffer-local 'my-mu4e-patches)
    (make-variable-buffer-local 'my-mu4e-applied-patches)

    (defun my-mu4e-apply-marked-mbox-patches ()
      "Apply patches in order."
      (interactive)
      (let ((applied-or-skipped
             (--take-while
              (let ((docid (plist-get it :docid)))
                (if (mu4e-mark-docid-marked-p docid)
                    (if (= 0 (mu4e-action-git-apply-mbox it))
                        (when (mu4e~headers-goto-docid docid)
                          (mu4e-mark-set 'unmark) t)
                      ; failed to apply, stop
                      nil)
                  ; not marked, skip
                  t))
              (--sort
               (string<
                (mu4e-message-field-raw it :subject)
                (mu4e-message-field-raw other :subject))
               (-difference my-mu4e-patches
                            my-mu4e-applied-patches)))))
        (setq my-mu4e-applied-patches
              (-union my-mu4e-applied-patches applied-or-skipped))

        (message (format "Applied %d (%d)/%d patches"
                         (length applied-or-skipped)
                         (length my-mu4e-applied-patches)
                         (length my-mu4e-patches)))))

    (add-to-list
     'mu4e-marks
     '(patch
       :char ("#" . "#")
       :prompt "Patch"))

    (add-to-list
     'mu4e-headers-custom-markers
     '("Patches"
       ;; Match function
       (lambda (msg parent-id)
         (when
             (and
              (string-match
               parent-id
               (or
                (mu4e-message-field-raw msg :in-reply-to)
                ""))
              (string-match "^\\[" (mu4e-message-field-raw msg
                                                           :subject)))
           (add-to-list 'my-mu4e-patches msg)))
       ;; Param function
       (lambda ()
         (setq my-mu4e-patches nil
               my-mu4e-applied-patches nil)
         (let ((msg (mu4e-message-at-point)))
           (mu4e-message-field-raw msg :message-id)))))
    ;; Header actions
    (setq mu4e-headers-actions
          (delete-dups
           (append
            mu4e-headers-actions
            '(("gapply git patches" . mu4e-action-git-apply-patch)
              ("mgit am patch" . mu4e-action-git-apply-mbox)
              ("rrun checkpatch script" . my-mu4e-action-run-check-patch)
              ("sMark SPAM" . my-mu4e-register-spam-action)
              ("hMark HAM" . my-mu4e-register-ham-action)))))
    ;; Message actions
    (setq mu4e-view-actions
          (delete-dups
           (append
            '(("gapply git patches" . mu4e-action-git-apply-patch)
              ("mgit am patch" . mu4e-action-git-apply-mbox)
              ("crun checkpatch script" . my-mu4e-action-run-check-patch)))))

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '( ("/inbox"               . ?i)
         ("/[gmail].sent_mail"   . ?s)
         ("/[gmail].trash"       . ?t)
         ("/[gmail].all_mail"    . ?a)
         ("/dev.lkml"            . ?l)
         ("/dev.qemu"            . ?q)))

;; allow for updating mail using 'U' in the main view:
(setq
  mu4e-get-mail-command "offlineimap"   ;; or fetchmail, or ...
  mu4e-update-interval 3600)            ;; update every 1 hr

;; something about ourselves
(setq
 user-mail-address "bobby.prani@gmail.com"
 user-full-name  "Pranith Kumar"
 mu4e-compose-signature
 (concat
  "Pranith\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
    smtpmail-stream-type 'starttls
    smtpmail-default-smtp-server "smtp.gmail.com"
    smtpmail-smtp-server "smtp.gmail.com"
    smtpmail-auth-credentials
    (expand-file-name "~/.authinfo.gpg")
    smtpmail-smtp-service 587)

;; Set default directory when viewing messages
(defvar my-mailing-list-dir-mapping
  '( ("qemu-devel" . "~/devops/code/qemu/")
     ("kvmarm" . "~/linux")
     ("linux-kernel" . "~/linux")
     ("kvm" . "~/linux/") )
  "Mapping from mailing lists to source tree.")

(defvar my-mail-address-mapping
  ' ( ("qemu-devel@nongnu.org" . "~/devops/code/qemu/")
      ("kvmarm@lists.cs.columbia.edu" . "~/linux/")
      ("linux-kernel@vger.kernel.org" . "~/linux/") )
    "Mapping from target address to source tree.
Useful for replies and drafts")

(defvar my-maildir-mapping
  '( ("/dev.qemu" . "~/devops/code/qemu/")
     ("/dev.lkml" . "~/kernel/linux/") )
  "Mapping from maildirs to source tree.")

(defun my-get-code-dir-from-email ()
  "Return the associated code directory depending on email."
  (let* ((msg (mu4e-message-at-point t))
         (list (mu4e-message-field msg :mailing-list))
         (maildir (mu4e-message-field msg :maildir))
         (addresses (-map 'cdr (append (mu4e-message-field msg :to)
                                       (mu4e-message-field msg :cc)))))
    (expand-file-name
     (or
      (assoc-default list my-mailing-list-dir-mapping)
      (assoc-default maildir my-maildir-mapping 'string-match)
      (assoc-default (-first
                      #'(lambda (mail)
                          (assoc-default mail my-mail-address-mapping))
                      addresses) my-mail-address-mapping)
      "~"))))

(defun my-set-view-directory ()
  "Switch the `default-directory' depending on mail contents."
  (interactive)
  (when (mu4e-message-at-point t)
    (setq default-directory (my-get-code-dir-from-email))))

(defun my-search-code-from-email ()
  "Search code depending on email."
  (interactive)
  (my-project-find (my-get-code-dir-from-email)))

(require 'use-package nil t)
(use-package mu4e-compose
  :commands mu4e-compose-mode
  :defines mu4e-compose-mode-map
  :config (progn
            ;; key-bindings
            (when (keymapp mu4e-compose-mode-map)
              (define-key mu4e-compose-mode-map (kbd "C-w")
                'my-snip-region)
              (define-key mu4e-compose-mode-map (kbd "<f5>")
                'my-search-code-from-email))
              (add-hook 'mu4e-compose-mode-hook 'my-set-view-directory)))

(use-package mu4e-headers
  :commands mu4e-headers-mode
  :defines mu4e-headers-mode-map
  :config (progn
            ;; My mode bindings
            (define-key mu4e-headers-mode-map (kbd "C-c C-l") 'org-store-link)
            (define-key mu4e-headers-mode-map (kbd "C-c t")
              'my-switch-to-thread)
            (add-hook 'mu4e-headers-mode-hook
                      '(lambda () (yas-minor-mode -1)))
            (add-hook 'mu4e-headers-mode-hook 'my-set-view-directory)))

(use-package mu4e-view
  :commands mu4e-view
  :defines mu4e-view-mode-map
  :config (progn
            ;; My mode bindings
            (define-key mu4e-view-mode-map (kbd "C-c C-l") 'org-store-link)
            (define-key mu4e-view-mode-map (kbd "C-c t") 'my-switch-to-thread)
            ;; mode hooks
            (add-hook 'mu4e-view-mode-hook 'my-set-view-directory)))

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; do not show duplicates
(setq mu4e-headers-skip-duplicates t)

;;
;; Checkpatch in emails
;;
(defvar my-checkpatch-script-history nil
  "History of checkpatch invocations.")

(defun my-mu4e-do-checkpatch (script-path msg)
  "Run `SCRIPT-PATH' on `MSG'."
  (let ((proc-name "checkpatch")
        (buff-name (get-buffer-create (format "*checkpatch*")))
        (msg-path (mu4e-message-field msg :path)))
    ;; header
    (with-current-buffer buff-name
      (goto-char (point-max))
      (insert (format "Running %s on %s\n"
                      script-path
                      (mu4e-message-field msg :subject))))
    ;; checkpatch
    (start-process-shell-command
     proc-name
     buff-name
     (format "cat %s | %s -" msg-path script-path))
    ;;
    (switch-to-buffer buff-name)
    (goto-char (point-max))
    (compilation-minor-mode)))

(defun my-mu4e-action-run-check-patch (msg)
  "Run checkpatch against the [patch] `MSG'."
  (let ((last-script (car my-checkpatch-script-history)))
    ;; prompt the user if we can't go with the last run
    (when (not (and last-script
                    (file-exists-p last-script)
                    (s-contains? default-directory last-script)))
      (let ((ido-work-file-list my-checkpatch-script-history))
        (setf last-script
              (ido-read-file-name
               "Checkpatch Script: " default-directory))
        (setf my-checkpatch-script-history
              (cons last-script (delete last-script
                                        my-checkpatch-script-history)))))
      ;; do the checkpatch
      (my-mu4e-do-checkpatch last-script msg)))

;; shortcut to start mu4e
(global-set-key (kbd "C-x e") 'mu4e)

(provide 'my-mail)

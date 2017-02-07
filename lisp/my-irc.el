(load-file "~/.private.el")

;; circe IRC client
(setq circe-network-options
      '(("oftc"
         :host "irc.oftc.net"
         :port (6667)
         :nick "justreading"
         :channels ("#linux-rt" "#kernelnewbies" "#qemu" "#qsim" "#qemu-gsoc" "#qemu-mttcg")
         :nickserv-password ,oftc-password)))

(setq circe-reduce-lurker-spam t)

(provide 'my-irc)

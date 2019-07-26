(require 'verilog-mode)
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?[vg]\\'" . verilog-mode))

;; Enable syntax highlighting of **all** languages
(global-font-lock-mode t)

 
;; User customization for Verilog mode
(setq verilog-indent-level             1
      verilog-indent-level-module      1
      verilog-indent-level-declaration 1
      verilog-indent-level-behavioral  1
      verilog-indent-level-directive   1
      verilog-case-indent              2
      verilog-auto-newline             nil
      verilog-auto-indent-on-newline   nil
      verilog-tab-always-indent        t
      verilog-auto-endcomments         t
      verilog-minimum-comment-distance 40
      verilog-indent-begin-after-if    t
      verilog-auto-lineup              nil
      verilog-highlight-p1800-keywords nil
      verilog-linter                   "my_lint_shell_command"
      )

(provide 'my-vg)

;; ===== Remove the startup screen =====
(custom-set-variables '(inhibit-startup-screen t))
(custom-set-faces)
(setq inhibit-startup-message t)

;; ===== Set the highlight current line minor mode =====
(global-hl-line-mode 1)

;; ===== Enable copy paste with the clipboard =====
(setq x-select-enable-clipboard t)
(setq locale-preferred-coding-systems '((".*" . utf-8)))

;; ===== Disable the menu, toolbar, and scrollbar =====
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; ===== General-purpose defaults =====
(size-indication-mode t) ;; Show file size along with file position
(line-number-mode t)	 ;; Show file position in (row, col) format
(column-number-mode t)	 ;; ''
(display-time-mode)      ;; Show current time in status line
(setq-default indent-tabs-mode nil ;; Insert tabs as spaces (not tabs)
	      indicate-buffer-boundaries 'left	;; Graphical gimmick
	      indicate-empty-lines t	;; Graphical gimmick
	      show-trailing-whitespace t
	      initial-major-mode 'text-mode
	      default-major-mode 'text-mode)

;; ===== Set standard indent to 2 rather that 4 ====
(setq standard-indent 2)

;; ===== Turn off tab character =====
;;
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request
;; this, set `indent-tabs-mode' to `nil'. This is a per-buffer
;; variable; altering the variable affects only the current buffer,
;; but it can be disabled for all buffers.
;;
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally
;;
(setq-default indent-tabs-mode nil)

;; ========== Support Wheel Mouse Scrolling ==========
(mouse-wheel-mode t)

;; ===== Linux-style C =====
(require 'cc-mode)
(setq c-default-style "linux"
      c-basic-offset 2)
(global-font-lock-mode 1)
(defun my-build-tab-stop-list (width)
  (let ((num-tab-stops (/ 80 width))
	(counter 1)
	(ls nil))
    (while (<= counter num-tab-stops)
      (setq ls (cons (* width counter) ls))
      (setq counter (1+ counter)))
    (set (make-local-variable 'tab-stop-list) (nreverse ls))))
(defun my-c-mode-common-hook ()
  (setq tab-width 2)
  (my-build-tab-stop-list tab-width)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil)) ;; force only spaces for indentation
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook 'fci-mode)

;; ===== Compiling Shortcut =====
(global-set-key [(f9)] 'compile)

;; ===== Compilation Window Management =====
(setq compilation-window-height 8)

(setq compilation-finish-function
      (lambda (buf str)

        (if (string-match "exited abnormally" str)

            ;;there were errors
            (message "Errors! X[ Press C-x ` to visit")

          ;;no errors, compilation window goes away in 0.5 seconds
          (run-at-time 0.5 nil 'delete-windows-on buf)
          (message "^_^"))))

;; ===== Hungry Delete =====
(c-toggle-hungry-state 1)

;; ===== Goto-line short-cut =====
(global-set-key "\C-l" 'goto-line)

;; ===== Autocomplete =====
(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; ===== Remove trailing white space shortcut =====
(global-set-key "\C-xt" 'delete-trailing-whitespace)

;; ===== Associate markdown-mode with .md files =====
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; ===== Marmalade =====
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; ===== Fill-column indicator =====
(require 'fill-column-indicator)
(global-set-key "\C-xc" 'fci-mode)


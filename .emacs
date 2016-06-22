;; Paul Abery .emacs
;; (c) 1994 Paul Abery CS2
;; cs2ez@herts.ac.uk
(defvar *emacs-load-start* (current-time))
;; Try to improve slow performance on windows.
;;(setq w32-get-true-file-attributes nil)
(setq load-path (append '("~/emacs") load-path))
(add-to-list 'custom-theme-load-path "~/emacs/themes")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("4eafeeaac976dc4cc948940321a07cd6cb692facaf66b561a2b42c54f6afa084" "3f447207f112ceba4158f3bc1d2bebe734023c81ae3f676351e3c538a3f89e25" "32254b82a1a3cb894132242cc74503eaf6ffca02a9884570783ff76f248984ef" "b84b363110b6aa3c931b5ab00edd259d970d357bb8e24ede2b6553306a18f697" "d6413884cee3b57f151b8591d40d496c93314033102776bc4ed9c36ea0df8244" "0c8ffb272e65e2ffc49b0d5755d7db137931c5e3ed47890d7a6de07717eaa2e8" default)))
 '(inhibit-startup-screen t)
 '(linum-delay t)
 '(linum-eager nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))


;;(require 'zenburn-theme)
;;(load-theme 'twilight)
;; Put the scrollbar in the right place
(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right)

;; Disable git backend to speed up sshfs file load among other things
(setq vc-handled-backends (quote (RCS CVS Hg)))
;;Smooth mouse wheel scrolling
(require 'smooth-scroll)
(smooth-scroll-mode t)
; Autosave every 500 typed characters
(setq auto-save-interval 500)
; Scroll just one line when hitting bottom of window
(setq scroll-conservatively 10000)
;;(setq scroll-step 1)
;;(setq scroll-conservatively 10000)
;;(setq auto-window-vscroll nil)
;;(setq scroll-preserve-screen-position t)

;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;;(setq mouse-wheel-progressive-speed nil)

;; Configures Emacs to send deleted files to the system trash can
(setq delete-by-moving-to-trash t)

;; Configure Open recent
(require 'recentf)
(recentf-mode 1)

;; Start the emacs server
(require 'server)
(or (server-running-p)
    (server-start))

;; set backword kill word, and kill region
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; ditch the tool bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; Set line cursor
;;(setq-default cursor-type 'bar)

;; No more tabs
(setq-default indent-tabs-mode nil)

;; set up ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching
(setq ido-execute-command-cache nil)

(autoload 'idomenu "idomenu" t)
(global-set-key (kbd "C-x m") 'idomenu)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'sr-speedbar)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)
(setq speedbar-use-images nil)
;; Supress line numbers in the speedbar
(setq speedbar-mode-hook '(lambda () (linum-mode 0)))

(require 'sql)
(setq auto-mode-alist
          (append
           '(("\\.\\(p\\(?:k[bgh]\\|ls\\|rc\\)\\|sql\\|typ\\|ddl\\|trg\\|func\\)\\'" . sql-mode))
 auto-mode-alist))

    (speedbar-add-supported-extension "pls")
    (speedbar-add-supported-extension "pkg")
    (speedbar-add-supported-extension "pkh")
    (speedbar-add-supported-extension "pkb")
    (speedbar-add-supported-extension "sql")
    (speedbar-add-supported-extension "ddl")
    (speedbar-add-supported-extension "prc")
    (speedbar-add-supported-extension "fnc")
    (speedbar-add-supported-extension "trg")
(add-hook 'sql-mode-hook '(lambda () (setq indent-tabs_mode nil)))
(add-hook 'sql-mode-hook '(lambda () (setq tab-width 3)))
(add-hook 'sql-mode-hook '(lambda () (set (make-local-variable 'indent-line-function) 'insert-tab)))
;;(add-hook 'sql-mode-hook '(lambda () (set (make-local-variable 'indent-region-function) 'plsql-indent-region)))
;;(add-hook 'sql-mode-hook '(lambda () (set (make-local-variable 'align-mode-rules-list) 'plsql-align-rules-list)))
(add-hook 'sql-mode-hook '(lambda () (local-set-key [(return)] 'newline-and-indent)))
(sql-set-product 'oracle)

(defun indent-or-expand (arg)
 "Either indent according to mode, or expand the word preceding point."
 (interactive "*P")
 (if (and
      (or (bobp) (= ?w (char-syntax (char-before))))
      (or (eobp) (not (= ?w (char-syntax (char-after))))))
     (dabbrev-expand arg)
   (indent-according-to-mode)))

(require 'cua-rect)
(defun hkb-mouse-mark-cua-rectangle (event)
  (interactive "e")
  (if (not cua--rectangle)
  (cua-mouse-set-rectangle-mark event)
(cua-mouse-resize-rectangle event)))

(require 'cua-base)
(global-unset-key (kbd "<S-down-mouse-1>"))
(global-set-key (kbd "<S-mouse-1>") 'hkb-mouse-mark-cua-rectangle)
(define-key cua--rectangle-keymap (kbd "<S-mouse-1>") 'hkb-mouse-mark-cua-rectangle)
;; Switch on cua mode by default
(cua-mode 1)

(show-paren-mode 1) ; turn on paren match highlighting

;;(global-hl-line-mode 1) ; turn on highlighting current line

;;(global-linum-mode 1) ; display line numbers in margin
;;(setq linum-format "\u2502")

(defvar my-linum-format-string "%4d")

 (add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

 (defun my-linum-get-format-string ()
   (let* ((width (length (number-to-string
                          (count-lines (point-min) (point-max)))))
          (format (concat "%" (number-to-string width) "d\u2502")))
     (setq my-linum-format-string format)))

 (setq linum-format 'my-linum-format)

 (defun my-linum-format (line-number)
   (propertize (format my-linum-format-string line-number) 'face 'linum))

(transient-mark-mode 1) ; highlight text selection
(delete-selection-mode 1) ; delete seleted text when typing

(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))

(add-hook 'c-mode-hook              'my-tab-fix)
(add-hook 'sh-mode-hook             'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook     'my-tab-fix)
(add-hook 'sql-mode-hook            'my-tab-fix)

(require 'htmlize)
;;(sr-speedbar-toggle)

(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this. The function inserts linebreaks to separate tags that have
nothing but whitespace between them. It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
      (backward-char) (insert "\n") (setq end (1+ end)))
    (indent-region begin end))
  (message "Ah, much better!"))

;; Some URL encoding and decoding functions
(defun func-region (start end func)
  "run a function over the region between START and END in current buffer."
  (save-excursion
    (let ((text (delete-and-extract-region start end)))
      (insert (funcall func text)))))

(defun hex-region (start end)
  "urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-hexify-string))

(defun unhex-region (start end)
  "de-urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-unhex-string))

(require 'restclient)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;(message "Paul .emacs loads in %ds" (destructuring-bind (hi lo ms) (current-time)
;;                                      (- (+ hi lo) (+ (first *emacs-load-start*) (second *emacs-load-start*)))))

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 90 :width normal)))))

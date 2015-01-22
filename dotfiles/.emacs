;;; Influenced by the following Emacs dotfile:
;;; http://www.emacswiki.org/emacs/PointEmacs

;; Highlight parenthesis matching
(show-paren-mode 1)

;; Cua-mode (aka copy-paste) enabling
(cua-mode t)

;; Reach a specific line
;; CTRL + G 
(global-set-key (kbd "C-g") 'goto-line)

;; Toggle between *frames* easily
;; CTRL + TAB
(global-set-key (kbd "<C-tab>") 'next-multiframe-window)
(global-set-key (kbd "<C-c C-d>") 'next-multiframe-window)
(global-set-key (kbd "<C-S-iso-lefttab>") 'previous-multiframe-window)

;; Toggle between *buffers* easily
;; CTRL + PgDown/PgUp
(global-set-key (kbd "<C-next>") 'next-buffer)
(global-set-key (kbd "<C-prior>") 'previous-buffer)

;; Ouvrir une nouvelle fenetre
(global-set-key (kbd "<C-n>")' new-frame)

;; Ouvrir un nouveau fraem
(global-set-key (kbd "<C-t>") 'split-window-horizontally)
(global-set-key (kbd "<C-t C-t>") 'split-window-vertically)

;; Compile shortcut
;; CTRL + C + !
(global-set-key (kbd "C-c C-!") 'compile)
(global-set-key (kbd "C-!") 'recompile)

(global-set-key (kbd "<C-x C-e>") 'rml-eval-phrase)
(global-set-key (kbd "<C-x C-a>") 'run-rml)

;; Show column number
(column-number-mode 1)
(line-number-mode 1)

;; Enable syntactic coloring
(global-font-lock-mode t)

;; surlignage d'une région sélectionnée
(transient-mark-mode t)

;; Gather all backup files in one place
(setq backup-directory-alist
'(("." . "~/.emacs-backup-files/")))

;; Avoir to fully type yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Customize window title texts
(setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

;; Prove and program in Coq with ProofGeneral
(setq load-path (cons "/home/psaxl/Paquets/.local/ProofGeneral-4.2/generic/" load-path))
(setq load-path (cons "/home/psaxl/Paquets/.local/ProofGeneral-4.2/generic/" load-path))
(require 'proof-site nil t)
(setq proof-three-window-enable t)
(setq proof-splash-enable nil)
(setq coq-prog-name "/usr/bin/coqtop")

;; Some shortcuts in ProofGeneral

(add-hook 'proof-mode-hook '(lambda ()                                 
; commande suivante (lance le process Coq si necessaire)
 (define-key proof-mode-map [(control meta down)] 'proof-assert-next-command-interactive)
 (define-key proof-mode-map [(control meta up)] 'proof-assert-next-command-interactive)
; undo, revient une commande en arriere
 (define-key proof-mode-map [(control meta up)] 'proof-undo-last-successful-command)
; lire le script jusqu'au curseur (lance le process Coq si necessaire)
 (define-key proof-mode-map [(control meta right)] 'proof-assert-until-point-interactive)
; undo jusqu'au curseur
 (define-key proof-mode-map [(control meta left)] 'proof-retract-until-point-interactive)
; tuer le process Coq, utile car il ne peut y avoir
; qu'un seul process Coq a la fois (1 process par Emacs)
 (define-key proof-mode-map [(control meta delete)] 'proof-shell-exit)
; Pour interrompre le script en cours, le script s'arrete la ou
; il en etait, cette commande peut compromettre la coherence
; avec la partie read-only du buffer (apparemment c'est rare)
 (define-key proof-mode-map [(control meta insert)] 'proof-interrupt-process)
; reset du script
 (define-key proof-mode-map [(control meta home)] 'proof-retract-buffer)
; effectuer le script jusqu'a la fin du buffer
 (define-key proof-mode-map [(control meta end)] 'proof-process-buffer)
; pour taper une commande directement, mais sans qu'elle soit ajoutee au script
 (define-key proof-mode-map [(control meta return)] 'proof-minibuffer-cmd)
; pour disposer les buffer en trois comme dans coqide 
; (pas utile si proof-three-window-enable)
(define-key proof-mode-map [(control meta 3)] 'proof-display-three-b)
(define-key proof-mode-map [(control meta \")] 'proof-display-three-b)
))

(global-set-key (kbd "<C-p>") 'proof-assert-next-command-interactive)

(global-set-key (kbd "<C-c C-right>") 'proof-assert-next-command-interactive)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; compilation-disable-input 	compilation-mode-hook
;; compilation-process-setup-function 	compilation-search-path
;; compilation-start-hook 	compilation-window-height
;; compile-command 	

(custom-set-variables
 '(compilation-disable-input t)
 '(compile-command "make ")
 '(inhibit-startup-screen t)
 '(load-home-init-file t t))
(custom-set-faces)


;; Using Aspell as spell checker
(setq-default ispell-program-name "aspell")

;; Set Colors
;; (set-background-color "black")
;; (set-border-color "white")
;; (set-border-color "green")
;; (set-cursor-color "white")
;; (set-foreground-color "white")
;; (set-mouse-color "red")

;; ReactiveML mode:
(setq load-path (cons "/home/psaxl/Paquets/.local/rml-mode" load-path))

(setq auto-mode-alist
      (cons '("\\.rml[i]?$" . rml-mode) auto-mode-alist))
(autoload 'rml-mode "rml" "Major mode for editing Rml code." t)
(autoload 'run-rml "inf-rml" "Run an inferior Rml process." t)
(if window-system (require 'rml-font))


;; Lustre mode:
(setq load-path
      (append load-path
	      '("/home/psaxl/Paquets/.local")))
(setq auto-mode-alist (cons '("\\.lus$" . lustre-mode) auto-mode-alist))
(autoload 'lustre-mode "lustre" "Edition de code lustre" t)

; Byte-compile lustre.el to speed-up the loading of a lustre source file :
; M-x byte-compile-file  -> lustre.el

;; PHP mode:
(setq load-path
      (append load-path
	      '("/home/psaxl/Paquets/.local")))
(require 'php-mode)
(setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))
(autoload 'php-mode "php" "Edition de code PHP" t)

;; Markdown mode:
(setq load-path
      (append load-path
	      '("/home/psaxl/Paquets/.local/markdown-mode")))
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; Print current buffer on HTML format output with Htmlize package
;; Useful to print programming code without losing colors
;; http://www.emacswiki.org/emacs/Htmlize
(load "/home/psaxl/Paquets/.local/htmlize.el")

;; Shortcut combination of [htmlize-buffer] then [browse-url-of-buffer]
(global-set-key "\C-h\C-j" 'htmlize-buffer)
(global-set-key "\C-h\C-k" 'browse-url-of-buffer)

;; Shortcut to kill current buffer
;; Key combination: CTRL + C + W
(global-set-key "\C-c\C-w" 'kill-this-buffer)

;; Shortcut to use TeX mode as input method
;; Key combination: CTRL + C + L
(setq alternative-input-methods
      '(("TeX" . [?\C-\c?\C-\l])))
(setq default-input-method
       (caar alternative-input-methods))
(defun toggle-alternative-input-method (method &optional arg interactive)
  (if arg
      (toggle-input-method arg interactive)
    (let ((previous-input-method current-input-method))
      (when current-input-method
	(deactivate-input-method))
      (unless (and previous-input-method
		   (string= previous-input-method method))
	(activate-input-method method)))))
(defun reload-alternative-input-methods ()
  (dolist (config alternative-input-methods)
    (let ((method (car config)))
      (global-set-key (cdr config)
                      `(lambda (&optional arg interactive)
                         ,(concat "Behaves similar to `toggle-input-method', but uses \""
                                  method "\" instead of `default-input-method'")
                         (interactive "P\np")
                         (toggle-alternative-input-method ,method arg interactive))))))
(reload-alternative-input-methods)


;; Avoid Emacs to scream when there are still active processes upon exit
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;; Clipboard buffer sharing between CUA mode and Unix
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Avoid *unselecting* region when copying text in Emacs using cua-mode
(setq cua-keep-region-after-copy t)

;; Permanently set the default tab-width to 7 characters
(setq default-tab-width 7)

;; Stop Emacs from “contaminating” the clipboard when 
;; Ensures the system clipboard has the latest content copied *outsite* Emacs
(setq x-select-enable-clipboard nil)
;; Paste shortcut for system clipboard (instead of kill ring)
(global-set-key (kbd "C-c C-v") 'x-clipboard-yank)

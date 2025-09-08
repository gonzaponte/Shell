;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


(setq confirm-kill-emacs nil)

;;(setq auto-save-default t
;;      make-backup-files t
;;      confirm-kill-eamcs t
;;      )

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(put 'use-package 'lisp-indent-function 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(package-selected-packages
   '(rust-mode notmuch xclip transpose-frame smartparens nix-mode multiple-cursors move-text minimap meson-mode magit lsp-mode helm git-timemachine find-file-in-project company cmake-mode avy auto-complete atomic-chrome))
 '(send-mail-function 'mailclient-send-it)
 '(show-paren-mode t))

(defun highlight-current-branch ()
  "Highlight the current branch in Magit buffers."
  (interactive)
  (set-face-attribute 'magit-branch-current
                      nil
                      :inverse-video nil
                      :weight 'bold
                      :slant 'italic
                      :foreground "purple"
;;                      :background "black"
                      :underline t))

(defun highlight-current-line ()
  "Highlight the current branch in Magit buffers."
  (interactive)
  (set-face-attribute 'magit-section-highlight
                      nil
                      :background "black"
                      ))


;; HOOKS
(add-hook 'write-file-hooks 'delete-trailing-whitespace) ;; delete spurious whitespaces when saving a file
(add-hook 'magit-mode-hook  'highlight-current-branch  ) ;; highlight current branch in magit
(add-hook 'magit-mode-hook  'highlight-current-line    ) ;; highlight current line in magit


;; THEME
(load-file "~/sw/git/Shell/gonzalo.el")
(enable-theme 'gonzalo)
(set-face-attribute 'region  nil :background "slateblue4" :foreground "white")
(set-face-attribute 'isearch nil :background "slateblue4" :foreground "white")


;; NIX-MODE
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))


;; MESON MODE
(add-hook 'meson-mode-hook 'company-mode)


;; CLANGD
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)


;; RUST-MODE
(require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))


;; COMPANY
(global-company-mode)


(setq column-number-mode t)

;; MOVE TEXT
(global-set-key (kbd "C-<up>") 'move-text-up)
(global-set-key (kbd "C-<down>") 'move-text-down)

(defun indent-region-advice (&rest ignored)
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
        (indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))

(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)


;; MULTIPLE CURSORS
(global-set-key (kbd "C-M-m C-M-m") 'mc/edit-lines)
(global-set-key (kbd "C-M-m a a"  ) 'mc/mark-all-like-this)
(global-set-key (kbd "C-M-m a w"  ) 'mc/mark-all-words-like-this)
(global-set-key (kbd "C-M-m a s"  ) 'mc/mark-all-symbols-like-this)
(global-set-key (kbd "C-M-m a SPC") 'mc/mark-all-in-region)
(global-set-key (kbd "C-M-m a x"  ) 'mc/mark-all-in-region-regexp)
(global-set-key (kbd "C-M-m n"    ) 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-m p"    ) 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-m C-M-e") 'mc/mark-next-like-this-word)
(global-set-key (kbd "C-M-m C-M-r") 'mc/mark-previous-like-this-word)
(global-set-key (kbd "C-M-m C-M-n") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-M-m C-M-p") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-M-m f"    ) 'mc/mark-next-symbol-like-this)
(global-set-key (kbd "C-M-m b"    ) 'mc/mark-previous-symbol-like-this)
(global-set-key (kbd "C-M-m 0"    ) 'mc/insert-numbers)


;; AVY

;; (defun avy-goto-parens ()
;;   (interactive)
;;   (let ((avy-command this-command))   ; for look up in avy-orders-alist
;;     (avy-jump "(+")))
;; (add-to-list 'avy-orders-alist '(avy-goto-parens . avy-order-closest))

(global-set-key (kbd "C-x a l")   'avy-goto-line)
(global-set-key (kbd "C-x a c")   'avy-goto-char-timer)
(global-set-key (kbd "C-x C-a l") 'avy-copy-line)
(global-set-key (kbd "C-x C-a r") 'avy-copy-region)
;; (global-set-key (kbd "C-x a p")   'avy-goto-parens)

(setq avy-all-windows 'all-frames)
(setq avy-background t)
(setq avy-case-fold-search nil)
(setq avy-highlight-first t)
(setq avy-timeout-seconds 0.8)

(defface avy-lead-face            '((t (:foreground "brightwhite" :background "blue"       :weight bold))) "")
(defface avy-lead-face-0          '((t (:foreground "brightwhite" :background "firebrick4" :weight bold))) "")
(defface avy-lead-face-2          '((t (:foreground "brightwhite" :background "green"      :weight bold))) "")
(defface avy-goto-char-timer-face '((t (:foreground "brightwhite" :background "yellow"     :weight bold))) "")


;; MAIL
;; (setq mail-user-agent 'message-user-agent)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-stream-type 'starttls
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; NOTMUCH
;; (use-package notmuch
;;   :init
;; (setq message-directory "~/.mail")
;; (setq send-mail-function 'sendmail-send-it)
;; ;; Send from correct email account
;; (setq message-sendmail-f-is-eval 't)
;; (setq message-sendmail-extra-arguments '("--read-envelope-from"))
;; (setq mail-specify-envelope-from 't)
;; (setq mail-envelope-from 'header)
;; (setq message-sendmail-envelope-from 'header)
;; ;; Setting proper from, fixes i-did-not-set--mail-host-address--so-tickle-me
;; (setq mail-host-address "blablabla.com")
;; (setq user-full-name "BLA BLA BLA")
;; :config
;; (setq notmuch-show-logo nil)
;; ;; Writing email
;; (setq message-default-mail-headers "Cc: \nBcc: \n") ;; Always show BCC
;; (setq notmuch-always-prompt-for-sender 't)
;; ;; PGP Encryption
;; (add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)
;; (setq notmuch-crypto-process-mime t)
;; ;; Saving sent mail in folders depending on from
;; (setq notmuch-fcc-dirs '(("gonzaponte@gmail.com" . "gonzaponte@gmail.com/enviado")
;;                          ("gonzalo.martinez.lema.weizmann@gmail.com" . "gonzalo.martinez.lema.weizmann@gmail.com/enviado'")
;;                          ))
;; (setq notmuch-search-oldest-first nil)
;;  )

;; SMART PARENS
;;(require 'smartparens-config)
;;(add-hook 'text-mode-hook #'smartparens-mode)
;;(add-hook 'normal-mode-hook #'smartparens-mode)
;;(add-hook 'c++-mode-hook #'smartparens-mode)
(smartparens-global-mode)


;; XCLIP
(xclip-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; FLYMAKE
(global-set-key (kbd "C-x f") 'flymake-goto-next-error)

;; EXWM
;; (require 'exwm)
;; ;; Set the initial workspace number.
;; (setq exwm-workspace-number 4)
;; ;; Make class name the buffer name.
;; (add-hook 'exwm-update-class-hook
;;   (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
;; ;; Global keybindings.
;; (setq exwm-input-global-keys
;;       `(([?\s-r] . exwm-reset) ;; s-r: Reset (to line-mode).
;;         ([?\s-w] . exwm-workspace-switch) ;; s-w: Switch workspace.
;;         ([?\s-&] . (lambda (cmd) ;; s-&: Launch application.
;;                      (interactive (list (read-shell-command "$ ")))
;;                      (start-process-shell-command cmd nil cmd)))
;;         ;; s-N: Switch to certain workspace.
;;         ,@(mapcar (lambda (i)
;;                     `(,(kbd (format "s-%d" i)) .
;;                       (lambda ()
;;                         (interactive)
;;                         (exwm-workspace-switch-create ,i))))
;;                   (number-sequence 0 9))))
;; ;; Enable EXWM
;; (exwm-enable)

(global-visual-line-mode t)

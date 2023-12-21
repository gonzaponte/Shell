(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)


(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;; emacs < 27.1
(unless (fboundp 'package-activate-all) (package-initialize))

(put 'use-package 'lisp-indent-function 1)


;; bring $PATH from shell in GUI
;; (use-package exec-path-from-shell
;;   :init (when (memq window-system '(mac ns x))
;;           (exec-path-from-shell-initialize)))

(use-package magit

  :bind  (("M-g M-s" . magit-status)
          ("M-g M-d" . magit-dispatch-popup)
          ("C-x g"   . magit-status)
          ("C-x C-g" . magit-dispatch-popup))

  :config
  (setq magit-last-seen-setup-instructions "1.4.0")
;;  (global-magit-file-mode 1)
  (magit-define-popup-switch 'magit-log-popup ?p "first parent" "--first-parent"))


(use-package helm
  :bind (
         ("M-x"     . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("M-y"     . helm-show-kill-ring)
         ("C-x b"   . helm-mini)
         ("C-x c g" . helm-do-grep)
         ("C-x c o" . helm-occur)

         :map helm-map
         ;; ("<tab>" . helm-execute-persistent-action) ; Bug: gets
         ;; bound in global map ! so I'm doing it below with
         ;; define-key instead
         ;;("C-i"   . helm-execute-persistent-action)
         ("C-z"   . helm-select-action)

         )

  :config
  ;; Bug: :bind :map doesn't seem to work properly for special keys,
  ;; and bind <tab> in the global map.
  (bind-key "<tab>" #'helm-execute-persistent-action helm-map)

  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
        helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp
        helm-scroll-amount                    8 ; scroll 8 lines other window usin M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t
        helm-M-x-fuzzy-match                  t
        helm-move-to-line-cycle-in-source     nil
        helm-command-prefix-key               "C-z")

  (helm-mode 1)
  (helm-autoresize-mode t))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(package-selected-packages
   '(notmuch xclip transpose-frame smartparens nix-mode multiple-cursors move-text minimap meson-mode magit lsp-mode helm git-timemachine find-file-in-project company cmake-mode avy auto-complete atomic-chrome))
 '(send-mail-function 'mailclient-send-it)
 '(show-paren-mode t))

;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

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
(load-file "~/.emacs.d/gonzalo.el")
(enable-theme 'gonzalo)


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

;; COMPANY
(global-company-mode)

;; LINE NUMBERS
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

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
(setq mail-user-agent 'message-user-agent)
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; NOTMUCH
;; (use-package notmuch
;;   :init
(setq message-directory "~/.mail")
(setq send-mail-function 'sendmail-send-it)
;; Send from correct email account
(setq message-sendmail-f-is-eval 't)
(setq message-sendmail-extra-arguments '("--read-envelope-from"))
(setq mail-specify-envelope-from 't)
(setq mail-envelope-from 'header)
(setq message-sendmail-envelope-from 'header)
;; Setting proper from, fixes i-did-not-set--mail-host-address--so-tickle-me
(setq mail-host-address "blablabla.com")
(setq user-full-name "BLA BLA BLA")
:config
(setq notmuch-show-logo nil)
;; Writing email
(setq message-default-mail-headers "Cc: \nBcc: \n") ;; Always show BCC
(setq notmuch-always-prompt-for-sender 't)
;; PGP Encryption
(add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)
(setq notmuch-crypto-process-mime t)
;; Saving sent mail in folders depending on from
(setq notmuch-fcc-dirs '(("gonzaponte@gmail.com" . "gonzaponte@gmail.com/enviado")
                         ("gonzalo.martinez.lema.weizmann@gmail.com" . "gonzalo.martinez.lema.weizmann@gmail.com/enviado'")
                         ))
(setq notmuch-search-oldest-first nil)
;;  )

;; SMART PARENS
(require 'smartparens-config)
;;(add-hook 'text-mode-hook #'smartparens-mode)
;;(add-hook 'normal-mode-hook #'smartparens-mode)
;;(add-hook 'c++-mode-hook #'smartparens-mode)
(smartparens-global-mode)


;; XCLIP
(xclip-mode 1)

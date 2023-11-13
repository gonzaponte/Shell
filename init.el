(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(setq use-package-always-ensure t)
(put 'use-package 'lisp-indent-function 1)

(use-package exec-path-from-shell
  :init (when (memq window-system '(mac ns x))
          (exec-path-from-shell-initialize)))

(use-package magit

  :bind  (("M-g M-s" . magit-status)
          ("M-g M-d" . magit-dispatch-popup)
          ("C-x g"   . magit-status)
          ("C-x C-g" . magit-dispatch-popup))

  :config
  (setq magit-last-seen-setup-instructions "1.4.0")
  (global-magit-file-mode 1)
  (magit-define-popup-switch 'magit-log-popup ?p "first parent" "--first-parent"))


(use-package helm
  :bind (("C-c h h" . helm-command-prefix)
         ("M-x"     . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("M-y"     . helm-show-kill-ring)
         ("C-x b"   . helm-mini)

         :map helm-map
         ;; ("<tab>" . helm-execute-persistent-action) ; Bug: gets
         ;; bound in global map ! so I'm doing it below with
         ;; define-key instead
         ;;("C-i"   . helm-execute-persistent-action)
         ("C-z"   . helm-select-action)

         :map
         helm-command-prefix
         ("g"     . helm-do-grep)
         ("o"     . helm-occur))

  :config
  (require 'helm-config)
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
   (quote
    (git-timemachine avy cmake-mode meson-mode nix-mode transpose-frame multiple-cursors minimap auto-complete find-file-in-project company eglot-jl flymake-go flymake-python-pyflakes eglot helm magit use-package)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(load-theme 'wombat t)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;;(set-face-attribute 'magit-branch-current nil :weight 'bold :slant 'italic :foreground "purple" :underline t)
;;(set-face-attribute 'magit-branch-current nil :weight 'bold)

(defun highlight-current-branch ()
  "Highlight the current branch in Magit buffers."
  (interactive)
  (set-face-attribute 'magit-branch-current
                      nil
                      :weight 'bold
                      :slant 'italic
                      :foreground "purple"
                      :underline t))


(add-hook 'magit-mode-hook 'highlight-current-branch)

(unless (fboundp 'package-activate-all) (package-initialize))

(setq package-list
    '(avy nix-mode cmake-mode meson-mode eglot helm magit git-timemachine company find-file-in-project auto-complete popup minimap multiple-cursors move-text transpose-frame))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

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
(global-set-key (kbd "C-M-m C-M-a") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-M-m C-M-e") 'mc/edit-ends-of-lines)
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
(global-set-key (kbd "C-x j l") 'avy-goto-line)
(global-set-key (kbd "C-x j s") 'avy-goto-char-timer)

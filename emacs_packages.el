(require 'package)

;; disable autostartup
(setq package-enable-at-startup nil)

;; set up repositories
(add-to-list 'package-archives '(    "melpa" . "http://melpa.org/packages/")            t)
(add-to-list 'package-archives '(      "gnu" . "http://elpa.gnu.org/packages/")       nil)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") nil)

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(package-refresh-contents)

;; install use-package if necessary
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; list of packages to install
(setq package-list '(
                     atomic-chrome
                     auto-complete
                     avy
                     cmake-mode
                     company
                     eglot
                     find-file-in-project
                     git-timemachine
                     helm
                     lsp-mode
                     magit
                     meson-mode
                     minimap
                     move-text
                     multiple-cursors
                     nix-mode
                     notmuch
                     notmuch-addr
                     popup
                     smartparens
                     transpose-frame
                     xclip
                     ))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(notmuch-saved-searches
   '((:name " unread" :query " tag:unread" :key [117])
     (:name "inbox" :query "tag:inbox not tag:trash" :key [105])
     (:name "flagged" :query "tag:flagged" :key [102])
     (:name "sent" :query "tag:sent" :key [115])
     (:name " all" :query "*" :key [97])
     (:name "drafts" :query "tag:draft" :key [100])))
 '(package-selected-packages
   '(atomic-chrome auto-complete avy cmake-mode company find-file-in-project
     git-timemachine helm lsp-mode magit meson-mode minimap move-text mu4easy
     multiple-cursors nix-mode notmuch rust-mode smartparens transpose-frame
     xclip))
 '(send-mail-function 'mailclient-send-it)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

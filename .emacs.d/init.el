;; turn off startscreen
(setq inhibit-startup-screen t)

;; turn off menubar
(menu-bar-mode 0)
(tool-bar-mode 0)
;(column-number-mode 1)

;; map backspace [delete-backward-char] to C-h
(define-key key-translation-map [?\C-?] [?\C-h])

;; map M-backspace [backward-kill-word] to M-h
(define-key key-translation-map [?\M-\d] [?\M-h])

;; map C-h to backspace
(define-key key-translation-map [?\C-h] [?\C-?])

;; map M-h [mark-paragraph] to M-backspace
(define-key key-translation-map [?\M-h] [?\M-\d])

;; turn off bell
(setq visible-bell nil)
(setq ring-bell-function 'ignore)



;; show line numbres
(global-display-line-numbers-mode)

;; m-x compile -> 
(setq compilation-auto-jump-to-first-error 1) 

;; autosave buffer to original file http://xahlee.info/emacs/emacs/emacs_auto_save.html
(defun xah-save-all-unsaved ()
  "Save all unsaved files. no ask. Version 2019-11-05"
  (interactive)
  (save-some-buffers t ))

(if (version< emacs-version "27")
    (add-hook 'focus-out-hook 'xah-save-all-unsaved)
  (setq after-focus-change-function 'xah-save-all-unsaved))

;; paakge manager? 
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(defvar rc/package-contents-refreshed nil)

(defun rc/package-refresh-contents-once ()
  (when (not rc/package-contents-refreshed)
    (setq rc/package-contents-refreshed t)
    (package-refresh-contents)))

(defun rc/require-one-package (package)
  (when (not (package-installed-p package))
    (rc/package-refresh-contents-once)
    (package-install package)))

(defun rc/require (&rest packages)
  (dolist (package packages)
    (rc/require-one-package package)))



;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;; Duplicate
(defun wrx/duplicate-line-or-region (beg end)
  "Implements functionality of JetBrains' `Command-d' shortcut for `duplicate-line'.
   BEG & END correspond point & mark, smaller first
   `use-region-p' explained: 
   http://emacs.stackexchange.com/questions/12334/elisp-for-applying-command-to-only-the-selected-region#answer-12335"
  (interactive "r")
  (if (use-region-p)
      (wrx/duplicate-region-in-buffer beg end)
    (wrx/duplicate-line-in-buffer)))

(defun wrx/duplicate-line-in-buffer ()
  "Duplicate current line, maintaining column position.
   |--------------------------+--------------------------|
   |          before          |          after           |
   |--------------------------+--------------------------|
   | lorem ipsum<POINT> dolor | lorem ipsum dolor        |
   |                          | lorem ipsum<POINT> dolor |
   |--------------------------+--------------------------|
   TODO: Save history for `Cmd-Z'
   Context: 
   http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs#answer-551053"
  (setq columns-over (current-column))
  (save-excursion
    (kill-whole-line)
    (yank)
    (yank))
  (let (v)
    (dotimes (n columns-over v)
      (right-char)
      (setq v (cons n v))))
  (next-line))

(global-set-key (kbd "C-c d") 'wrx/duplicate-line-or-region)


;; save frames and buffers at exit
(setq desktop-path '("~/.emacs.d"))
(desktop-save-mode 1)

;; patch for restore frames from here https://emacs.stackexchange.com/questions/19190/desktop-save-mode-fails-to-save-window-layout
(setq desktop-restore-forces-onscreen nil)
(add-hook 'desktop-after-read-hook
 (lambda ()
   (frameset-restore
    desktop-saved-frameset
    :reuse-frames (eq desktop-restore-reuses-frames t)
    :cleanup-frames (not (eq desktop-restore-reuses-frames 'keep))
    :force-display desktop-restore-in-current-display
    :force-onscreen desktop-restore-forces-onscreen)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(deeper-blue))
 '(custom-safe-themes
   '("3d2e532b010eeb2f5e09c79f0b3a277bfc268ca91a59cdda7ffd056b868a03bc" default))
 '(package-selected-packages '(multiple-cursors gruber-darker-theme smex move-text)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; path to backups files
(setq backup-directory-alist '(("." . "~/.emacs_saves")))

(rc/require 'ido)
(ido-mode t)
(ido-everywhere 1)
;;(ido-ubiquitous-mode 1)

;; smex
(global-set-key (kbd "M-x") 'smex)



;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(rc/require 'haskell-mode)


;; no tabs
(setq-default indent-tabs-mode nil)

(add-hook 'java-mode-hook (lambda ()
    (setq c-basic-offset 2)))

(setq compilation-ask-about-save nil)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;;;;;;;;;;;;;;;;;;;;;
; making it vim-like ;
;;;;;;;;;;;;;;;;;;;;;;

(require 'use-package)

(use-package projectile
  :init
  (progn
    (projectile-global-mode)
    (setq projectile-completion-system 'grizzl)
    ; annoying, this does not work at all, making ,pf USELESS and ,pg bad
    ; (add-to-list 'projectile-globally-ignored-files "*.~undo-tree~")
    ;(setq projectile-use-native-indexing t)
    )
  :config
  (progn
    (evil-leader/set-key "pf" 'projectile-find-file)
    (evil-leader/set-key "pa" 'projectile-ag)
    (evil-leader/set-key "pg" 'projectile-grep)
    (evil-leader/set-key "pk" 'projectile-kill-buffers)))

;(evil-leader/in-all-states) ; not working

(use-package evil
  :init
  (progn
    (evil-mode 1)
    (use-package evil-leader
      :init (global-evil-leader-mode)
      :config
      (progn
        (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
        (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
        (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
        (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
        (evil-leader/set-leader ",")
        (evil-leader/set-key ",d" 'delete-other-windows)
        (evil-leader/set-key "d"  'delete-window)))
    (use-package evil-paredit
      :init (add-hook 'paredit-mode-hook 'evil-paredit-mode))
    (use-package evil-surround
      :init (global-evil-surround-mode 1)
      :config
      (progn
        (add-to-list 'evil-surround-operator-alist '(evil-paredit-change . change))
        (add-to-list 'evil-surround-operator-alist '(evil-paredit-delete . delete)))
      ;http://permalink.gmane.org/gmane.emacs.vim-emulation/1816 is this better? I'd like to be able to do e.g.   d$   and have it preserve the ) at the EOL instead of just complaining
      ))
  :config
  (progn
    (setq evil-cross-lines t)
    (setq evil-move-cursor-back nil)
    (setq-default truncate-lines t)


    (evil-define-motion evil-forward-sexp (count)
      :type inclusive
      (if (paredit-in-string-p)
          (evil-forward-word-end count)
        (progn
          (if (looking-at ".\\s-\\|\\s)") (forward-char))
          (paredit-forward count)
          (backward-char))))

    (evil-define-motion evil-backward-sexp (count)
      :type inclusive
      (if (paredit-in-string-p)
          (evil-backward-word-begin)
        (paredit-backward count)))

    (evil-define-motion evil-forward-sexp-word (count)
      :type exclusive
      (if (paredit-in-string-p)
          (evil-forward-word-begin count)
        (progn (paredit-forward count)
               (skip-chars-forward "[:space:]"))))

    (define-key evil-motion-state-map "w" 'evil-forward-sexp-word)
    (define-key evil-motion-state-map "e" 'evil-forward-sexp)
    (define-key evil-motion-state-map "b" 'evil-backward-sexp)

    (define-key evil-normal-state-map (kbd "M-j" ) 'paredit-forward-slurp-sexp)
    (define-key evil-normal-state-map (kbd "M-h" ) 'paredit-backward-slurp-sexp)
    (define-key evil-normal-state-map (kbd "M-k" ) 'paredit-forward-barf-sexp)
    (define-key evil-normal-state-map (kbd "M-l" ) 'paredit-backward-barf-sexp)))

(setq undo-tree-auto-save-history t)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


;;;;;;;;;;;;;;;;;;
;; autocomplete ;;
;;;;;;;;;;;;;;;;;;

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;(use-package company
;  :init (global-company-mode)
;  :config
;  (progn
;    (defun indent-or-complete ()
;      (interactive)
;      (if (looking-at "\\_>")
;          (company-complete-common)
;        (indent-according-to-mode)))
;
;    (global-set-key "\t" 'indent-or-complete)))

;;;;;;;;;;;
; visuals ;
;;;;;;;;;;;

(load-theme 'solarized-dark t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-relative-line-numbers-mode) ; unfortunately breaks autocomplete

(let ((font "Menlo:pixelsize=24"))
  (set-face-attribute 'default nil :font font)
  (set-frame-font font nil t))

;;;;;;;;;;;
; clojure ;
;;;;;;;;;;;

; yasnippet (required for certain features of clj-refactor)
(use-package yasnippet
  :init
  (progn
    (yas-global-mode 1)
    (use-package clojure-snippets)))

(use-package paredit
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
    (add-hook 'clojure-mode-hook 'paredit-mode)))


;fixme change to use-package
(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (setq cljr-magic-requires nil) ; turned this off because it is _crazy_ slow even with an empty file!
                               (evil-leader/set-key "ral" 'cljr-add-missing-libspec)
                               (evil-leader/set-key "rai" 'cljr-add-import)
                               (evil-leader/set-key "rar" 'cljr-add-require)
                               ))


(use-package clojure-mode
  :mode ("\\.edn$" . clojure-mode)
  :init
  (progn
    (use-package cider
      :init
      (progn
        (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
        (add-hook 'cider-repl-mode-hook 'subword-mode)
        (use-package slamhound))
      :config
      (progn
        (setq nrepl-hide-special-buffers t)
        (setq cider-popup-stacktraces-in-repl t)
        (setq cider-repl-history-file "~/.emacs.d/nrepl-history")
        (setq cider-repl-pop-to-buffer-on-connect nil)
        (setq cider-repl-use-clojure-font-lock t)
        (setq cider-auto-select-error-buffer nil)
        (setq cider-prompt-save-file-on-load nil))))
  :config
  (progn
    (global-set-key [f9] 'cider-jack-in)

    (setq clojure--prettify-symbols-alist
          '(("fn"  . ?λ)
            ("comp" . ?∘)
            ("filter" . ?Ƒ)
            ("not=" . ?≠)
            ("some" . ?∃)
            ("none?" . ?∄)
            ("map" . ?∀)
            ("true" . ?𝐓)
            ("false" . ?𝐅)
            ("->" . ?→)
            ("cons" . ?«)
            ("->>" . ?⇒)
            ("and" . ?∧)
            ("or" . ?∨)
            ("<=" . ?≤)
            (">=" . ?≥)
            ("<!" . ?⪡)
            (">!" . ?⪢ )
            ("<!!" . ?⫷ )
            (">!!" . ?⫸ )
            ;("" . ?◉ )
            ;("" . ?⧬ )
            ;("" . ?⧲ )
            ("partial" . ?⋈ )
            ;("" . ?⚇ )
            ;("" . ?◍ )
            ;⟅ ⟆ ⦓ ⦔ ⦕ ⦖ ⸦ ⸧ ⸨ ⸩ ｟ ｠ ⧘ ⧙ ⧚ ⧛ ︷ ︸
            ;∾ ⊺ ⋔ ⫚ ⟊ ⟔ ⟓ ⟡ ⟢ ⟣ ⟤ ⟥
            ("loop" . ?◎ )
            ("recur" . ?◉ )
            ("reduce" . ?∑ )
            ("chan" . ?≋ )
            ;("" . ? )
            ("complement" . ?∁)
            ("identical?" . ?≡)))

    (defun toggle-nrepl-buffer ()
      "Toggle the nREPL REPL on and off"
      (interactive)
      (if (string-match "cider-repl" (buffer-name (current-buffer)))
          (delete-window)
        (cider-switch-to-relevant-repl-buffer)))

    (defun cider-project-reset ()
      (interactive)
      (cider-interactive-eval "(reloaded.repl/reset)"))

    (evil-leader/set-key "eb" 'cider-eval-buffer)
    (evil-leader/set-key "ee" 'cider-eval-last-sexp)
    (evil-leader/set-key "er" 'cider-eval-region)
    (evil-leader/set-key "ef" 'cider-eval-defun-at-point)

    (evil-leader/set-key "cd" 'cider-doc)
    (evil-leader/set-key "cc" 'cider-connect)
    (evil-leader/set-key "ct" 'cider-test-run-tests)
    (evil-leader/set-key "cr" 'toggle-nrepl-buffer)
    (evil-leader/set-key "cR" 'cider-project-reset)))

(dolist (mode '(clojure-mode clojurescript-mode cider-mode))
  (eval-after-load mode
    (font-lock-add-keywords
     mode '(("(\\(fn\\)[\[[:space:]]"  ; anon funcs 1
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "λ")
                       nil)))
            ("\\(#\\)("                ; anon funcs 2
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "ƒ")
                       nil)))
            ("\\(#\\){"                 ; sets
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "∈")
                       nil)))))))

(add-hook 'emacs-lisp-mode-hook 'prettify-symbols-mode)
(add-hook 'clojure-mode-hook 'prettify-symbols-mode)


;;;;;;;;;;;;;;;;;;;
; custom set crap ;
;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

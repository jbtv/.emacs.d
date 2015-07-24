
(defun set-evil-magit-bindings ()
					; the main differences of this magit-mode-map AOT the one from magit.el are:
					; instead of starting with a (make-keymap) we start by copying the evil-motion-state-map
					; also define "," as evil-leader--default-map to allow leader commands to work in magit modes
					; all the magit-*-mode maps have this as their parent still
					; I began by commenting out every define-key (since some of them clobber evil motion bindings)
					; then started enabling them again a few at a time and see how it feels
					; if I find one for which there is a more intuitive binding for vim lovers, I change it from the magit default
					; if I find one which definitely clobbers a binding in a way that I think will confuse vim lovers, I change it to keep it at least fairly free of awful surprises
					; OTHERWISE I leave the binding alone to keep the differences minimal
					; this process is ongoing, at this point lots of important magit commands are still unavailable
  (defvar magit-mode-map
    (let ((map (copy-keymap evil-motion-state-map)))
      (define-key map "," evil-leader--default-map)
      (define-key map (kbd "C-n") 'magit-goto-next-section)
      (define-key map (kbd "C-p") 'magit-goto-previous-section)
      (define-key map (kbd "^") 'magit-goto-parent-section)
                                        ;(define-key map (kbd "C-n") 'magit-goto-next-sibling-section)
                                        ;(define-key map (kbd "C-p") 'magit-goto-previous-sibling-section)
      (define-key map (kbd "TAB") 'magit-section-toggle) 
      (define-key map (kbd "<backtab>") 'magit-expand-collapse-section)
                                        ;(define-key map (kbd "1") 'magit-show-level-1)
                                        ;(define-key map (kbd "2") 'magit-show-level-2)
                                        ;(define-key map (kbd "3") 'magit-show-level-3)
                                        ;(define-key map (kbd "4") 'magit-show-level-4)
                                        ;(define-key map (kbd "M-1") 'magit-show-level-1-all)
                                        ;(define-key map (kbd "M-2") 'magit-show-level-2-all)
                                        ;(define-key map (kbd "M-3") 'magit-show-level-3-all)
                                        ;(define-key map (kbd "M-4") 'magit-show-level-4-all)
                                        ;(define-key map (kbd "M-h") 'magit-show-only-files)
                                        ;(define-key map (kbd "M-H") 'magit-show-only-files-all)
                                        ;(define-key map (kbd "M-s") 'magit-show-level-4)
                                        ;(define-key map (kbd "M-S") 'magit-show-level-4-all)
                                        ;(define-key map (kbd "g") 'magit-refresh)
      (define-key map (kbd "C-,") 'magit-refresh-all)
                                        ;(define-key map (kbd "?") 'magit-key-mode-popup-dispatch)
                                        ;(define-key map (kbd ":") 'magit-git-command)
                                        ;(define-key map (kbd "C-x 4 a") 'magit-add-change-log-entry-other-window)
                                        ;(define-key map (kbd "L") 'magit-add-change-log-entry)
      (define-key map (kbd "RET") 'magit-diff-visit-file)
      (define-key map (kbd "<C-return>") 'magit-diff-visit-file-worktree)
                                        ;(define-key map (kbd "C-<return>") 'magit-dired-jump)
                                        ;(define-key map (kbd "SPC") 'magit-show-item-or-scroll-up)
                                        ;(define-key map (kbd "DEL") 'magit-show-item-or-scroll-down)
                                        ;(define-key map (kbd "C-w") 'magit-copy-item-as-kill)

                                        ; I am going to ignore magit-rigid-key-bindings for now
                                        ; the behavior I want for evil-magit is "rigid" in this way ... no popup

                                        ;(cond (magit-rigid-key-bindings

      (define-key map (kbd ",,c") 'magit-commit)
      (define-key map (kbd ",,ac") 'magit-commit-amend)
                                        ;       (define-key map (kbd "m") 'magit-merge)
                                        ;       (define-key map (kbd "b") 'magit-checkout)
                                        ;       (define-key map (kbd "M") 'magit-branch-manager)
                                        ;       (define-key map (kbd "r") 'undefined)
      (define-key map (kbd ",,f") 'magit-fetch-current)
      (define-key map (kbd ",,F") 'magit-pull)
                                        ;       (define-key map (kbd "J") 'magit-apply-mailbox)
                                        ;       (define-key map (kbd "!") 'magit-git-command-topdir)
      (define-key map (kbd ",,ps") 'magit-push)
      (define-key map (kbd ",,t") 'magit-tag)
      (define-key map (kbd ",,l") 'magit-log)
                                        ;       (define-key map (kbd "o") 'magit-submodule-update)
                                        ;       (define-key map (kbd "B") 'undefined)
      (define-key map (kbd ",,,s") 'magit-stash) ; for me to see what the popup stuff is like
      
                                        ;(define-key map (kbd "<C-return>") 'magit-key-mode-popup-committing) ; change to git-commit-commit ?

                                        ;      (t
                                        ;       (define-key map (kbd "c") 'magit-key-mode-popup-committing)
                                        ;       (define-key map (kbd "m") 'magit-key-mode-popup-merging)
                                        ;       (define-key map (kbd "b") 'magit-key-mode-popup-branching)
                                        ;       (define-key map (kbd "M") 'magit-key-mode-popup-remoting)
                                        ;       (define-key map (kbd "r") 'magit-key-mode-popup-rewriting)
                                        ;       (define-key map (kbd "f") 'magit-key-mode-popup-fetching)
                                        ;       (define-key map (kbd "F") 'magit-key-mode-popup-pulling)
                                        ;       (define-key map (kbd "J") 'magit-key-mode-popup-apply-mailbox)
                                        ;       (define-key map (kbd "!") 'magit-key-mode-popup-running)
                                        ;       (define-key map (kbd "P") 'magit-key-mode-popup-pushing)
                                        ;       (define-key map (kbd "t") 'magit-key-mode-popup-tagging)
                                        ;       (define-key map (kbd "l") 'magit-key-mode-popup-logging)
                                        ;       (define-key map (kbd "o") 'magit-key-mode-popup-submodule)
                                        ;       (define-key map (kbd "B") 'magit-key-mode-popup-bisecting)
                                        ;       (define-key map (kbd "z") 'magit-key-mode-popup-stashing)))
      (define-key map ",vl" 'magit-process ) ; FIXME integrate with evil-leader, not everyone uses ","
                                        ;(define-key map (kbd "E") 'magit-interactive-rebase)
                                        ;(define-key map (kbd "R") 'magit-rebase-step)
                                        ;(define-key map (kbd "e") 'magit-ediff)
      (define-key map (kbd ",,w") 'magit-wazzup)
                                        ;(define-key map (kbd "y") 'magit-cherry)
                                        ;(define-key map (kbd "q") 'magit-mode-quit-window)
      (define-key map (kbd ",,,r") 'magit-reset-head-hard)
      (define-key map (kbd ",,r") 'magit-reset-head)
      (define-key map (kbd ",r") 'magit-revert-item)
      (define-key map (kbd ",a") 'magit-apply-item)
      (define-key map (kbd ",cp") 'magit-cherry-pick-item)
                                        ;(define-key map (kbd "d") 'magit-diff-working-tree)
                                        ;(define-key map (kbd "D") 'magit-diff)
      (define-key map (kbd "[") 'magit-diff-less-context)
      (define-key map (kbd "]") 'magit-diff-more-context)
      (define-key map (kbd "}") 'magit-diff-default-context)
      
                                        ;(define-key map (kbd "h") 'magit-key-mode-popup-diff-options)
                                        ;(define-key map (kbd "H") 'magit-diff-toggle-refine-hunk)

                                        ; this one clobbers evil-sp-change-whole-line
      (define-key map (kbd "S") 'magit-stage-all)

      (define-key map (kbd "U") 'magit-unstage-all)

                                        ; clobbers sp-backward-delete-char
      (define-key map (kbd "X") 'magit-reset-working-tree)

                                        ;(define-key map (kbd "C-c C-c") 'magit-key-mode-popup-dispatch)
                                        ;(define-key map (kbd "C-c C-e") 'magit-key-mode-popup-dispatch)
      map)
    "BLAKE's EVIL Parent keymap for all keymaps of modes derived from `magit-mode'.")  

  (defvar magit-blame-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
      (define-key map (kbd "C-p") 'magit-go-backward) ; experiment...
      (define-key map (kbd "C-n") 'magit-go-forward)
      (define-key map (kbd "RET") 'magit-blame-locate-commit)
                                        ;(define-key map (kbd "DEL") 'scroll-down)
                                        ;(define-key map (kbd "j") 'magit-jump-to-diffstats)
      map)
    "Keymap for `magit-blame-mode'.")

  (defvar magit-diff-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
      map)
    "Keymap for `magit-stash-mode'.")

  (defvar magit-file-section-map
    (let ((map (make-sparse-keymap)))
      (define-key map [C-return] 'magit-diff-visit-file-worktree)
      (define-key map "\r" 'magit-diff-visit-file)
      ;; (define-key map "a"  'magit-apply)
      ;; (define-key map "k"  'magit-discard)
      ;; (define-key map "K"  'magit-file-untrack)
      ;; (define-key map "R"  'magit-file-rename)
      ;; (define-key map "s"  'magit-stage)
      ;; (define-key map "u"  'magit-unstage)
      ;; (define-key map "v"  'magit-reverse)
      map)
    "Keymap for `magit-file-section'.")

  (defvar magit-hunk-section-map
    (let ((map (make-sparse-keymap)))
      (define-key map [C-return] 'magit-diff-visit-file-worktree)
      (define-key map "\r" 'magit-diff-visit-file)
      ;; (define-key map "a"  'magit-apply)
      ;; (define-key map "C"  'magit-commit-add-log) ;; interesting! tryme
      ;; (define-key map "k"  'magit-discard)
      ;; (define-key map "s"  'magit-stage)
      ;; (define-key map "u"  'magit-unstage)
      ;; (define-key map "v"  'magit-reverse)
      map)
    "Keymap for `hunk' sections.") 

  (defvar magit-unstaged-section-map
    (let ((map (make-sparse-keymap)))
      ;; (define-key map "\r" 'magit-diff-unstaged)
      ;; (define-key map "k"  'magit-discard)
      ;; (define-key map "s"  'magit-stage)
      ;; (define-key map "u"  'magit-unstage)
      map)
    "Keymap for the `unstaged' section.") 

  (defvar magit-staged-section-map
    (let ((map (make-sparse-keymap)))
      ;; (define-key map "\r" 'magit-diff-staged)
      ;; (define-key map "k"  'magit-discard)
      ;; (define-key map "s"  'magit-stage)
      ;; (define-key map "u"  'magit-unstage)
      ;; (define-key map "v"  'magit-reverse)
      map)
    "Keymap for the `staged' section.") 

  (defvar magit-untracked-section-map
    (let ((map (make-sparse-keymap)))
      ;; (define-key map "k"  'magit-discard)
      ;; (define-key map "s"  'magit-stage)
      map)
    "Keymap for `magit-untracked-section'.")

  (defvar magit-tag-section-map
    (let ((map (make-sparse-keymap)))
      ;; (define-key map "\r" 'magit-visit-ref)
      ;; (define-key map "k"  'magit-tag-delete)
      map)
    "Keymap for `magit-tag-section'.")  

  (defvar magit-stash-section-map
    (let ((map (make-sparse-keymap)))
      (define-key map "TAB" 'magit-stash-show)
      (define-key map "a"  'magit-stash-apply)
      (define-key map "A"  'magit-stash-pop)
      (define-key map "d"  'magit-stash-drop)
      map)
    "Keymap for `stash' sections.") 

  (defvar magit-stashes-section-map
    (let ((map (make-sparse-keymap)))
      ;; (define-key map "k"  'magit-stash-clear)
      map)
    "Keymap for `stashes' section.")

  (defvar magit-commit-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
      (define-key map (kbd "C-p") 'magit-go-backward) ; experiment...
      (define-key map (kbd "C-n") 'magit-go-forward)
                                        ;(define-key map (kbd "SPC") 'scroll-up)
                                        ;(define-key map (kbd "DEL") 'scroll-down)
                                        ;(define-key map (kbd "j") 'magit-jump-to-diffstats)
      map)
    "Keymap for `magit-commit-mode'.")  ;; from older magit ... checkme

  (eval-after-load "git-commit-mode"
    '(define-key git-commit-mode-map (kbd "<C-return>") 'with-editor-finish))
  
  (defvar magit-section-jump-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "z") 'magit-jump-to-stashes)
      (define-key map (kbd "n") 'magit-jump-to-untracked)
      (define-key map (kbd "u") 'magit-jump-to-unstaged)
      (define-key map (kbd "s") 'magit-jump-to-staged)
      (define-key map (kbd "f") 'magit-jump-to-unpulled)
      (define-key map (kbd "p") 'magit-jump-to-unpushed)
      (define-key map (kbd "d") 'magit-jump-to-diffstat-or-diff)
      map)
    "Submap for jumping to sections in `magit-status-mode'.")

  (defvar magit-status-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
      
      (define-key map (kbd "s") 'magit-stage)
      (define-key map (kbd "u") 'magit-unstage)
      (define-key map (kbd "d") 'magit-discard)
      (define-key map (kbd "i") 'magit-gitignore)
      (define-key map (kbd "I") 'magit-gitignore-locally)

                                        ; I _think_ this will be a good tradeoff
                                        ; clobbers whatever "g" is in evil-motion ... describe-key wont tell me because it's a prefix
      (define-key map (kbd "g") 'magit-section-jump-map)
      
      (define-key map (kbd ".") 'magit-mark-item)
      (define-key map (kbd "=") 'magit-diff-with-mark)
                                        ;(define-key map (kbd "C") 'magit-commit-add-log)
      map)
    "Keymap for `magit-status-mode'.") 

  (defvar magit-log-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
                                        ;(define-key map (kbd ".") 'magit-mark-item)
                                        ;(define-key map (kbd "=") 'magit-diff-with-mark)
                                        ;(define-key map (kbd "e") 'magit-log-show-more-entries)
                                        ;(define-key map (kbd "h") 'magit-log-toggle-margin)
      map)
    "Keymap for `magit-log-mode'.")
  
  (defvar magit-cherry-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
      map)
    "Keymap for `magit-cherry-mode'.")
  
  (defvar magit-reflog-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-log-mode-map)
      map)
    "Keymap for `magit-reflog-mode'.")
  
  (defvar magit-diff-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
      (define-key map (kbd "C-p") 'magit-go-backward)
      (define-key map (kbd "C-n") 'magit-go-forward)
                                        ;(define-key map (kbd "SPC") 'scroll-up)
                                        ;(define-key map (kbd "DEL") 'scroll-down)
                                        ;(define-key map (kbd "j") 'magit-jump-to-diffstats)
      map)
    "Keymap for `magit-diff-mode'.")
  
  (defvar magit-wazzup-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
                                        ;(define-key map (kbd ".") 'magit-mark-item)
                                        ;(define-key map (kbd "=") 'magit-diff-with-mark)
                                        ;(define-key map (kbd "i") 'magit-ignore-item)
      map)
    "Keymap for `magit-wazzup-mode'.")
  
  (defvar magit-branch-manager-mode-map ; INTERESTING play with this
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
                                        ;(define-key map (kbd "c") 'magit-create-branch)
                                        ;(define-key map (kbd "a") 'magit-add-remote)
                                        ;(define-key map (kbd "r") 'magit-rename-item)
                                        ;(define-key map (kbd "k") 'magit-discard-item)
                                        ;(define-key map (kbd "T") 'magit-change-what-branch-tracks)
      map)
    "Keymap for `magit-branch-manager-mode'.")

  (defvar magit-branch-section-map
    (let ((map (make-sparse-keymap)))
      ;; (define-key map "\r" 'magit-visit-ref)
      ;; (define-key map "k"  'magit-branch-delete)
      ;; (define-key map "R"  'magit-branch-rename)
      map)
    "Keymap for `branch' sections.")
  
  (defvar magit-process-mode-map
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map magit-mode-map)
      map)
    "Keymap for `magit-process-mode'.")
  
  
  )

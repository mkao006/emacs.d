;; Source :
;; https://www.youtube.com/watch?v=UFPD7icMoHY
;; https://gist.github.com/ntBre/34e3d2daad59040b4549cd8057f304c3

(require 'lsp-mode)
(require 'yasnippet)
(require 'use-package)                            ; Once it's installed, we load it using require


(use-package lsp-mode
  :ensure t
  :bind (:map lsp-mode-map
              ("C-c d" . lsp-describe-thing-at-point)
              ("C-c a" . lsp-execute-code-action))
  :bind-keymap ("C-c l" . lsp-command-map)
  :config
  (lsp-enable-which-key-integration t)
  )


;; link compile to go build , test, vet
(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  ;; (local-set-key (kbd "M-.") 'godef-jump)
  ;; (local-set-key (kbd "M-*") 'pop-tag-mark)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)

;;; Go
(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
         (go-mode . company-mode)
         (go-mode . yas-minor-mode))
  :bind (:map go-mode-map
              ("M-q" . gofmt))
  :config
  ;; (require 'lsp-go)
  ;; ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
  ;; (setq lsp-go-analyses
  ;;       '((fieldalignment . t)
  ;;         (nilness        . t)
  ;;         (unusedwrite    . t)
  ;;         (unusedparams   . t)))
  ;; GOPATH/bin
  (add-to-list 'exec-path "~/go/bin")
  ;; requires goimports to be installed
  ;; (setq gofmt-command "goimports"))
  )

(provide 'init-go)
;;; init-go.el ends here

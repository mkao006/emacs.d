;;; package --- Summary
;; (use-package go-mode
;;              :ensure t
;;              :hook ((go-mode . lsp-deffered)
;;                     (go-mode . company-mode))
;;              :config
;;              (require 'lsp-go)
;;              (add-to-list exec-path "~/go/bin/")
;;              )





;; enable company mode for autocompletion
;; (add-hook 'go-mode-hook (lambda ()
;;                           (set (make-local-variable 'company-backends) '(gopls))
;;                           (company-mode)))

;; ;; enable flycheck
;;   (add-hook 'go-mode-hook 'flycheck-mode)


;; ;;company mode setting
;; (require 'company)                                   ; load company mode
;; (require 'company-go)                                ; load company mode go backend
;; (setq company-idle-delay 0)
;; (setq company-minimum-prefix-length 1)
;; ;; enable company mode for autocompletion
;; (add-hook 'go-mode-hook (lambda ()
;;                           (set (make-local-variable 'company-backends) '(company-go))
;;                           (company-mode)))





;; (add-hook 'go-mode-hook #'lsp-deferred)

;; ;; Set up before-save hooks to format buffer and add/delete imports.
;; ;; Make sure you don't have other gofmt/goimports hooks enabled.
;; (defun lsp-go-install-save-hooks ()
;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
;; (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; (require 'lsp-mode)
;; (add-hook 'go-mode-hook #'lsp-deferred)

;; ;; Set up before-save hooks to format buffer and add/delete imports.
;; ;; Make sure you don't have other gofmt/goimports hooks enabled.
;; (defun lsp-go-install-save-hooks ()
;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
;; (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)


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

;;; Go
(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
         (go-mode . company-mode)
         (go-mode . yas-minor-mode))
  ;; :bind (:map go-mode-map
  ;;             ("<f6>"  . gofmt)
  ;;             ("C-c 6" . gofmt))
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

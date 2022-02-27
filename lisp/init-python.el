;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; I use nix + direnv instead of virtualenv/pyenv/pyvenv, and it is an
;; approach which extends to other languages too. I recorded a
;; screencast about this: https://www.youtube.com/watch?v=TbIHRHy7_JM

(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment
    material-theme                  ;; Theme
    flycheck
    )
  )

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(setq python-shell-interpreter "python")
;; based on: https://adamoudad.github.io/posts/emacs/docker-python-shell-emacs/
;;
;; however, it results in "input device is not a tty" error. This
;; doesn't change even if we use the same image used in the original
;; source.
;;
;; (setq python-shell-interpreter "/Users/user/Git/mk_experiment/docker_interpretor/start_docker_interpretor.sh")

(require-package 'pip-requirements)

(when (maybe-require-package 'anaconda-mode)
  (with-eval-after-load 'python
    ;; Anaconda doesn't work on remote servers without some work, so
    ;; by default we enable it only when working locally.
    (add-hook 'python-mode-hook
              (lambda () (unless (file-remote-p default-directory)
                           (anaconda-mode 1))))
    (add-hook 'anaconda-mode-hook
              (lambda ()
                (anaconda-eldoc-mode (if anaconda-mode 1 0)))))
  (with-eval-after-load 'anaconda-mode
    (define-key anaconda-mode-map (kbd "M-?") nil))
  (when (maybe-require-package 'company-anaconda)
    (with-eval-after-load 'company
      (with-eval-after-load 'python
        (add-to-list 'company-backends 'company-anaconda)))))

(when (maybe-require-package 'toml-mode)
  (add-to-list 'auto-mode-alist '("poetry\\.lock\\'" . toml-mode)))

;; (when (maybe-require-package 'reformatter)
;;   (reformatter-define black :program "black"))

;; disable warning when starting python-interpreter
;; (setq python-shell-completion-native-enable 0)
(setq python-shell-completion-native-enable nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "python")

;; enable eldoc mode
(add-hook 'python-mode-hook '(lambda () (eldoc-mode 1)) t)

;; Enable elpy
(require 'pyenv-mode-auto)
(elpy-enable)
;; (setenv "WORKON_HOME" "~/.pyenv/versions/")
;; (setq elpy-rpc-backend "jedi")
;; (setq python-shell-interpreter "~/.pyenv/shims/python3")
;; (setq elpy-rpc-python-command "~/.pyenv/shims/python3")
;; (setq elpy-rpc-python-command 'current)
;; (setq elpy-rpc-virtualenv-path "~/.pyenv/versions/plan-scorer-data-pipeline")
;; (setq elpy-rpc-virtualenv-path "/usr/local/Cellar/pyenv-virtualenv/1.1.5/shims")

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; (use-package elpy
;;    :config
;;    (package-initialize)
;;    (elpy-enable)
;;    (setenv "WORKON_HOME" "~/.pyenv/versions/")
;;    (setq elpy-rpc-backend "jedi")
;;    (setq python-shell-interpreter "~/.pyenv/shims/python3")
;;  )

(provide 'init-python)
;;; init-python.el ends here


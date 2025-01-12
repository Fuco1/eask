;;; core/compile.el --- Byte compile all Emacs Lisp files in the package  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Byte compile all Emacs Lisp files in the package
;;
;;   $ eask compile [names..]
;;
;;
;;  Initialization options:
;;
;;    [names..]     specify files to byte-compile
;;

;;; Code:

(let ((dir (file-name-directory (nth 1 (member "-scriptload" command-line-args)))))
  (load (expand-file-name "_prepare.el"
                          (locate-dominating-file dir "_prepare.el"))
        nil t))

;; Handle options
(add-hook 'eask-before-command-hook
          (lambda ()
            (when (eask-strict-p) (setq byte-compile-error-on-warn t))
            (when (= eask-verbosity 4) (setq byte-compile-verbose t))))

(defconst eask-compile-log-buffer-name "*Compile-Log*"
  "Byte-compile log buffer name.")

(defun eask--print-compile-log ()
  "Print `*Compile-Log*' buffer."
  (when (get-buffer eask-compile-log-buffer-name)
    (with-current-buffer eask-compile-log-buffer-name
      (eask-print-log-buffer)
      (eask-msg ""))))

(defun eask--byte-compile-file (filename)
  "Byte compile FILENAME."
  ;; *Compile-Log* does not kill itself. Make sure it's clean before we do
  ;; next byte-compile task.
  (ignore-errors (kill-buffer eask-compile-log-buffer-name))
  (let* ((filename (expand-file-name filename))
         (result))
    (eask-with-progress
      (unless byte-compile-verbose (format "Compiling %s... " filename))
      (eask-with-verbosity 'debug
        (setq result (byte-compile-file filename)
              result (eq result t)))
      (if result "done ✓" "skipped ✗"))
    (eask--print-compile-log)
    result))

(defun eask--compile-files (files)
  "Compile sequence of FILES."
  (let* ((compiled (cl-remove-if-not #'eask--byte-compile-file files))
         (compiled (length compiled))
         (skipped (- (length files) compiled)))
    ;; XXX: Avoid last newline from the log buffer!
    (unless (get-buffer eask-compile-log-buffer-name)
      (eask-msg ""))
    (eask-info "(Total of %s file%s compiled, %s skipped)" compiled
               (eask--sinr compiled "" "s")
               skipped)))

(eask-start
  (eask-defvc< 27 (eask-pkg-init))  ; XXX: remove this after we drop 26.x
  (let* ((patterns (eask-args))
         (files (if patterns
                    (eask-expand-file-specs patterns)
                  (eask-package-el-files))))
    (cond
     ;; Files found, do the action!
     (files
      (eask--compile-files files))
     ;; Pattern defined, but no file found!
     (patterns
      (eask-info "No files found with wildcard pattern: %s"
                 (mapconcat #'identity patterns " ")))
     ;; Default, print help!
     (t
      (eask-info "(No files have been compiled)")
      (eask-help "core/compile")))))

;;; core/compile.el ends here

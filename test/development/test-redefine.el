;;; test-redefine.el --- Test redefine  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Test the concatened file built from `eask concat`.
;;
;; We are only going to check for rule `redefine', since this isn't a regular
;; Emacs package.
;;

;;; Code:

(setq byte-compile-error-on-warn t)

(let* ((concated-file "./dist/eask.built.el")
       (concated-file (expand-file-name concated-file))
       (conditions "
;; Local Variables:
;; coding: utf-8
;; byte-compile-warnings: (redefine)
;; End:
"))
  (with-current-buffer (find-file concated-file)
    (unless (string-suffix-p conditions (buffer-string))
      (goto-char (point-max))
      (insert conditions))
    (byte-compile-file buffer-file-name)))

;;; test-redefine.el ends here

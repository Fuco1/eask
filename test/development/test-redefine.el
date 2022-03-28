;;; test-redefine.el --- Test redefine  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;;
;;

;;; Code:

(let ((concated-file "./dist/eask.built.el"))
  (write-region
   "
;; Local Variables:
;; byte-compile-warnings: (redefine)
;; End:
" nil concated-file t)

  (byte-compile-file concated-file))

;;; test-redefine.el ends here
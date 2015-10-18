(in-package :cl-user)
(defpackage cl-dbc-lclj
  (:use :cl
        :optima)
  (:import-from :alexandria
                :with-gensyms))
(in-package :cl-dbc-lclj)

(cl-syntax:use-syntax :annot)

(defmacro make-asserts (asserts)
  (cond ((consp asserts)
         `(progn
            ,@(loop :for a :in asserts :collect
                    `(assert ,a))))
        (t nil)))

@export
(defmacro with-dbc (conds &body body)
  (let ((pre (match conds
               ((property :pre pre-conds) pre-conds)
               (otherwise t)))
        (post (match conds
                ((property :post post-conds) post-conds)
                (otherwise t))))
    `(progn
       (make-asserts ,pre)
       (funcall #'(lambda (%)
                    (make-asserts ,post)
                    %)
                (progn
                  ,@body)))))

;; (with-dbc
;;     (:pre  ((not (zerop n)) (numberp n))
;;      :post ((plusp %) (numberp %)))
;;   (* n n))
;;
;; =>
;; (progn
;;   (progn
;;     (assert (not (zerop n)))
;;     (assert (numberp n)))
;;   (funcall #'(lambda (%)
;;                (progn
;;                  (assert (plusp %))
;;                  (assert (numberp %))))
;;            (* n n)))

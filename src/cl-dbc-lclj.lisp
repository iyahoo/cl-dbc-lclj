(in-package :cl-user)
(defpackage cl-dbc-lclj
  (:use :cl
        :optima))
(in-package :cl-dbc-lclj)

(cl-syntax:use-syntax :annot)

(defmacro make-asserts (asserts)
  (cond
    ((consp asserts)
     `(progn
        ,@(loop :for a :in asserts
                :collect `(assert ,a))))
    (t nil)))

@export
(defmacro with-dbc (conds &body body)
  "stands for with design by contract."
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

@export
(defmacro defunc (name args conds &body body)
  "stands for defun with contract."
  `(defun ,name ,args
     (with-dbc ,conds
       ,@body)))

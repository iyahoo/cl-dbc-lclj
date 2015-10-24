(in-package :cl-user)
(defpackage cl-dbc-lclj
  (:use :cl))
(in-package :cl-dbc-lclj)

(cl-syntax:use-syntax :annot)

(defmacro make-asserts (asserts)
  (cond
    ((consp asserts)
     `(progn
        ,@(loop :for a :in asserts
                :collect `(assert ,a))))
    (t nil)))

(defun property (key lst)
  (let* ((pos (position key lst)))
    (when (numberp pos)
      (car (nthcdr (1+ pos) lst)))))

@export
(defmacro with-dbc (conds &body body)
  "stands for with design by contract."
  (let ((pre (property :pre conds))
        (post (property :post conds)))
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

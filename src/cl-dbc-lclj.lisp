(in-package :cl-user)
(defpackage cl-dbc-lclj
  (:use :cl)
  (:export #:%))
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
       (let ((% (progn ,@body)))
         (make-asserts ,post)
         %))))

@export
(defmacro defunc (name args str-or-conds conds-or-body1 &body body)
  "stands for defun with contract. Defunc can use documentation string such as defun."
  (if (stringp str-or-conds)
      (let ((str str-or-conds)          ; change symbol name, so
            (conds conds-or-body1))     ; (setf (symbol-value 'str) str-or-conds) is better?
        `(defun ,name ,args
           ,str
           (with-dbc ,conds
             ,@body)))
      (let ((conds str-or-conds)
            (body1 conds-or-body1))
        `(defun ,name ,args
           (with-dbc ,conds
             ,body1
             ,@body)))))

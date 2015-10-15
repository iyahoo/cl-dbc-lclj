(in-package :cl-user)
(defpackage cl-dbc-lclj
  (:use :cl
        :optima))
(in-package :cl-dbc-lclj)


;; (with-dbc-checked
;;     (:pre  ((not (zerop n)) (numberp n))
;;      :post ((plusp %) (numberp %)))
;;   (* n n))

(defmacro with-dbc-checked (pre post &body body)
  `(progn
     (assert (and ,@pre))
     (funcall #'(lambda (%)
                  (assert (and ,@post))
                  %)
              (progn
                ,@body))))

(defun test-add (x y)
  (with-dbc-checked ((not (= x 0)) (< y 100) (and (oddp x) (evenp y))) ((not (= 0 %)))
    (+ x y)))

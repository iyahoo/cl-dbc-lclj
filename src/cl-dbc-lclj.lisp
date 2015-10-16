(in-package :cl-user)
(defpackage cl-dbc-lclj
  (:use :cl
   :optima
   :alexandria))
(in-package :cl-dbc-lclj)

(defmacro with-dbc (pre post &body body)
  `(progn
     (assert (and ,@pre))
     (funcall #'(lambda (%)
                  (assert (and ,@post))
                  %)
              (progn
                ,@body))))

;; (with-dbc
;;     ((not (zerop n)) (numberp n))
;;     ((plusp %) (numberp %))
;;   (* n n))
;;
;; =>
;; (PROGN
;;   (ASSERT (AND (NOT (ZEROP N)) (NUMBERP N)))
;;   (FUNCALL #'(LAMBDA (%)
;;                (ASSERT (AND (PLUSP %) (NUMBERP %)))
;;                %)
;;            (PROGN (* N N))))

;; (defmacro with-dbc (conds &body body)
;;   `(progn
;;      (with-gensyms (i pre post)
;;        (let ((pre (match conds
;;                     ((property :pre ))))))
;;        ,@(loop :for i :in conds :collect
;;                `(assert i)))
;;      (funcall #'(lambda (%)
;;                   (assert (and ,@post))
;;                   %)
;;               (progn
;;                 ,@body))))

;; (with-dbc
;;     (:pre  ((not (zerop n)) (numberp n))
;;      :post ((plusp %) (numberp %)))
;;   (* n n))
;;
;; =>
;; (progn
;;   (assert (not (zerop n)))
;;   (assert (numberp n))
;;   (funcall #'(lambda (%)
;;                (assert (plusp %))
;;                (assert (numberp %)))
;;            (* n n)))

(defun test-add (x y)
  (with-dbc
      ((not (= x 0)) (< y 100) (and (oddp x) (evenp y)))
      ((not (= 0 %)))
    (+ x y)))

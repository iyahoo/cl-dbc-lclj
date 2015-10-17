(in-package :cl-user)
(defpackage cl-dbc-lclj
  (:use :cl
   :optima
   :alexandria))
(in-package :cl-dbc-lclj)

;; (defmacro with-dbc (pre post &body body)
;;   `(progn
;;      (assert (and ,@pre))
;;      (funcall #'(lambda (%)
;;                   (assert (and ,@post))
;;                   %)
;;               (progn
;;                 ,@body))))

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

(defmacro make-asserts (asserts)
  (cond ((consp asserts)
         `(progn
            ,@(loop :for a :in asserts :collect
                    `(assert ,a))))
        (t nil)))

;; Don't work
(defmacro with-dbc (conds &body body)
  (with-gensyms (pre post)
    `(progn
       (let ((,pre (match ,conds
                     ((property :pre pre-conds) pre-conds)
                     (otherwise t)))
             (,post (match ,conds
                      ((property :post post-conds) post-conds)
                      (otherwise t)))))
       ,(print pre)
       ,(make-asserts pre)
       (funcall #'(lambda (%)
                    ,(make-asserts post)
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
